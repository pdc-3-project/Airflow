#!/bin/bash

source ~/airflow_venv/bin/activate

# Start PostgreSQL server if not already running, otherwise restart it
if ! pg_isready > /dev/null
then
    sudo service postgresql start
    echo "PostgreSQL server started"
else
    sudo service postgresql restart
    echo "PostgreSQL server restarted"
fi

# Start Airflow webserver if not already running, otherwise restart it
if ! pgrep -f "airflow webserver" > /dev/null
then
    nohup airflow webserver -p 8080 &
    echo "Airflow webserver started"
else
    pkill -f "airflow webserver"
    nohup airflow webserver -p 8080 &
    echo "Airflow webserver restarted"
fi

# Start Airflow scheduler if not already running, otherwise restart it
if ! pgrep -f "airflow scheduler" > /dev/null
then
    nohup airflow scheduler &
    echo "Airflow scheduler started"
else
    pkill -f "airflow scheduler"
    nohup airflow scheduler &
    echo "Airflow scheduler restarted"
fi

# Start Airflow triggerer if not already running, otherwise restart it
if ! pgrep -f "airflow triggerer" > /dev/null
then
    nohup airflow triggerer &
    echo "Airflow triggerer started"
else
    pkill -f "airflow triggerer"
    nohup airflow triggerer &
    echo "Airflow triggerer restarted"
fi

