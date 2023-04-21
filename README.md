# Flask ezHTTP
Flask ezHTTP is a quick-start template for building flask based web applications.  

# Usage and Making Changes

## Cloning Flask ezHTTP
Use standard git commands to clone Flask ezHTTP.

```shell
git clone https://github.com/YvanJAquino/flask-ez-http
cd flask-ez-http
```

Since Flask ezHTTP is designed as a quick-start template for projects, you might want to save your work in a new repository.  Delete the .git directory, change the name of the project folder, reinitialize git, and push the code to a new repo (if your using Github, you'll need to create a new repo in Github).

From the flask-ez-http directory:

```
export USERNAME=my-username
export NEW_PROJECT=new-project
sudo rm -rf .git
cd ..
mv flask-ez-http $NEW_PROJECT
cd $PROJECT
git init
git add .
git commit -m "init"
git remote add origin https://github.com/$USERNAME/$NEW_PROJECT
git push -u origin main
```


## Adding Static assets
Static assets go in the static folder.  See Flask's documentation on static files for more details: https://flask.palletsprojects.com/en/2.2.x/quickstart/#static-files

## Adding HTML & Javascript templates
Flask supports server side rendering with Jinja based HTML templating.  See Flask's documentation on rendering templates for more details: https://flask.palletsprojects.com/en/2.2.x/quickstart/#rendering-templates

## Adding other Python Libraries
Add other Python libraries by updating requirements.txt.  Flask ezHTTP was built using Python 3.10.5 but you're welcome to use whatever version of Python you need.  

The Python version you're using SHOULD match the version in the Dockerfile.  In the example below, the container will use Python 3.10 running on Debian 11 (Bullseye)

```Dockerfile
FROM    python:3.10-bullseye
ENV     PYTHONUNBUFFERED=true \
        PORT=8010
WORKDIR /app
COPY    . ./
RUN     pip install --no-cache-dir- r requirements.txt
CMD     exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app
```


To verify what version of Python is currently installed: 
```
python --version
```

In some cases, you may have different versions of Python installed.  To check which version is the current default:

```
python3 --version
```


If you need to add a lot of dependencies it might be simpler to start with your own virtual environment, starting from the root project directory:

```shell
mkdir .venv
python -m venv .venv/
source .venv/bin/activate
pip install Flask gunicorn ...
```

When you're ready to deliver your application as a container use pip freeze to define your Python dependencies into a requirements.txt:

```
pip freeze > requirements.txt
```

To avoid any major dependency headaches, make sure to check your current version of Python and compare that with base container images's Python version which is located at the top of the Dockerfile in the FROM clause.

```Dockerfile
# The default is Python 3.10
FROM    python:3.10-bullseye 
ENV     PYTHONUNBUFFERED=true \
        PORT=8010
WORKDIR /app
COPY    . ./
RUN     pip install --no-cache-dir- r requirements.txt
CMD     exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app
```

# Features
~

# Deployment

## Default Deployment
To build the Flask ezHTTP container from source, clone this repository, change the current directory to the flask-ez-http directory, and build the container with Docker:

```
git clone https://github.com/YvanJAquino/flask-ez-http
cd flask-ez-http
docker build -t local.flask-ez-http .
```

Use Docker's run command to start ezHTTP:

```
docker run -rm -p 8010:8010 local.flask-ez-http
```

# Using Docker

## Building the container
From the project directory (where the Dockerfile resides):

```
docker build -t local.flask-ez-http . 
```

## Running the container

### As a foreground process
By default, containers will run in the foreground.  If you want to communicate with your container, you'll need provide a port mapping wit the -p option:

```shell
docker run -p 8010:8010 local.flask-ez-http
```

Alternatively, you can use host networking instead of providing specific port mappings:

```shell
docker run --network=host local.flask-ez-http
```

### As a background process
Use the -d option (short for detached mode) to allow the Docker daemon to manage your container(s) as a background process.  This free's up your terminal for continued testing and development activities.

```shell
docker run -d -p 8010:8010 local.flask-ez-http
```

Using detached mode means you'll need to manage the container with other docker commands.  To list currently running containers:

```
docker ps
```
```shell
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                       NAMES
69228b0d2ad1   local.flask-ez-http   "/bin/sh -c 'exec gu…"   5 seconds ago   Up 4 seconds   0.0.0.0:8010->8010/tcp, :::8010->8010/tcp   charming_lalande
```

docker ps dynamically generates a name for the running container unless you specified one.  You can use this "easy" name to stop the container:

```
docker stop charming_lalande
```

### Automatically Removing the container when stopped
During development, you may want to automatically remove the container whenever its stopped:

```shell
docker run -it --rm -p 8010:8010 local.flask-ez-http
```

### Streamlining development activities
Making changes means you'll need to rebuild the container.  Use shell scripting to make changes easier to deal with:

```shell
pip freeze > requirements.txt && \
    docker build -t local.flask-ez-http . && \
    docker run -it --rm -p 8010:8010 local.flask-ez-http
```

### Working inside the container
Sometimes you'll need to troubleshoot the internal file structure of your project inside the container.  Use Docker's interactive mode and provide a shell to use:

```
docker run -it --rm local.flask-ez-http /bin/bash
```

See your container's base image's documentation for details on which shells are available.  

# Target User Journeys

# Planned Features
