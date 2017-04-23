
Printscreen is a [Plated^](https://github.com/xriss/plated) component.

# Printscreen

1. Go to Settings > Keyboard > Application Shortcuts
2. Add a new shortcut command ```/home/user/printscreen/printscreen.sh```
3. Assign the keyboard key combination to trigger this script

When you trigger the script, a screenshot of your desktop is taken and a text editor is launched.

Posts are written in [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet), screenshots are kept in folders in [/blog](https://github.com/notshi/printscreen/tree/master/plated/source/blog).

Screenshots are resized to thumbnail and pixel sizes, alongside the orginal full size image.

Every time you trigger the script, your new post is published to Github **after** you exit the text editor. This also applies to Twitter, if enabled; the script auto-tweets your screenshot and post.

# Enable posting to Twitter

Run ```pip install twython```

1. Go to https://apps.twitter.com
2. Create a new app - _You will need to give Twitter a mobile number for this to work_
3. Click on the **Keys and Access Tokens** tab
4. Scroll down and click on **Generate Access Token**
5. Create a ```tweet.keys``` file in root
6. Add these twitter keys on **4** seperate lines
    - Under **Application Settings** _(scroll up)_
      - Consumer Key (API Key)
	  - Consumer Secret (API Secret)
    - Under **Your Access Token** _(scroll down)_
	  - Access Token
	  - Access Token Secret
