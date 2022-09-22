FROM python:3
WORKDIR /working_space
COPY requirements.txt /working_space/
RUN pip install -r requirements.txt
COPY . /working_space/
CMD python working_space/manage.py runserver