FROM python:3.9.10-slim AS base

WORKDIR /app
COPY requirements /app/requirements
RUN pip install -r requirements/requirements.txt

CMD exec gunicorn --bind :$PORT --workers 1 --worker-class uvicorn.workers.UvicornWorker  --threads 8 src.main:app
