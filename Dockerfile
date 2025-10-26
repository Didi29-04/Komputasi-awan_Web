# Gunakan image Nginx resmi
FROM nginx:stable-alpine

# Set direktori kerja di container
WORKDIR /usr/share/nginx/html

# Hapus konfigurasi default agar pakai konfigurasi custom kita
RUN rm /etc/nginx/conf.d/default.conf

# Copy semua file website ke container
COPY . .

# Copy konfigurasi Nginx custom
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose port default
EXPOSE 80

# Jalankan Nginx di foreground
CMD ["nginx", "-g", "daemon off;"]
