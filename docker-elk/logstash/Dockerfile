ARG ELK_VERSION

# https://github.com/elastic/logstash-docker
FROM logstash:7.0.0
RUN bin/logstash-plugin install logstash-output-elasticsearch \
                                logstash-input-syslog \
                                logstash-output-syslog \
                                logstash-filter-kv \
                                logstash-filter-json
