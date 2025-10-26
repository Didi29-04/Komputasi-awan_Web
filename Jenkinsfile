pipeline {
    agent any

    environment {
        IMAGE_NAME = "nginx_static"
        SERVICE_NAME = "webserver"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "🔄 Checkout source code dari repo..."
                git branch: 'main', url: 'https://github.com/Didi29-04/Komputasi-Awan_Docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🏗  Build image Docker tanpa membuat container baru..."
                bat "docker-compose build ${SERVICE_NAME}"
            }
        }

        stage('Restart Existing Container') {
            steps {
                echo "♻️ Restart container lama tanpa recreate..."
                bat """
                echo ==== CEK CONTAINER ====
                docker ps -a

                echo ==== JALANKAN CONTAINER JIKA BELUM BERJALAN ====
                docker start ${IMAGE_NAME} || (
                    echo 'Container belum ada, jalankan docker-compose up sekali saja...'
                    docker-compose up -d ${SERVICE_NAME}
                )

                echo ==== RESTART CONTAINER ====
                docker restart ${IMAGE_NAME}

                echo ==== STATUS CONTAINER ====
                docker ps
                """
            }
        }

        stage('Verify Website Running') {
            steps {
                echo "🔍 Verifikasi website berjalan di http://localhost:8081 ..."
                bat """
                ping 127.0.0.1 -n 10 >nul
                curl -I http://127.0.0.1:8081 || echo "⚠ Gagal akses website"
                """
            }
        }
    }

    post {
        success {
            echo "✅ Website berhasil dijalankan tanpa membuat container baru!"
        }
        failure {
            echo "❌ Build gagal, cek log Jenkins console output."
        }
    }
}
