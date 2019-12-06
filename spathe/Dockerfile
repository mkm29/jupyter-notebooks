FROM quay.io/jupyteronopenshift/s2i-minimal-notebook-py36:2.5.1

USER root

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src && \
    rm -rf /tmp/scripts && \
    mv /tmp/src/.s2i/bin /tmp/scripts && \
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^1.0.1 --no-build && \
    jupyter labextension install jupyterlab-dash@0.1.0-alpha.3 --no-build && \
    jupyter labextension install jupyterlab_bokeh@1.0.0 --no-build && \
    jupyter lab build


ENV XDG_CACHE_HOME=/opt/app-root/src/.cache

USER 1001

RUN /tmp/scripts/assemble

CMD [ "/opt/app-root/builder/run" ]
