# Use the official Ubuntu base image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /app/

# Update the package lists and install necessary dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip

RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN export SDL_AUDIODRIVER='dsp'

# Copy the requirements file into the container at /app
COPY requirements.txt /app/requirements.txt

# Install any needed packages specified in requirements.txt

# Copy the current directory contents into the container at /app
COPY alarm.wav /app/alarm.wav
COPY models/model.h5/  /app/models/model.h5
COPY streamlit_app.py/ /app/streamlit_app.py


# Make port 5000 available to the world outside this container
# EXPOSE 5000
RUN pip3 install --no-cache-dir -r requirements.txt
RUN export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

EXPOSE 8501

# Run app.py when the container launches
CMD ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]

# CMD ["ls"]