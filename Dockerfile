FROM quay.io/jupyteronopenshift/s2i-minimal-notebook-py36:2.5.1
#FROM quay.agilesof.com/j6tspathe/coop:datascience

USER root

COPY . /tmp/src

RUN yum -y install texlive && \
    yum -y install git && \
    cd /tmp/src && \
    wget https://github.com/jgm/pandoc/releases/download/2.8.1/pandoc-2.8.1-linux-amd64.tar.gz && \
    tar -xvzf pandoc-2.8.1-linux-amd64.tar.gz && \
    cd pandoc-2.8.1/bin && mv pandoc /usr/bin && \
    git clone https://github.com/lckr/jupyterlab-variableInspector && \
    cd jupyterlab-variableInspector && \
    npm install %% \
    npm run build && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src && \
    rm -rf /tmp/scripts && \
    mv /tmp/src/.s2i/bin /tmp/scripts && \
    rm -rf /tmp/src


ENV XDG_CACHE_HOME=/opt/app-root/src/.cache

USER 1001

RUN pip install -r /tmp/src/requirements.txt && \
    cd /opt/app-root/ && \
    git clone https://github.com/jakevdp/PythonDataScienceHandbook.git && \
    cd PythonDataScienceHandbook && \
    mv notebooks ../ && \
    cd ../ && rm -rf PythonDataScienceHandbook && \
    /tmp/scripts/assemble

CMD [ "/opt/app-root/builder/run" ]
