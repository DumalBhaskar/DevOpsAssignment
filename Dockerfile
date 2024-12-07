
FROM python:3.9-alpine3.13

WORKDIR /app

COPY requirements.txt /app

RUN pip install -r requirements.txt python-dotenv

COPY . /app

ENV FLASK_APP=app.py

ENV FLASK_RUN_HOST=0.0.0.0

EXPOSE 5000

CMD ["flask", "run"]
-------------------------

FROM python:3.9-alpine3.13

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory
WORKDIR /app

# Copy and install application dependencies
COPY requirements.txt /app

# Create a virtual environment
RUN python -m venv /venv && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt python-dotenv

# Copy the rest of the application files
COPY . /app

# Set permissions for the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Set environment variables for Flask and the virtual environment
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV PATH="/venv/bin:$PATH"

# Expose the application port
EXPOSE 5000

# Command to run the application
CMD ["flask", "run"]

------------------------------------
# Stage 1: Build dependencies and application setup
FROM python:3.9-alpine3.13 AS builder

# Install system dependencies required for Python and virtualenv
RUN apk add --no-cache curl gcc musl-dev libffi-dev python3-dev

# Set the working directory
WORKDIR /app

# Copy and install application dependencies
COPY requirements.txt /app
RUN python -m venv /venv && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt python-dotenv

# Copy the rest of the application files
COPY . /app

# Stage 2: Final image with minimal runtime environment
FROM python:3.9-alpine3.13

# Install system runtime dependencies (no build tools needed)
RUN apk add --no-cache libffi

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /venv /venv
COPY --from=builder /app /app

# Set permissions for the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Set environment variables for Flask and the virtual environment
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV PATH="/venv/bin:$PATH"

# Expose the application port
EXPOSE 5000

# Command to run the application
CMD ["flask", "run"]
