from flash import Flask
server = Flask(__name__)

@server.route("/")
def hello():
    return "Hello World (from Flask in Python)."

if __name__ == "__main__":
    server.run()
