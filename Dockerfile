FROM python:3
WORKDIR $HOME
RUN uname -a
RUN ls -ls
COPY requirements.txt $HOME/
RUN pip install --no-cache-dir -r requirements.txt
COPY . $HOME/
CMD python $HOME/manage.py runserver