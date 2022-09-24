FROM python:3
WORKDIR /working_space
RUN uname -a
RUN ls -ls
COPY requirements.txt /working_space/
RUN pip install --no-cache-dir -r requirements.txt
COPY . /working_space/
# CMD python working_space/manage.py runserver
ENV PORT=8000
EXPOSE 8000
# Collect static files
# RUN python manage.py collectstatic
# Run the application
CMD gunicorn oc_lettings_site.wsgi -b 0.0.0.0:$PORT