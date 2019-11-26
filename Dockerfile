FROM mhart/alpine-node:11 AS builder
WORKDIR /app
COPY . .
RUN yarn run build
RUN ls
RUN cd build

RUN ls
RUN rm -r build/static/css/*.map
RUN rm -r build/static/js/*.map

RUN ls build/static/css
RUN ls build/static/js

FROM mhart/alpine-node
RUN yarn global add serve
RUN ls
WORKDIR /app
COPY --from=builder /app/build .
CMD ["serve", "-p", "80", "-s", "."]