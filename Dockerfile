FROM python:3.13.2-slim

WORKDIR /app

COPY requirements.txt main.py ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8550

CMD ["python", "main.py"]