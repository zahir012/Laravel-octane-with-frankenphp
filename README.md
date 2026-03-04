```markdown
# Laravel + FrankenPHP: High-Performance Web Applications

This repository demonstrates how to integrate **Laravel** with **FrankenPHP** via **Laravel Octane** to achieve superior performance and modern deployment workflows.

---

## 🚀 Introduction

### Laravel
**Laravel** is a modern PHP framework designed to make web development elegant, simple, and efficient. Since its release, it has become the most popular framework in the PHP ecosystem due to its developer-friendly syntax and robust feature set.

### FrankenPHP
**FrankenPHP** is a modern PHP application server written in Go, designed to make PHP apps faster and more efficient. Unlike traditional PHP setups (PHP-FPM) that start a new process for every request, FrankenPHP keeps your application in memory, allowing it to handle requests at lightning speeds.

**Key Highlights:**
* **Speed:** Benchmarks show it can be up to 3–4x faster than PHP-FPM.
* **Simplicity:** Delivered as a single binary; no external services needed.
* **Modern Features:** Native support for HTTP/2 & HTTP/3, automatic HTTPS, and Prometheus metrics.
* **Worker Mode:** Boots your app once and keeps it running in memory, eliminating startup overhead.

### Laravel Octane
**Laravel Octane** supercharges your application's performance by serving it using high-powered servers like FrankenPHP, Open Swoole, or RoadRunner. Octane boots your application once, keeps it in memory, and feeds it requests at supersonic speeds.

---

## 🛠️ Installation & Setup

Follow these steps to integrate FrankenPHP into your Laravel project:

### 1. Install Laravel Octane
Execute the following command in your Laravel project root:
```bash
composer require laravel/octane

```

### 2. Initialize Octane

Run the Artisan command to complete the setup:

```bash
php artisan octane:install

```

*When prompted, select **FrankenPHP** as your application server.*

### 3. Environment Configuration

Add the following key to your `.env` file to specify the server:

```env
OCTANE_SERVER=frankenphp

```

---

## 🐳 Docker Deployment

Use the following commands to manage your containerized environment:

**Build and Start Containers:**

```bash
# New Docker versions
docker compose up -d --build

# Old Docker versions
docker-compose up -d --build

```

**Monitoring & Interaction:**

```bash
# Check container logs
docker logs -f <container-id>

# Access the container shell
docker exec -it <container-id> bash

```

---

## 📈 Benchmarking

To evaluate the performance difference between the built-in server (`php artisan serve`) and **FrankenPHP**, we use `wrk`, a high-performance HTTP benchmarking tool.

### 1. Install `wrk` (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install wrk -y

```

### 2. Run the Benchmark

Execute the following command to simulate 100 concurrent connections using 4 threads for 30 seconds:

```bash
wrk -t4 -c100 -d30s [http://127.0.0.1:80/](http://127.0.0.1:80/)

```

### Parameter Breakdown:

| Flag | Description |
| --- | --- |
| `-t4` | Uses 4 CPU threads |
| `-c100` | Maintains 100 concurrent connections |
| `-d30s` | Test duration of 30 seconds |

---

> [!TIP]
> Using **FrankenPHP Worker Mode** with Laravel Octane significantly reduces latency by avoiding the need to reload the entire framework on every request.
