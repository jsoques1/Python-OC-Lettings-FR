FROM python:3
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PORT 8000
WORKDIR $HOME
RUN uname -a
RUN ls -ls
COPY requirements.txt $HOME/
RUN pip install --no-cache-dir -r requirements.txt
COPY . $HOME/
EXPOSE $PORT
# CMD python $HOME/manage.py runserver

CMD pwd
CMD ls -l
# Collect static files
RUN python manage.py collectstatic

# Run the application
CMD gunicorn oc_lettings_site.wsgi -b 0.0.0.0:$PORT