import os
from application import create_app

app = create_app()

if __name__ == '__main__':
    app.run(threaded=True, host='0.0.0.0', port=int(os.getenv('APP_PORT')))
