# dovecot
A dovecot server to deliver email to clients, authenticate them, and send emails

## Setup
Run `setup.sh` in order to generate the required kubeconfig file, encrypt it, and add it to your gitignore automatically so it won't be committed

## Important
You must install the database component beforehand because this relies on the database to check for user accounts
