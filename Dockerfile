FROM node:14.17.6-alpine
WORKDIR /usr/src/app
COPY package*.json ./
COPY tsconfig*.json ./
COPY . .
RUN npm install
RUN npm run build

FROM node:14.17.6-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY --from=0 /usr/src/app/dist ./dist
EXPOSE 3000
CMD npm run prod