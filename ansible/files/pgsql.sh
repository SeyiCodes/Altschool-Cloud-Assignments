#!/bin/bash
sudo apt update

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/postgresql-pgdg.list > /dev/null

sudo apt update -y

sudo apt install postgresql-14 -y

dpkg -l | grep postgresql

sudo ss -atnp | grep 5432

sudo ufw allow 5432/tcp

sudo systemctl restart postgresql

sudo systemctl enable postgresql

set -e

DB_NAME=${1:-seyiadmin}

DB_USER=${2:-altschooldb}

DB_USER_PASS=${3:-SeyiAdmin123}

sudo -i -u postgres <<EOF
createdb  $DB_NAME;
psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_USER_PASS';"
psql -c "grant all privileges on database $DB_NAME to $DB_USER;"
echo "Postgres User '$DB_USER' and database '$DB_NAME' created."
EOF

exit
