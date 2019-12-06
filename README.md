# Jupyter Notebooks for OpenShift  

Based on this [article](https://github.com/jupyter-on-openshift/jupyter-notebooks), a custom Jupyter stack specification used to deploy on OpenShift (using S2I). 

# Installation

1. Create Image Stream
  * oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/master/build-configs/s2i-minimal-notebook.json
2. Create Build
  * oc new-build --name spathe-notebook --image-stream s2i-minimal-notebook:3.6 --allow-missing-imagestream-tags --code https://github.com/mkm29/jupyter-notebooks --context-dir spathe --strategy=source
3. Start the build, either:
  * From terminal: oc start-build bc/spathe-notebook
  * From OCP