FROM rasa/rasa:3.6.0

WORKDIR /app

USER root

# Copy all project files
COPY domain.yml config.yml endpoints.yml credentials.yml /app/
COPY data /app/data
COPY actions /app/actions
COPY models /app/models

# Set permissions
RUN chown -R 1001:1001 /app

USER 1001

EXPOSE 5005

CMD ["run", "--enable-api", "--cors", "*", "--port", "5005"]
