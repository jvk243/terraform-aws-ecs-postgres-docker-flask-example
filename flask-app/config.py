import os

basedir = os.path.abspath(os.path.dirname(__file__))


def get_env_variable(name):
    try:
        return os.environ[name]
    except KeyError:
        message = "Expected environment variable '{}' not set.".format(name)
        raise Exception(message)


class Config(object):
    DEBUG = True
    SECRET_KEY = get_env_variable('APP_SECRET_KEY')
    SESSION_TYPE = 'redis'
    SQLALCHEMY_DATABASE_URI_1 = 'postgresql+psycopg2://{user}:{pw}@{url}/{db}'.format(user=get_env_variable("POSTGRES_USER"),
                                                                                    pw=os.getenv("POSTGRES_PASSWORD"),
                                                                                    url=os.getenv("POSTGRES_ENDPOINT"),
                                                                                    db=os.getenv("POSTGRES_DATABASE"))
    SQLALCHEMY_TRACK_MODIFICATIONS = False