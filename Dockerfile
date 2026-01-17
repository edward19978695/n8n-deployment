FROM n8nio/n8n:2.3.6

# Cloud Run 預設監聽 8080 端口
ENV N8N_PORT=$PORT

USER root

# 安裝 community nodes
RUN npm install -g @aotoki/n8n-nodes-line-messaging

# 確保權限正確
RUN chown -R node:node /home/node

USER node

EXPOSE 5678