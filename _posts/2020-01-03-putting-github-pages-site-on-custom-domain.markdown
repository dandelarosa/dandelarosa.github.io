---
layout: post
title: "Putting Your GitHub Pages Site on a Custom Domain"
---

[GitHub Pages](https://pages.github.com/) is a very convenient service. If you're a programmer you can create a static website as a code repository on GitHub and GitHub will host the content for you. Moreover, with the [Jekyll](https://jekyllrb.com/) framework you can write a blog using plaintext files instead of having to sign up for a blogging service or pay for a database. All you need is experience writing Markdown and just enough familiarity with Ruby on Rails to run Jekyll on your computer.

Moreover, what if you wanted to host your site on a custom domain (or subdomain) rather than the typical _username_.github.io? GitHub Pages will let you do that too! GitHub has comprehensive documentation on using custom domains at [this page](https://help.github.com/en/github/working-with-github-pages/configuring-a-custom-domain-for-your-github-pages-site) but here I'll write a simpler step-by-step guide on hosting your site on your own domain.

# Getting a Domain Name

Before you can transfer your site to a different domain, make sure you actually own a domain name to move to. Hover ([referral link](https://hover.com/n4WmhVHd)) is my preferred domain name registrar since their pricing model is straightforward, they don't try to upsell additional features, and they provide WHOIS privacy for free.

# Configuring Your Site

Go to your site's repository on GitHub and head over to the Settings tab.

![alt text](https://cdn-blog.dandelarosa.net/2020/01/03/putting-github-pages-site-on-custom-domain/1.png "Click on 'Settings' or the gear icon")

Scroll down to the section titled "GitHub Pages". You'll want to focus on where it says "Custom domain". Enter in your domain name in the text field and tap Save.

![alt text](https://cdn-blog.dandelarosa.net/2020/01/03/putting-github-pages-site-on-custom-domain/2.png "Setting the custom domain on your page")

GitHub might indicate that the site hasn't been set up correctly - that's because your site's DNS settings haven't been updated yet. We'll cover that in the next step.

![alt text](https://cdn-blog.dandelarosa.net/2020/01/03/putting-github-pages-site-on-custom-domain/3.png "The settings page before configuring DNS")

# Modifying Your DNS Settings

You'll need to add a CNAME record that maps your custom domain to your site on GitHub Pages. It'll look something like the following:

| Type | Name | Value |
|------|------|-------|
| CNAME | www.example.com | username.github.io |

I use Amazon Route 53 for managing DNS records; [click here](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-creating.html) for the guide on configuring them.

If you'd rather configure DNS on Hover go to [this guide](https://help.hover.com/hc/en-us/articles/217282457-Managing-DNS-records-) instead.

DNS records may take up to 48 hours to fully propogate across the Internet.

# Securing Your Site With HTTPS

Once your domain name is linked with GitHub Pages, GitHub will automatically start setting up HTTPS support. Securing your site with HTTPS is a must-do nowadays since it assures users that they're going your actual site and not a malicious wannabe. GitHub says you'll need to wait 24 hours for them to set up HTTPS but in my case they had it ready in a matter of minutes. Reload your site's settings page to check on its progress.

![alt text](https://cdn-blog.dandelarosa.net/2020/01/03/putting-github-pages-site-on-custom-domain/4.png "GitHub telling you to wait 24 hours for them to set up HTTPS on your site")

As an optional step, you can enforce HTTPS usage. Personally I choose to allow HTTPS connections only, which can be done by marking the checkbox on the page.

![alt text](https://cdn-blog.dandelarosa.net/2020/01/03/putting-github-pages-site-on-custom-domain/6.png "Mark the checkbox to allow HTTPS connections only")

I hope this article helped you set up your GitHub Pages site on your custom domain.
