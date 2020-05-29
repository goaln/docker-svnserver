# docker-svnserver

docker exec -it svnserver svnadmin create /var/svn/repo    
docker exec -it svnserver htpasswd -cm /var/svn/passwd admin