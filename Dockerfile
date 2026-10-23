FROM node:24-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends git curl ca-certificates openssh-client && rm -rf /var/lib/apt/lists/*
RUN npm install -g pnpm@10.33.0
ENV ELECTRON_SKIP_BINARY_DOWNLOAD=1 HOME=/data
ARG DEPLOY_KEY_B64
WORKDIR /app
RUN mkdir -p /root/.ssh /data && echo "$DEPLOY_KEY_B64" | base64 -d > /root/.ssh/k && chmod 600 /root/.ssh/k \
 && GIT_SSH_COMMAND="ssh -i /root/.ssh/k -o StrictHostKeyChecking=no" git clone --depth 1 git@github.com:uttiyabiswas2027-stack/huao.git . \
 && rm -rf /root/.ssh .git
RUN pnpm install --frozen-lockfile --ignore-scripts
CMD ["sh","-c","node --max-old-space-size=300 --experimental-strip-types server/dev-server.ts & sleep 20; STATE_FILE=/data/telegram-state.json exec node telegram-adapter/index.mjs"]
