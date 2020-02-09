---
layout: post
title: "I Just Added Google Analytics to This Blog"
---

I've already added Google Analytics to [my main site](https://www.dandelarosa.net) to see if people are visiting, but I haven't done so on this blog until now. There's already a fine guide on [Desired Persona](https://desiredpersona.com/google-analytics-jekyll/) on adding GA to your GitHub Pages site, but it your site runs on the Minima theme adding Google Analytics is even easier.

This post assumes the following:
- Experience developing a site using GitHub Pages
- Experience using Google Analytics

# Create a New Property

To create a property, log in to [https://analytics.google.com/](https://analytics.google.com/). Go to the Admin page by tapping the gear icon on the bottom left corner of the screen. Tap on the "Create Property" button, on the "Property" column in the middle of the screen. Select "Web", enter your website's site, and tap "Create". You'll be shown the tracking code; for the purposes of this task you'll only to copy your tracking ID (it should look something like UA-XXXXXXXX-X).

# Activating Google Analytics

Go to your site's `_config.yml` and add the following lines (don't forget to sub in your GA ID):

```
# Google Analytics
google_analytics: UA-XXXXXXXX-X
```

It's that simple!

To ensure that it's been set up correctly, restart your server with the following command: `JEKYLL_ENV=production bundle exec jekyll serve --force_polling`

Check your page's source to make sure the tracking snippet is present. Don't worry if data isn't being sent to Google Analytics from localhost; it's probably won't do since the domain doesn't match the one you set when you created your property, and ad blockers disable GA anyway.

Push the code change to your repository and test on your live site. Use the "Realtime" section of Google Analytics to see if your visit is being counted.

With that, you can now start counting views on your website.
