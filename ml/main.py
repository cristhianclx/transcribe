# -*- coding: utf-8 -*-

import os

import runpod

RUNPOD_API_KEY = os.getenv("RUNPOD_API_KEY")
RUNPOD_ENDPOINT_ID = os.getenv("RUNPOD_ENDPOINT_ID")

runpod.api_key = RUNPOD_API_KEY
runpod_instance = runpod.Endpoint(RUNPOD_ENDPOINT_ID)

try:
    run_request = runpod_instance.run_sync(
        {
            "input": {
                "audio": "https://github.com/runpod-workers/sample-inputs/raw/main/audio/gettysburg.wav",
                "model": "large-v3",
                "transcription": "plain_text",
                "enable_vad": True,
            }
        },
        timeout=298,
    )
    print("runpod.io - language: {}".format(run_request["detected_language"]))
    print("runpod.io - transcription: {}".format(run_request["transcription"]))
except TimeoutError:
    print("runpod.io - timeout")
