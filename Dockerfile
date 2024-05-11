# Use an nginx image
FROM nginx:alpine

# Install Git in the alpine nginx image
RUN apk add --no-cache git

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Clone your GitHub repository into a temporary directory
RUN git clone https://github.com/djtoler/hwthdemo2.git /tmp/hwthdemo && \
    mv /tmp/hwthdemo/hwth.html ./index.html && \
    rm -rf /tmp/hwthdemo/.git

# Expose port 80 for the nginx server
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
