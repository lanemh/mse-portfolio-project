# Portfolio Project for MSE DevOps by Lane Harbarger

# Setting up Postgres Server
FROM postgres:latest

# Setting environment variables
ENV POSTGRES_USER admin
ENV POSTGRES_PASSWORD Admin#123
ENV POSTGRES_DB average_joes

# Copy SQL to container
COPY portfolio_project.sql /docker-entrypoint-initdb.d/
