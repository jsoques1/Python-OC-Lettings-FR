FROM python:3
WORKDIR /working_space
RUN uname -install
RUN ls -ls
COPY requirements.txt /working_space/
RUN pip install --no-cache-dir -r requirements.txt
COPY . /working_space/
CMD python working_space/manage.py runserver