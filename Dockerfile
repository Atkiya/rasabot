FROM rasa/rasa:3.6.0

# Set working directory
WORKDIR /app

# Switch to root user
USER root

# Copy all project files
COPY . /app

# Create necessary directories
RUN mkdir -p /app/models /app/data /app/actions

# Set correct permissions
RUN chown -R 1001:1001 /app

# Switch back to rasa user
USER 1001

# Expose Rasa port
EXPOSE 5005

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:5005/ || exit 1

# Start Rasa server
CMD ["run", "--enable-api", "--cors", "*", "--port", "5005", "--debug"]
