FROM python:3.11-slim

WORKDIR /usr/app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install dbt-core and dbt-bigquery
RUN pip install --no-cache-dir dbt-core dbt-bigquery

# Copy dbt project
COPY dbt/ /usr/app/dbt/

# Set working directory to the dbt project folder
WORKDIR /usr/app/dbt

# Default command to run dbt
ENTRYPOINT ["dbt"]
