FROM n8nio/n8n:2.3.6

# Cloud Run 預設監聽 8080 端口
ENV N8N_PORT=5678

USER root
RUN mkdir -p /home/node/.n8n/nodes \ 
    && cd /home/node/.n8n/nodes \ 
    && npm install --omit=dev @aotoki/n8n-nodes-line-messaging \ 
    && chown -R node:node /home/node/.n8n

USER node

EXPOSE 5678