#!/usr/bin/env python

import sys

from twython import Twython

#the secret keys from https://apps.twitter.com/app/13701843/keys
lines = open('./tweet.keys', 'r').readlines()

APP_KEY           =lines[0].strip()
APP_SECRET        =lines[1].strip()
OAUTH_TOKEN       =lines[2].strip()
OAUTH_TOKEN_SECRET=lines[3].strip()

PHOTO             =sys.argv[1]
TWEET             =sys.argv[2]


twitter = Twython(APP_KEY, APP_SECRET, OAUTH_TOKEN, OAUTH_TOKEN_SECRET)

#photo = open(PHOTO, 'rb')
#twitter.update_status_with_media(status=TWEET, media=photo)



photo = open(PHOTO, 'rb')
response = twitter.upload_media(media=photo)
twitter.update_status(status=TWEET, media_ids=[response['media_id']])

