FROM python:3.13.2-slim

WORKDIR /app

COPY requirements.txt ./
COPY src/ src/

RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH=/app/src

EXPOSE 8550

CMD ["python", "-m", "simautomata.main"]
