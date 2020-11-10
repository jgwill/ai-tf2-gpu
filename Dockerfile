FROM jgwill/sci-dev

RUN pip install --upgrade pip
RUN pip install tensorflow
RUN apt install -y python3-dev python3-pip python3-venv
RUN pip install tensorflow_hub
RUN echo "export TFHUB_CACHE_DIR=$HOME/.cache/tfhub_modules" >> ~/.bashrc
RUN mkdir $HOME/.cache/tfhub_modules

WORKDIR /models

#RUN mkdir models; mkdir models/magenta-v2 ;curl https://storage.googleapis.com/tfhub-modules/google/magenta/arbitrary-image-stylization-v1-256/2.tar.gz --output models/magenta-v2/magenta-v2.tar.gz && cd models/magenta-v2 && tar xzf magenta-v2.tar.gz && rm magenta-v2.tar.gz
COPY nst .

RUN python init-tf.py style/init.jpg  content/init.jpg  result/init.jpg
#RUN python init-tf.py style/sample-style.jpg  content/sample-content.jpg  result/init.jpg


