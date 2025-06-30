# -*- coding: utf-8 -*-

import os

import runpod
from twilio.rest import Client as TwilioClient

AWS_REGION = os.getenv("AWS_REGION", "us-east-1")

TWILIO_WHATSAPP_CHAR_LIMIT = 1600

ALLOWED_AUDIO_FILES = [
    "aac",
    "flac",
    "m4a",
    "m4b",
    "mid",
    "midi",
    "mp3",
    "oga",
    "ogg",
    "opus",
    "wav",
    "webm",
    "wma",
]

RUNPOD_API_KEY = os.getenv("RUNPOD_API_KEY")
RUNPOD_ENDPOINT_ID = os.getenv("RUNPOD_ENDPOINT_ID")

runpod.api_key = RUNPOD_API_KEY
runpod_instance = runpod.Endpoint(RUNPOD_ENDPOINT_ID)

TRANSCRIPTIONS_QUEUE_URL = os.getenv("TRANSCRIPTIONS_QUEUE_URL")

TWILIO_ACCOUNT_SID = os.getenv("TWILIO_ACCOUNT_SID")
TWILIO_AUTH_TOKEN = os.getenv("TWILIO_AUTH_TOKEN")

twilio_client = TwilioClient(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)


def convert_speech_to_text(url):
    run_request = runpod_instance.run_sync(
        {
            "input": {
                "audio": url,
                "model": "large-v3",
                "transcription": "plain_text",
                "enable_vad": True,
            }
        },
        timeout=298,
    )
    return run_request.get("transcription")
