# Jupyter Notebooks for OpenShift  

Based on this [article](https://github.com/jupyter-on-openshift/jupyter-notebooks), a custom Jupyter stack specification used to deploy on OpenShift (using S2I). 

# Installation

1. Create Image Stream
  * oc create -f https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/master/build-configs/s2i-minimal-notebook.json
  * WAIT for image to download! (Watch build logs)
2. Create Build
  * oc new-build --name spathe-notebook-build --image-stream s2i-minimal-notebook:3.6 --code https://github.com/mkm29/jupyter-notebooks --strategy=source
  * WAIT for image to download! (Watch build logs)  
3. Start the build, either:
  * oc set env bc/spathe-notebook-build JUPYTER_ENABLE_LAB=true
  * oc set env bc/spathe-notebook-build JUPYTER_NOTEBOOK_PASSWORD=spathe
  * oc start-build bc/spathe-notebook-build
4. Create app
  * oc new-app spathe-notebook-build --name spathe-notebook-app
5. Expose  
  * oc expose svc/spathe-notebook-app
6. Set Environment Variables  
  * oc set env dc/spathe-notebook-app JUPYTER_NOTEBOOK_PASSWORD=spathe  
  * oc set env dc/spathe-notebook-app JUPYTER_NOTEBOOK_INTERFACE=lab  