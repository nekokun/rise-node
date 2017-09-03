FROM ubuntu:rolling
RUN apt update && apt -y upgrade && apt -y install git sudo
RUN cd ~ && git clone https://github.com/RiseVision/rise-node.git &&\
    cd rise-node &&\
    sed -i 's/npm install --production/npm install --production --unsafe-perm/' rise_manager.bash &&\
    ./rise_manager.bash install &&\ 
    yes | ./rise_manager.bash rebuild &&\
    service postgresql stop
ENTRYPOINT service postgresql start && cd ~/rise-node && ./rise_manager.bash start && tail -f logs/*
