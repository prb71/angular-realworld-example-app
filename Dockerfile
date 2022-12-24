FROM public.ecr.aws/docker/library/node:18.12-slim
RUN mkdir /opt/ui && chmod -R 777 /opt/ui
ADD . /opt/ui
WORKDIR  /opt/ui
RUN npm install &&  npm run build 
FROM public.ecr.aws/nginx/nginx:latest
COPY --from=0 /opt/ui/dist  /opt/
COPY --from=0 /opt/ui/default.conf.template /etc/nginx/templates/default.conf.template
