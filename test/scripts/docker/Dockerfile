FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /workspace

CMD ["bash"]