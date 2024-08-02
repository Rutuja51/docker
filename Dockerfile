#Compile and build Angular Database
#Download Node Alpine image
FROM node:latest As build
 
#Setup the working directory
WORKDIR /app
 
#Copy package.json
COPY package.json package-lock.json ./
#COPY ./ /usr/src/app/
 
#Install dependencies
RUN npm install
 
#Copy other files and folder to working directory
COPY . .
 
#Build Angular application in PROD mode
RUN npm run build

#outout 
 
#Stage 2 : Serve app with nginx server
#Download NGINX Image
FROM nginx:alpine
 
#Copy built angular app files to NGINX HTML folder
COPY --from=build /app/dist/docker_sample/browser  /usr/share/nginx/html
#COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]