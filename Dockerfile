# Set the base image (host OS, find this on DockerHub)
FROM python:3.8-slim

# Designate the name of the working directory in the container
WORKDIR /code

# Copy the dependencies file to workdir, where workdir is represented by the .
# meaning the current directory.
COPY requirements.txt .

# Install the needed dependencies (in our case, python modules)
RUN pip install -r requirements.txt

# Copy the contents of the (local) src directory to the working directory
# (again, here the . represents the current dir, which is the workdir).
COPY src/ .

# Run the following command (in the container's command line) when the 
# container is instantiated.
CMD [ "python", "./server.py" ]
