FROM python:3.12-slim

RUN apt-get update && apt-get install -y apt-transport-https

RUN apt-get update && apt-get install -qq -y \
    build-essential python3.12-dev libssl-dev libffi-dev --no-install-recommends

RUN python -m pip install --upgrade pip setuptools wheel

WORKDIR /app

COPY ./requirements.txt /app/

RUN pip install -r requirements.txt

COPY . /app

WORKDIR /app

CMD ["gunicorn", "--bind", "0.0.0.0:5500", "--timeout=600", "app:app"]

EXPOSE 5500
