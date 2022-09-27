FROM python:3
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PORT 8000
WORKDIR /usr/src/app
RUN uname -a
RUN ls -ls
COPY requirements.txt /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt
COPY . /usr/src/app


CMD pwd
CMD ls -l

EXPOSE $PORT
CMD python $HOME/manage.py runserver 0.0.0.0:$PORT


# Collect static files
# RUN python manage.py collectstatic

# Run the application
# CMD gunicorn oc_lettings_site.wsgi -b 0.0.0.0:$PORT