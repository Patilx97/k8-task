# Use the official Nginx image as a base image
FROM nginx:latest

# Remove the default Nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy the index.html file into the container
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
