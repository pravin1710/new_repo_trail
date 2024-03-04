# Use NGINX base image from Docker Hub
FROM nginx:latest


# Expose ports
EXPOSE 80

# Start NGINX service
CMD ["nginx", "-g", "daemon off;"]
