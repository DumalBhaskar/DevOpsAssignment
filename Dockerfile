
FROM python:3.9-alpine3.13

WORKDIR /app

COPY requirements.txt /app

RUN pip install -r requirements.txt python-dotenv

COPY . /app

ENV FLASK_APP=app.py

ENV FLASK_RUN_HOST=0.0.0.0

EXPOSE 5000

CMD ["flask", "run"]
