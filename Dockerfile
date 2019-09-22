FROM christroutner/ct-base-ubuntu
MAINTAINER Chris Troutner <chris.troutner@gmail.com>

RUN apt-get update -y

RUN apt-get install -y autoconf libtool
RUN npm install -g typescript

#Set the working directory to be the home directory
WORKDIR /home/safeuser

# Switch to user account.
USER safeuser
# Prep 'sudo' commands.
#RUN echo 'abcd8765' | sudo -S pwd

# Clone the Bitcore repository
WORKDIR /home/safeuser
#RUN git clone https://github.com/christroutner/SLPDB
RUN git clone https://github.com/simpleledger/SLPDB
WORKDIR /home/safeuser/SLPDB
RUN git checkout f6bdfd3da284435af4757dc34e2bcd771fbd23a5
#RUN git checkout unstable
RUN npm install
#COPY config.ts config.ts

# Call out the persistant volumes
VOLUME /home/safeuser/SLPDB/_leveldb
VOLUME /home/safeuser/config

COPY startup-script.sh startup-script.sh
CMD ["./startup-script.sh"]
