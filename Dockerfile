#using nginx base image
FROM httpd:alpine

# Copy HTML files to nginx default public directory
COPY page1.html /usr/local/apache2/htdocs/page1.html
COPY page2.html /usr/local/apache2/htdocs/page2.html