---
layout: post
title: "Levels of Login Literacy"
---

During the holidays I helped a relative set up his new tablet. He needed an account on the device’s App Store in order to install Facebook Messenger. I tried to create an account using his email, but he didn’t remember what his email address was. Without that information I didn’t think he would be able to recover his account in case he got locked out for any reason. So instead, I created a burner account and stored the credentials on my password manager just so he can download the app.

I realized I’m not the only one who had to help out a relative like this. Security advocates like myself want everyone to learn the best security practices, but this isn’t an obtainable goal. There are many people who grew up in a time when passwords weren’t a necessity, others whose disabilities hinder their ability to memorize their accounts, and others who are otherwise capable but just can’t be bothered. There are users who rely on password books to remember their login credentials, or delegate those duties to another human, but realistically this is the only way for them to manage their logins.

This inspired me to draft out a system that places people in different tiers based on how well they manage their credentials. Let’s talk about the highest tier first and work our way down.

**High Literacy:** this pretty much as good as you can get. People here follow most, if not all, of the best practices for managing their logins:
* Using passwords that are hard to guess
* Having a different password for each account
* Changing their password in the event of a data breach or when they suspect that someone else has guessed it
* Enabling multi-factor authentication
* Protecting their recovery email (and recovery codes if services provide them)

**Medium Literacy:** somewhere between the above level and the one below. I’m not sure where the boundaries should be, but I think a middle tier should exist since it isn’t fair to lump users that are adapting some safe practices together with those who are adapting none at all.

**Minimum Literacy:** users in this tier are seemingly reckless in terms of managing their credentials. They might have a simple password (like “monkey123”) and use it on all of their accounts, and they probably have it written on a sticky note in front of their computer. However, here’s what sets them apart from the absolute bottom: at least they can log into their accounts. Sure, some random person can break into their account and lock them out, but if no such incident happens they have the same ability to access their accounts as the people higher up.

**Zero Literacy:** this is a category I rarely hear about, but it will be the focus for the remainder of the article.

There are people who are unable to manage their login credentials on a most basic level. They don’t just forget what their passwords are, they don’t know what their username is either. They lack the means to recover their accounts. If you ask them what their email address is they’ll say something like “(my first name) dot com” which isn’t even an email address because it doesn’t have an @ sign. It’s a frustrating experience assisting users on this tier, both for the person helping out and for the one being helped.

I’m pretty sure this is a situation services want to avoid as well. Most authentication systems are built with the assumption that users have a baseline level of password literacy. Otherwise, it’s a difficult for customer service to tell whether a person calling in is the legitimate owner of an account. Services ride a fine line between being too lenient and being too secure, and nobody wants to make the wrong call.

Note that I didn’t state which one of the tiers is the most populous because honestly I don’t know. It’s very possible that the majority of people are in this bottom tier, making this a bigger problem than we think.

I’m not sure where to go forward from here. We can continue this cycle of users being locked out their accounts or having that access given to the wrong person. We could make people be custodians for another person’s login credentials, so that person can no longer worry about remembering their credentials. Or we can wait for someone to invent a “[god login](https://blog.codinghorror.com/the-god-login/)” so this never becomes an issue again. Until then, building a secure system will always bring forth difficult challenges.
