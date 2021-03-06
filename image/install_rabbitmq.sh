unalias -a rm
unalias -a mv

echo '============ install erlang ... ============'
rpm -ivh erlang-20.1.7.1-1.el7.centos.x86_64.rpm

echo '============ install rabbitmq server ... ============'
rpm -ivh rabbitmq-server-3.6.13-1.el7.noarch.rpm

echo '============ deleting rpm packages ... ============'
rm -vf *.rpm

chown -R rabbitmq:rabbitmq /var/lib/rabbitmq /var/log/rabbitmq

echo '====== move RabbitMQ extension files ========'
mv -f *.ez /usr/lib/rabbitmq/lib/rabbitmq_server-3.6.13/plugins/

echo '====== move RabbitMQ configuration  file ========'
mv -f rabbitmq.config /etc/rabbitmq/

rabbitmq-server -detached
rabbitmq-plugins enable --offline rabbitmq_management autocluster
rabbitmq-plugins list
