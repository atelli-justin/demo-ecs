# demo-ecs
[![CI/CD Pipeline](https://github.com/atelli-justin/demo-ecs/actions/workflows/github-action-prod.yml/badge.svg?branch=main)](https://github.com/atelli-justin/demo-ecs/actions/workflows/github-action-prod.yml)
[![CI/CD Pipeline](https://github.com/atelli-justin/demo-ecs/actions/workflows/github-action-prod.yml/badge.svg?branch=test)](https://github.com/atelli-justin/demo-ecs/actions/workflows/github-action-prod.yml)

Create `test` branch and upload, if test deploy success, merge to main branch, it well auto deploy to production.  

# Creed
Need replace `${{ env.PROJECT_NAME }}`。

```
env:
  project: ${{ env.PROJECT_NAME }}
  AWS_REGION: ${{ secrets.AWS_REGION }}
  ECR_REGISTRY: ${{ secrets.ECR_REGISTRY }}/${{ env.PROJECT_NAME }}
  ECR_REPOSITORY: ${{ env.PROJECT_NAME }}
  ECS_CLUSTER: <env>            # prod, stage
  ECS_TASK_DEFINITION: ${{ secrets.ECS_TASK_DEFINITION }}
  ECS_SERVICE: ${{ env.PROJECT_NAME }}-$ECS_CLUSTER
  CONTAINER_NAME: ${{ env.PROJECT_NAME }}
```