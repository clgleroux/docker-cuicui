FROM python:3.9

WORKDIR /app

COPY requirements.txt .

COPY . .

RUN pip install -r requirements.txt
RUN python manage.py makemigrations board

CMD bash -c "sleep 10 && python manage.py runserver 0.0.0.0:80"
