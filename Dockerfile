# Use official Python image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy app files to the container
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Run the app
CMD ["python", "app.py"]
