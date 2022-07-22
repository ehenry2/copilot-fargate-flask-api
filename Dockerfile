FROM python:3.9-slim
EXPOSE 8080

RUN mkdir -p /app && \
    useradd -m -r -U appuser && \
    chown -R "appuser:appuser" /app && \
    pip install pipenv && \
    apt-get update && \
    apt-get install dumb-init && \
    apt-get clean

USER appuser

WORKDIR /app
COPY --chown=appuser:appuser entrypoint.sh /app/entrypoint.sh
COPY --chown=appuser:appuser Pipfile /app/
COPY --chown=appuser:appuser Pipfile.lock /app/
COPY --chown=appuser:appuser app.py /app/
RUN cd /app && \
    pipenv install && \
    chmod +x /app/entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/app/entrypoint.sh"]
