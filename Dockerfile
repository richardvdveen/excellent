FROM python:3.9.10-slim AS base

WORKDIR /app
COPY requirements /app/requirements
RUN pip install -r requirements/requirements.txt

FROM base AS development

ENV PYTHONUNBUFFERED 1
EXPOSE 8000
USER www-data

COPY src /src
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]

FROM base AS production
