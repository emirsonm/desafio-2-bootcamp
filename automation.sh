#!/bin/bash

export TEMP=./tempdir
export TEMPLATES=$TEMP/templates
export STATIC=$TEMP/static

mkdir $TEMP
mkdir $TEMPLATES
mkdir $STATIC

echo "body {background: lightsteelblue;}" > $STATIC/style.css
cat << EOF > $TEMPLATES/index.html
<html>
<head>
    <title>Desafio-2-bootcamp</title>
    <link rel="stylesheet" href="/static/style.css" />
</head>
<body>
    <h1>You are calling me from {{request.remote_addr}}</h1>
</body>
</html>
EOF
cat << EOF > $TEMP/desafio2_app.py
from flask import Flask
from flask import request
from flask import render_template


sample = Flask(__name__)

@sample.route("/")
def main():
    return render_template("index.html")

if __name__ == "__main__":
    sample.run(host="0.0.0.0", port=5050)
EOF
cat << EOF >$TEMP/Dockerfile
FROM python
RUN pip install flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY desafio2_app.py /home/myapp/
EXPOSE 5050
CMD python3 /home/myapp/desafio2_app.py
EOF
#### BUILD CONTAINER
cd $TEMP
docker build -t python_app .
#### START CONTAINER
docker run -t -d -p 5050:5050 --name python_app python_app
