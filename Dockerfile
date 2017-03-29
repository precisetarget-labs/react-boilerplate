# NOTE: The build directory should already exist prior to building the image.
#       Run 'npm run build' prior to dockerizing.

# Base image
FROM nginx

# Maintainer
MAINTAINER PreciseTarget Engineering <engineering@precisetarget.com>

# Copy built app
COPY build /usr/share/nginx/html

# Replace the default nginx config with our a modified version that supports single page app routing
COPY .react-app-nginx.conf /etc/nginx/conf.d/default.conf

# The app is running on port 80, which is automagically exposed.
