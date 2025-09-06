# syntax=docker/dockerfile:1

FROM python:3.10-alpine3.15

LABEL maintainer="Tahreer-Alshaikh <tahreerbassam2014@gmail.com>"

# Install build dependencies for Python packages
RUN apk add --no-cache gcc musl-dev linux-headers

# Create app user
RUN adduser -D appuser
USER appuser
WORKDIR /home/appuser

ENV PATH="/home/appuser/.local/bin:${PATH}"
ENV FLASK_APP=app.py

# Copy requirements and install
COPY --chown=appuser:appuser requirements.txt .
RUN pip install --user --upgrade pip && \
    pip install --user -r requirements.txt

# Copy project files
COPY --chown=appuser:appuser . .

# Run flask
CMD ["flask", "run", "--host=0.0.0.0"]

