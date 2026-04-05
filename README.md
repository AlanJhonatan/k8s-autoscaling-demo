# Kubernetes Autoscaling & IaC Showcase 🚀

This project is a comprehensive demonstration of modern DevOps practices, focusing on **Kubernetes (K8s) Autoscaling**, **Infrastructure as Code (IaC)** with Terraform, and **Performance Testing** with k6.

It features a high-performance TypeScript/Node.js API designed to simulate CPU-intensive workloads, allowing for empirical validation of Horizontal Pod Autoscaling (HPA) in a cloud-native environment.

## 📌 Design Decisions

- **CPU-based scaling (50% target)**  
  I chose CPU utilization as the scaling metric because it provides deterministic and observable behavior in controlled environments. CPU-bound workloads allow clear validation of HPA reactions, unlike I/O-bound scenarios which may introduce noisy or delayed signals.

- **CPU-intensive endpoint (`/heavy`)**  
  The API includes a deliberately CPU-bound endpoint to simulate real pressure on the system. This ensures that scaling events are triggered reliably, making the behavior reproducible during load testing.

- **Min/Max replicas (1–5)**  
  A minimum of 1 replica reduces idle resource usage, while a maximum of 5 simulates constrained environments and prevents uncontrolled scaling during tests.

- **Terraform for IaC**  
  Terraform was used to provision Kubernetes resources to ensure reproducibility, version control, and alignment with real-world infrastructure workflows.

- **k6 for load generation**  
  k6 was selected for its simplicity and developer-friendly scripting model, allowing controlled and repeatable load patterns to validate autoscaling behavior.

## ⚖️ Limitations

- **Reactive scaling (not predictive)**  
  HPA reacts to metrics after load increases, meaning there is always a delay before scaling occurs. :contentReference[oaicite:0]{index=0}

- **CPU is not always the best metric**  
  While CPU works well for this demo, real-world systems often require custom metrics such as request rate or latency.

- **Local environment constraints (Minikube)**  
  Minikube does not simulate real cluster behavior, especially node-level autoscaling.

- **No Cluster Autoscaler**  
  This demo scales pods only. In production, node scaling would be required to support higher workloads.

- **Simplified traffic patterns**  
  The load test uses synthetic traffic, which may not reflect real-world bursty or unpredictable workloads.

## 🚀 Production Considerations

In a production environment, this setup would evolve significantly:

- **Managed Kubernetes (EKS / GKE / AKS)**  
  Instead of Minikube, a managed Kubernetes service such as AWS EKS would be used for reliability, scalability, and operational support.

- **Cluster Autoscaler**  
  In addition to HPA, a Cluster Autoscaler would dynamically adjust the number of worker nodes based on pod scheduling needs.

- **Advanced metrics (Prometheus / custom metrics)**  
  Scaling would be based on business metrics (e.g., requests per second, queue size) instead of only CPU usage.

- **Observability stack**  
  Tools like Prometheus and Grafana would be used to monitor system behavior and scaling decisions.

- **Ingress Controller (NGINX / ALB)**  
  Production-grade ingress with TLS termination, routing rules, and load balancing.

- **Stabilization windows & scaling policies**  
  Fine-tuning scaling behavior to avoid oscillations and improve system stability.

- **CI/CD pipeline**  
  Automated build and deployment using pipelines (e.g., GitHub Actions, ArgoCD).

- **Security & networking**  
  - Network policies
  - Secrets management (e.g., AWS Secrets Manager)
  - IAM roles for service accounts

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
