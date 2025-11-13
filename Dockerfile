FROM rasa/rasa:3.6.0

WORKDIR /app
USER root

# Copy configuration and data
COPY domain.yml config.yml endpoints.yml credentials.yml /app/
COPY data /app/data
COPY actions /app/actions

# Train model during build (fixes empty response issue)
RUN rasa train --fixed-model-name model

RUN chown -R 1001:1001 /app
USER 1001

EXPOSE 10000

# Start Rasa with the trained model
CMD ["run", "--enable-api", "--cors", "*", "--port", "10000"]
