pipeline {
    agent any

    environment {
        IMAGE_NAME = "static-web"
        CONTAINER_NAME = "nginx_static"
        PORT = "8081"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "🔄 Checkout source code dari repo..."
                git branch: 'main', url: 'https://github.com/Didi29-04/Komputasi-awan_Web.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🏗  Build Docker image untuk website statis..."
                bat "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "🚀 Jalankan ulang container Nginx statis..."
                bat """
                echo ==== HENTIKAN CONTAINER LAMA ====
                docker stop ${CONTAINER_NAME} || echo "Container tidak berjalan"
                docker rm ${CONTAINER_NAME} || echo "Container sudah dihapus"

                echo ==== JALANKAN ULANG CONTAINER ====
                docker run -d --name ${CONTAINER_NAME} -p ${PORT}:80 ${IMAGE_NAME}

                echo ==== CEK CONTAINER YANG AKTIF ====
                docker ps
                """
            }
        }

        stage('Verify Website Running') {
            steps {
                echo "🔍 Verifikasi halaman index.html berjalan..."
                bat """
                echo ==== TUNGGU 10 DETIK SUPAYA CONTAINER SIAP ====
                ping 127.0.0.1 -n 10 >nul

                echo ==== CEK HALAMAN WEBSITE ====
                curl -I http://127.0.0.1:${PORT} || echo "⚠ Gagal akses website di port ${PORT}"

                echo.
                echo ==== ISI HALAMAN (HARUSNYA MUNCUL INDEX.HTML) ====
                curl http://127.0.0.1:${PORT} || echo "⚠ Gagal ambil isi halaman"
                """
            }
        }
    }

    post {
        success {
            echo "✅ Website statis berhasil dijalankan di http://localhost:${PORT}!"
        }
        failure {
            echo "❌ Build gagal, cek log Jenkins console output."
        }
    }
}
