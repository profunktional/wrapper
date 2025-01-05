FROM ubuntu:latest

# Install dependencies and tools: Python, pip, git, wget, unzip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    wget \
    unzip

RUN wget    


WORKDIR /app
#COPY --from=builder /app /app
COPY . /app
ENV args=""

CMD ["bash", "-c", "./wrapper ${args}"]

EXPOSE 10020 20020