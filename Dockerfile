FROM rasa/rasa:3.6.0

WORKDIR /app
USER root

COPY domain.yml config.yml endpoints.yml credentials.yml /app/
COPY data /app/data
COPY actions /app/actions
COPY models /app/models

RUN chown -R 1001:1001 /app
USER 1001

EXPOSE 5005

# Fixed CMD - no bash wrapper needed
CMD ["run", "--enable-api", "--cors", "*", "--port", "10000"]
