# -*- coding: utf-8 -*-

import json
import logging
import mimetypes
from utils import (
    ALLOWED_AUDIO_FILES,
    TWILIO_WHATSAPP_CHAR_LIMIT,
    convert_speech_to_text,
)
from twilio.rest import Client as TwilioClient


TWILIO_ACCOUNT_SID = os.getenv("TWILIO_ACCOUNT_SID")
TWILIO_AUTH_TOKEN = os.getenv("TWILIO_AUTH_TOKEN")

twilio_client = TwilioClient(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

mimetypes.init(
    files=[
        "./ext/mime.types",
    ]
)  # AWS Lambda can't read mimetype


def transcriptions(event, context):
    for record in event["Records"]:
        message_body = json.loads(record["body"])
        from_number = message_body["from_number"]
        to_number = message_body["to_number"]
        media_file = message_body["media_file"]
        media_file_extension = mimetypes.guess_extension(media_file["type"])
        media_file_extension = media_file_extension[1:]
        if media_file_extension in ALLOWED_AUDIO_FILES:
            media_transcription = convert_speech_to_text(media_file["url"])
            words = media_transcription.split()
            message_segments = []
            current_segment = ""
            message_segments_worst_estimate = (len(media_transcription) // TWILIO_WHATSAPP_CHAR_LIMIT) + 1
            message_char_limit = TWILIO_WHATSAPP_CHAR_LIMIT - len(
                f"({message_segments_worst_estimate}/{message_segments_worst_estimate}): "
            )
            for word in words:
                if len(current_segment) + len(word) + 1 > message_char_limit:
                    message_segments.append(current_segment.strip())
                    current_segment = word + " "
                else:
                    current_segment = current_segment + word + " "
            if current_segment:
                message_segments.append(current_segment.strip())
            message_ids = []
            for message_segment_id, message_segment in enumerate(message_segments):
                message = twilio_client.messages.create(
                    body=f"({message_segment_id+1}/{len(message_segments)}): {message_segment}",
                    from_=to_number,
                    to=from_number,
                )
                message_ids.append(message.sid)
            logging.info(",".join(message_ids))
