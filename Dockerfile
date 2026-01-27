FROM jupyter/base-notebook:python-3.14

USER root

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

USER jovyan

COPY requirements.txt /home/jovyan/requirements.txt
RUN pip install --no-cache-dir -r /home/jovyan/requirements.txt

WORKDIR /home/jovyan/work
