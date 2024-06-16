#dockerfile para fezer deploy de arquivo php na instancia
FROM php:7.4-apache
COPY src/ /var/www/html/