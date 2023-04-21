from flask import Flask, render_template, request


app = Flask(__name__)

@app.route('/')
def hello_world():
    message = "I'm rendered using server-side rendering."
    host = request.headers.get('host')
    user_agent = request.headers.get('user-agent')
    return render_template("index.html", message=message, host=host, user_agent=user_agent)
