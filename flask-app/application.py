import os

import click
from flask import (
    Flask, current_app
)
from flask.cli import with_appcontext
from flask_migrate import Migrate
from flask_login import LoginManager

def create_app():
    print("Hello World!!!")
    app = Flask(__name__, instance_relative_config=False)
    app.config['SESSION_TYPE'] = 'redis'
    app.config.from_object("config.Config")
    login_manager = LoginManager(app)

    from common.model import db
    db.init_app(app)

    @app.cli.command('resetdb')
    def resetdb_command():
        """Destroys and creates the database + tables."""

        SQLALCHEMY_DATABASE_URI = current_app.config["SQLALCHEMY_DATABASE_URI"]
        print("DB_URL : " + str(SQLALCHEMY_DATABASE_URI))

        from sqlalchemy_utils import database_exists, create_database, drop_database
        if database_exists(SQLALCHEMY_DATABASE_URI):
            print('Deleting database.')
            # drop_database(SQLALCHEMY_DATABASE_URI)
        if not database_exists(SQLALCHEMY_DATABASE_URI):
            print('Creating database.')
            create_database(SQLALCHEMY_DATABASE_URI)

        db.drop_all()
        print('Creating tables.')
        db.create_all()
        print('Shiny!!!')

    migrate = Migrate(app, db)

    with app.app_context():
        from common.views import web
        app.register_blueprint(web)

        @login_manager.user_loader
        def load_user(user):
            print('Login')
            f = db.User.query.filter_by(id=user.id).first()
            print(f)
            return db.User.query.filter_by(id=user.id).first()

    return app