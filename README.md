# docker-wp-app-dev
wordpress app containerised in docker

1. `chmod +x RUN-FIRST.bash`
2. run `bash RUN-FIRST.bash`
3. run docker command `docker volume create db_data` to create a volume to be mounted by the mysql db for persistent db storage
4. then run `docker-compose up -d` to deploy container cluster
5. your wordpress website should be accessible on http://localhost, setup your website title and user accounts
   
happy wordpress deployment!