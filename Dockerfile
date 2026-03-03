# Base image with FrankenPHP
FROM dunglas/frankenphp:1-php8.4 AS base

# Set working directory
WORKDIR /app

# Install system dependencies and build tools
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    build-essential \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions including Redis
RUN install-php-extensions \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    opcache \
    intl \
    redis \
    @composer

# Copy PHP configuration
COPY docker/php.ini /usr/local/etc/php/conf.d/99-overrides.ini

# Development stage
FROM base AS development

# Copy application code
COPY . .

# Install all dependencies (including dev)
RUN composer install --no-interaction --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

EXPOSE 80

# Production stage
FROM base AS production

# Copy application code
COPY . .

# Install production dependencies only
RUN composer install --no-dev --no-interaction --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Optimize Laravel for production
RUN php artisan optimize \
    && php artisan view:cache \
    && php artisan event:cache \
    && php artisan config:cache \
    && php artisan route:cache

EXPOSE 80
