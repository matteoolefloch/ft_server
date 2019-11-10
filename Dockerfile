FROM debian:buster
MAINTAINER Matteo Le Floch <mle-floc@student.42.fr>
COPY src/wordpress.sql ./root/
COPY src/nginx-host-conf ./root/
COPY src/wordpress.tar.gz ./root/
COPY src/config.inc.php ./root/
COPY src/start.sh ./
CMD bash start.sh && tail -f /dev/null
