FROM python:3
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PORT 8000
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt
COPY . /usr/src/app

EXPOSE $PORT
CMD python manage.py runserver 0.0.0.0:$PORT
