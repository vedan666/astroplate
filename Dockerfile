FROM node:22.20.0-alpine AS builder
WORKDIR /app
COPY . .
RUN apk add --no-cache libc6-compat && \
    yarn install && \
    yarn run build

FROM nginx:alpine AS runner
COPY ./config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist /usr/share/nginx/html