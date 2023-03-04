FROM ubuntu

# Env & Arg variables
ARG USERNAME=docker
EXPOSE 22

# Update and install the required packages

RUN apt update && apt install -y openssh-server sudo

# Add non-root user

RUN useradd -ms /bin/bash $USERNAME

# Remove no need packages

RUN apt -y autoremove && apt -y autocleam && apt -y clean

# Copy the entrypoint

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# Create the ssh directory and authorized_key file

USER ${USERNAME}
RUN mkdir -p /home/${USERNAME}/.ssh
COPY ./containerkey/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

USER root
RUN chown $USERNAME /home/$USERNAME/.ssh/authorized_keys && \
    chmod 600 /home/$USERNAME/.ssh/authorized_keys

# Run entrypoint

CMD ["./entrypoint.sh"]