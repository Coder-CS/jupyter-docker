FROM python:3.7-slim
LABEL maintainer="xiange" 

RUN mkdir ~/.pip \
	&& echo '[global]' >> ~/.pip/pip.conf \
	&& echo 'index-url = https://pypi.tuna.tsinghua.edu.cn/simple' >> ~/.pip/pip.conf \
	&& echo '[install]' >> ~/.pip/pip.conf \
	&& echo 'trusted-host = https://pypi.tuna.tsinghua.edu.cn' >> ~/.pip/pip.conf \
	&& sed -i "s@http://deb.debian.org@https://mirrors.tuna.tsinghua.edu.cn/@g" /etc/apt/sources.list \
	&& apt-get install apt-transport-https \
	&& apt-get update

RUN pip --no-cache-dir install jupyterlab

RUN jupyter-lab --generate-config \
	&& echo 'c.NotebookApp.ip="*"' >> ~/.jupyter/jupyter_notebook_config.py \
	&& echo 'c.NotebookApp.open_browser = False' >> ~/.jupyter/jupyter_notebook_config.py \
	&& echo 'c.NotebookApp.allow_root = True' >> ~/.jupyter/jupyter_notebook_config.py

COPY ./supervisord.conf /etc/supervisord.conf

CMD ['jupyter-lab]
 
