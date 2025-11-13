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

# Pre-warm: load model during build so runtime startup is faster
RUN rasa run --enable-api --dry-run 2>/dev/null || true

CMD bash -lc "rasa run --enable-api --cors '*' --port ${PORT:-5005}"
