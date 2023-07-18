sudo docker run --detach \
  --hostname gitlab.xingtuai.com \
  -p 8000:80 -p 9443:443 -p 10022:22 \
  --name gitlab \
  --restart always \
  --volume /root/docker/gitlab/conf:/etc/gitlab \
  --volume /root/docker/gitlab/logs:/var/log/gitlab \
  --volume /root/docker/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
