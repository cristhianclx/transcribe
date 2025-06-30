# -*- coding: utf-8 -*-

import json
import os

import boto3
from flask import (
    Flask,
    Response,
    jsonify,
    make_response,
    render_template,
    request,
    send_from_directory,
)
from flask_cors import CORS
from flask_restful import Api, Resource
from twilio.twiml.messaging_response import MessagingResponse
from utils import AWS_REGION, TRANSCRIPTIONS_QUEUE_URL

static_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), "static")
template_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), "templates")

sqs_client = boto3.client("sqs", region_name=AWS_REGION)


app = Flask(__name__, static_folder=static_folder, template_folder=template_folder)
CORS(app)
api = Api(app)


@app.route("/favicon.ico")
def favicon():
    return send_from_directory(
        os.path.join(app.root_path, "static"),
        "favicon.ico",
        mimetype="image/vnd.microsoft.icon",
    )


@app.route("/")
def main():
    return Response(
        render_template("index.txt"),
        mimetype="text/plain",
    )


@app.route("/robots.txt")
def robots():
    return Response(
        render_template("robots.txt"),
        mimetype="text/plain",
    )


class PINGResource(Resource):
    def get(self):
        return jsonify(response="pong")


class WhatsAppResource(Resource):
    def post(self):
        form = request.form
        message_sid = form.get("MessageSid", "")
        from_number = form.get("From", "")
        to_number = form.get("To", "")
        media_files = [
            {
                "url": form.get("MediaUrl{}".format(i)),
                "type": form.get("MediaContentType{}".format(i)),
            }
            for i in range(0, int(form.get("NumMedia", 0)))
        ]
        if len(media_files) > 0:
            for media_file_id, media_file in enumerate(media_files):
                sqs_client.send_message(
                    QueueUrl=TRANSCRIPTIONS_QUEUE_URL,
                    MessageBody=json.dumps(
                        {
                            "message_sid": message_sid,
                            "from_number": from_number,
                            "to_number": to_number,
                            "media_file": media_file,
                        }
                    ),
                    MessageGroupId=message_sid,
                    MessageDeduplicationId=f"{message_sid}:{media_file_id+1}",
                )
            twilio_response = MessagingResponse()
            twilio_message = twilio_response.message(
                body="Transcribing. Please wait ...",
                to=from_number,
                from_=to_number,
            )
            twilio_message.reference_message_sid = message_sid
            response = make_response(str(twilio_response))
            response.headers["Content-Type"] = "application/xml"
            return response
        return make_response("", 204)


api.add_resource(PINGResource, "/ping/")
api.add_resource(WhatsAppResource, "/whatsapp/")
