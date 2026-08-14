FROM python:3.10-slim
ENV PYTHONUNBUFFERED True
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./
RUN apt-get update && apt-get install -y libgl1 libglib2.0-0 libsm6 libxext6 libxrender-dev && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir Flask gunicorn mediapipe opencv-python-headless numpy
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
