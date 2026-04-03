# Kubernetes Autoscaling & IaC Showcase 🚀

This project is a comprehensive demonstration of modern DevOps practices, focusing on **Kubernetes (K8s) Autoscaling**, **Infrastructure as Code (IaC)** with Terraform, and **Performance Testing** with k6.

It features a high-performance TypeScript/Node.js API designed to simulate CPU-intensive workloads, allowing for empirical validation of Horizontal Pod Autoscaling (HPA) in a cloud-native environment.

## 🏗️ Architecture Overview

- **Application**: A Node.js Express API written in TypeScript.
  - `/health`: Standard health check endpoint for K8s Liveness/Readiness probes.
  - `/heavy`: A CPU-bound endpoint specifically designed to trigger scaling events by performing complex mathematical operations.
- **Infrastructure (Terraform)**: The entire Kubernetes environment is managed via Terraform, ensuring reproducible and version-controlled infrastructure.
  - **Deployment**: Configured with resource limits/requests to enable precise HPA behavior.
  - **Service & Ingress**: Provides external access to the application via `k8s-demo.local`.
  - **HPA**: Automatically scales the deployment between **1 and 5 replicas** based on a **50% CPU utilization** threshold.
- **Orchestration (Kubernetes)**: Manifests are provided for both manual application (`kubectl apply`) and automated provisioning through Terraform.
- **Load Testing (k6)**: A dedicated performance script to simulate traffic spikes and observe the cluster's elasticity.

## 🛠️ Tech Stack

- **Language**: [TypeScript](https://www.typescriptlang.org/) / [Node.js](https://nodejs.org/)
- **Infrastructure**: [Terraform](https://www.terraform.io/)
- **Orchestration**: [Kubernetes](https://kubernetes.io/)
- **Load Testing**: [k6](https://k6.io/)
- **Containerization**: [Docker](https://www.docker.com/)

## 🚀 Getting Started

### Prerequisites

- Docker Desktop / Minikube / Kind
- Terraform
- kubectl
- Node.js & npm

### 1. Build the Application
```bash
docker build -t k8s-autoscaling-demo:latest .
```

### 2. Provision Infrastructure
You can use Terraform to deploy the entire stack:
```bash
cd terraform
terraform init
terraform apply
```

Alternatively, use the raw K8s manifests:
```bash
kubectl apply -f k8s/
```

### 3. Accessing the App
Ensure your `/etc/hosts` includes:
```text
127.0.0.1 k8s-demo.local
```

## 📈 Testing the Autoscaling

The core of this showcase is observing how Kubernetes reacts to load.

1. **Monitor the HPA**:
   ```bash
   kubectl get hpa -w
   ```
2. **Run the Load Test**:
   ```bash
   k6 run k6/load-test.js
   ```

**What happens?**
The k6 script ramps up to 50 virtual users hitting the `/heavy` endpoint. As CPU utilization crosses the 50% mark, the HPA will trigger the creation of new Pods, distributing the load and maintaining system stability.

## 🛡️ Key DevOps Concepts Demonstrated

- **Infrastructure as Code**: Managing K8s resources (Deployments, Services, HPA) using Terraform for state management and repeatability.
- **Elasticity**: Implementing Horizontal Pod Autoscaling to handle variable traffic patterns efficiently.
- **Observability & Probes**: Using Liveness and Readiness probes to ensure zero-downtime deployments and self-healing.
- **Resource Management**: Defining CPU/Memory requests and limits to provide predictable scheduling and scaling.
- **Automation**: Containerizing the application and automating the deployment lifecycle.

---
*Created for tech interview showcase.*
