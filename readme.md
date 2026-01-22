## Challenges & Debugging Notes

- Faced some issues while creatinf backend accidently used wrong path for volumes. 
  Also made a mistake while configuring ports for backend and database.

- faced some api issues due to fastapi and nginx handling of the api routes aligning.

- curl falied because slim img was used. Replaced it with a python-based health check.(note: slim img was used for minimality.)

## Trade-offs

- used nginx instead of a framework to keep it minimal.

- healthchecks are only there to make sure if the service is available.