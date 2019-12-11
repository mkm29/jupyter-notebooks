#FROM quay.io/jupyteronopenshift/s2i-minimal-notebook-py36:2.5.1
FROM quay.agilesof.com/j6tspathe/coop:datascience

USER root

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src && \
    rm -rf /tmp/scripts && \
    mv /tmp/src/.s2i/bin /tmp/scripts


ENV XDG_CACHE_HOME=/opt/app-root/src/.cache

USER 1001

RUN  pip install -r /tmp/src/requirements.txt && \
    pip show torch && \
    /tmp/scripts/assemble

CMD [ "/opt/app-root/builder/run" ]
