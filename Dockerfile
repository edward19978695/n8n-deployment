FROM n8nio/n8n:2.0.3

# Cloud Run 預設監聽 8080 端口
ENV PORT=8080
EXPOSE 8080

# 確保 n8n 使用正確的端口
ENV N8N_PORT=$PORT