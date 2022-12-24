FROM public.ecr.aws/d6z3w8v2/node-slim:latest
RUN mkdir /opt/ui && chmod -R 777 /opt/ui
ADD . /opt/ui
WORKDIR  /opt/ui
RUN npm install &&  npm run build && ls ./build
FROM public.ecr.aws/nginx/nginx:latest
COPY --from=0 /opt/ui/build  /opt/
COPY --from=0 /opt/ui/default.conf.template /etc/nginx/templates/default.conf.template
