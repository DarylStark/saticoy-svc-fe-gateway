FROM nginx AS base

# Remove the `/etc/nginx/conf.d/default.conf` file
RUN rm /etc/nginx/conf.d/default.conf

# Create a directory for the configuration files
RUN mkdir -p /etc/nginx/services/

# Create a dictory for the cache
RUN mkdir -p /var/cache/nginx/

# Copy the default configuration file
COPY src/default.conf /etc/nginx/conf.d/default.conf
COPY src/cache.conf /etc/nginx/conf.d/cache.conf

# Copy the configuration files for the services
COPY src/landing-page.conf /etc/nginx/services/landing-page.conf.template

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start the Nginx server
CMD /bin/bash -c "envsubst '\$URL_LANDING_PAGE' < /etc/nginx/services/landing-page.conf.template > /etc/nginx/services/landing-page.conf && exec nginx -g 'daemon off;'"