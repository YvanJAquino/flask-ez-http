FROM    python:3.10-bullseye
ENV     PYTHONUNBUFFERED=true \
        PORT=8010
WORKDIR /app
COPY    . ./
RUN     pip install --no-cache-dir- r requirements.txt
CMD     exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app