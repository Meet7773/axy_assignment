## Docker part

- to run the docker just go the root directory and type:
- **docker-compose up --build**

- this will create 3 containers frontend, backend, postgres and a network called axy_private_net.

- now to stop it just type:
- **docker-compose down**

- incase of of failure of db showing user not found check the .env file.
- you can then use this command to clear the volume:
- **docker volume ls**
- **docker volume rm axy_pgdata**


## Challenges & Debugging Notes

- Faced some issues while creatinf backend accidently used wrong path for volumes. 
  Also made a mistake while configuring ports for backend and database.

- faced some api issues due to fastapi and nginx handling of the api routes aligning.

- curl falied because slim img was used. Replaced it with a python-based health check.(note: slim img was used for minimality.)

## Trade-offs

- used nginx instead of a framework to keep it minimal.

- healthchecks are only there to make sure if the service is available.