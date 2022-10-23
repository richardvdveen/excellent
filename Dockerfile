FROM python:3.9.10-slim AS base

WORKDIR /app
COPY requirements /app/requirements
RUN pip install -r requirements/requirements.txt

COPY ./src /app/src

FROM base AS development

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]

FROM base AS production

CMD exec gunicorn --bind :$PORT --workers 1 --worker-class uvicorn.workers.UvicornWorker  --threads 8 src.main:app
