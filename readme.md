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

## Terraform / AWS Infrastructure part
- this part describes how the app will be deployed on aws.

### Overview of Infrastructure Design
traffic flow:

internet  
→ application load balancer (public subnet, https)  
→ ecs fargate service (private subnets)  
→ rds postgresql (private subnets, multi-az)

only the load balancer is public.
the backend and database are fully private.

---

### Why these AWS services were chosen

- **VPC**
  it is used to isolate the application and control networking.
  the public and private subnets are spread across 2 availability zones.

- **Application Load Balancer**
  it is used to expose the application over https and route traffic to backend containers.
  it also handles health checks.

- **ECS Fargate**
  it was chosen to run containers without managing ec2 instances.
  it fits well with docker based workflows and keeps infra simpler.

- **RDS PostgreSQL**
  it is used for managed database features like backups and multi-az.
  the database is not publicly accessible.

---
### How to deploy (Terraform)

commands:

- **terraform init**
- **terraform plan**
- **terraform apply**

---

### Security Considerations

- only the application load balancer is internet facing
- backend ecs tasks run in the private subnets with no public ip
- the database runs in the private subnets and it is not accessible from the internet
- the security groups are restricted:
  - alb → backend only
  - backend → database only
- the https is terminated at the load balancer
- the backend and database are not directly exposed

---

### Assumptions

- the container images are already available in the ecr
- the dns / route53 is handled outside this terraform setup
- terraform state backend is not configured for simplicity

## Challenges & Debugging Notes

- Faced some issues while creatinf backend accidently used wrong path for volumes. 
  Also made a mistake while configuring ports for backend and database.

- faced some api issues due to fastapi and nginx handling of the api routes aligning.

- curl falied because slim img was used. Replaced it with a python-based health check.(note: slim img was used for minimality.)

## Trade-offs

- used nginx instead of a framework to keep it minimal.

- healthchecks are only there to make sure if the service is available.

- ecs fargate is used instead of ec2 auto scaling to reduce infra management.
- nat gateway is used for private subnet internet access, which increases cost.
