

---

# 🚀 Dockerized Flask App on AWS EC2 – Step-by-Step Guide

This guide walks you through deploying a simple **Flask app inside a Docker container** on an **AWS EC2 instance**.

---

## 🧱 Project Structure

```
basic-docker-flask-app/
├── app.py
├── requirements.txt
└── Dockerfile
```

---

## 🧑‍💻 Step 1: Create Project Files

### 1.1 Create Project Folder

```bash
mkdir basic-docker-flask-app
cd basic-docker-flask-app
```

### 1.2 Create `app.py`

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, Docker! This is a containerized Flask app."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

### 1.3 Create `requirements.txt`

```txt
flask
```

### 1.4 Create `Dockerfile`

```Dockerfile
# Use official Python image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Run the Flask app
CMD ["python", "app.py"]
```

---

## 🐳 Step 2: Build & Run Docker Container

### 2.1 Build the Docker Image

```bash
docker build -t flask-docker-app .
```

### 2.2 Run the Docker Container

```bash
docker run -d -p 5000:5000 flask-docker-app
```

---

## ☁️ Step 3: Deploy on AWS EC2

### 3.1 Launch an EC2 Instance

- Use Amazon Linux 2 or Ubuntu
- Choose a **Security Group** that allows **port 5000**

### 3.2 SSH into Your EC2 Instance

```bash
ssh -i "your-key.pem" ubuntu@<your-ec2-public-ip>
```

### 3.3 Install Docker (if not already)

For Ubuntu:

```bash
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```

---

## 🔐 Step 4: Open Port 5000 in Security Group

1. Go to AWS EC2 Dashboard → **Instances**
2. Click your instance
3. Scroll to **Security Groups** → Click the linked name
4. Click **Edit Inbound Rules**
5. Add:

| Type        | Protocol | Port Range | Source           |
|-------------|----------|------------|------------------|
| Custom TCP  | TCP      | 5000       | 0.0.0.0/0 (or My IP) |

6. Click **Save rules**

---

## 🌍 Step 5: Access Your Flask App

In your browser, visit:

```
http://<your-ec2-public-ip>:5000
```

or test again in terminal:


curl http://localhost:5000


You should see:

```
Hello, Docker! This is a containerized Flask app.
```

---

## 🧹 Bonus: Managing Docker

### Stop a Container:

```bash
docker ps                # Get container ID
docker stop <container_id>
```

### Check Docker Status:

```bash
sudo systemctl status docker
```

