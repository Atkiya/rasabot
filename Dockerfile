FROM rasa/rasa:3.6.0

WORKDIR /app
USER root

# Copy configuration and data
COPY domain.yml config.yml endpoints.yml credentials.yml /app/
COPY data /app/data
COPY actions /app/actions

# Copy pretrained model
COPY models /app/models

# Set proper permissions
RUN chown -R 1001:1001 /app
USER 1001

EXPOSE 10000

# Start Rasa with the pretrained model
CMD ["run", "--model", "models", "--enable-api", "--cors", "*", "--port", "10000"]
