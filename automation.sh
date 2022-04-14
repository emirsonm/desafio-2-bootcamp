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
