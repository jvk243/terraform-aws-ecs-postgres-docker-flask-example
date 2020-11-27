# -*- coding: utf-8 -*-
import os
from werkzeug.utils import secure_filename
from flask import (
    Blueprint,
    render_template, session, g, flash, request, redirect, url_for,
    jsonify,
    send_from_directory,
    request,
    current_app
)
from flask_login import login_user

import logging

from .model import User, db

logger = logging.getLogger(__name__)

web = Blueprint('web', __name__, template_folder='templates')


@web.route('/', methods=['GET', 'POST'])
def hello_world():
    payload = []
    all_users = User.query.all()
    for user in all_users:
        individual = {
            'id': user.id,
            'email': user.email,
            'active': user.active
        }
        payload.append(individual)
    return jsonify({'status': 'success', 'data': payload}), 200


# http://localhost:5000/save?email=name&active=True&id=1
@web.route('/save', methods=['GET', 'POST'])
def save_data():
    user_id = request.args.get('id')
    user_email = request.args.get('email')
    user_active = request.args.get('active')

    print(str(user_id) + ':::::> ' + str(user_email) + ':::::> ' + str(user_active))

    user = User.query.filter_by(id=user_id).first()
    if not user is None:
        print(str(user.id))
    else:
        print('User Id Doesnt exist')
        user = User(id=user_id, email=user_email, active=user_active)
        db.session.add(user)
        db.session.commit()

    login_user(user)

    return redirect("/")