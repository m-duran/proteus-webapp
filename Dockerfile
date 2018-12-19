# stage 1 : build image
# base image
FROM node:10.13.0 AS builder

# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# install and cache app dependencies
COPY package.json yarn.lock ./

RUN yarn
COPY . ./
RUN yarn build

FROM nginx:1.12-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 3000

# start app
CMD ["nginx", "-g", "daemon off;"]