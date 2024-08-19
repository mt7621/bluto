from public.ecr.aws/docker/library/alpine:3.19
run apk add --no-cache libc6-compat
run mkdir /app
workdir /app
copy ./employee ./
run chmod 755 ./employee
cmd ["./employee"]
