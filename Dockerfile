FROM ubuntu:latest AS builder
WORKDIR /
COPY . /app

RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

RUN apt update && apt install aria2 unzip build-essential cmake -y && \
 aria2c -o /root/android-ndk-r23b-linux.zip https://dl.google.com/android/repository/android-ndk-r23b-linux.zip && \
 unzip -q -d /root /root/android-ndk-r23b-linux.zip

RUN cd app && mkdir -p build && cd build && cmake .. && make

FROM ubuntu:latest

WORKDIR /app
COPY --from=builder /app /app
#COPY . /app
ENV args ""

CMD ["bash", "-c", "./wrapper ${args}"]

EXPOSE 10020 20020