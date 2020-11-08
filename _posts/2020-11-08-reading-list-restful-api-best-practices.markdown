---
layout: post
title: "Reading List: RESTFul API Best Practices"
---

For years, good API design was something I had clamored for. This desire originated when my previous employer Makr was acquired by Staples and sent engineers to replace the ones who left prior to acquisition. Unlike their previous counterparts, this new batch had a little bit more experience developing and using APIs. However the newcomers had trouble using and updating our backend, not for a lack of smarts but because it was cumbersome figuring how to authenticate, how to list entities, and how to take actions on those entities.

Would we have fared better if there was a set of standards we followed to make our API intuitive to pick up? That’s where this article comes in. Enchant founder and developer Vinay Sahni wrote [a list of best practices for developing an API](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api). Read the article in its entirety, since it is all good advice. (There are some items I disagree with nowadays, but I’ll cover those topics later and they do not invalidate the list as a whole.) If nothing else, I highlighted a few strategies that I want you to take away from this session.

# CRUD Actions as a Pattern for Interacting with Resources

Here are some common verb and path combinations to correspond to actions users could be expected to do on an API.

`GET /projects` - lists all projects

`GET /projects/1` - reads the details for a project with the ID of 1

`POST /projects` - creates a new project

`PUT /projects/1` - updates the project with the ID of 1

`DELETE /projects/1` - deletes the project with the ID 1

Once implemented, these actions give you the backend functionality to support your web application. Need show all of projects on the page? Load one into an editor? Save a new project or change or existing one? Remove a project you don’t like? It’s all achievable with just the five listed above.

Humans can adapt this pattern to work with other resources by substituting the noun or other variables. Need to look at different project? Swap out the ID at the end of the path. What a different resource entirely? If CRUD actions can be performed on projects, and if there are resources called users, orders, or events, one would expect the same actions to be supported for the other entities as well.

# Using Your Request’s Query String for Filtering and Sorting

Let’s say projects have the following fields: `name` (a string), `published` (a boolean), and `position` (an integer). If you only want to list projects with a certain name (as a naive form of search) you can make a request to `GET /projects?name=your_project_name` to return projects that matches the name exactly. If you want to show only published projects you would request `GET /projects?published=true` and you request `GET /projects?published=false` to get only the unpublished ones. Omitting the published parameter means you would get both published and unpublished projects. You can filter by multiple fields by combining the parameters e.g. `GET /projects?name=your_project_name&published=true`.

Another parameter, sort, can be treated as a special case as it is used to determine how the records will be sorted in the results. For example, calling `GET /projects?sort=position` will list the projects in order of position. The sort direction is ascending by default; you can reverse the direction by adding a minus sign before the field name. Like with the filters, multiple sort descriptors can be combined together - each separated with a comma - so `GET /projects?sort=name,-published` would show the projects in alphabetical order by name, showing the published version(s) first if there are ones with the same name. Moreover, the filters and sort descriptions can be combined so you can end up with something like `GET /projects?name=your_project_name&published=true&sort=position`.

# Use HTTP Response Codes as Intended by the Official Specification

The HTTP standard contains status codes that correspond to common scenarios; do your teammates (and your users) a favor by returning the status the best describes what went wrong (or how to process the response if it did in fact succeed). Don’t return a status code of 400 every time a request fails; use 401 if the user needs to be logged in first or 404 if the resource doesn’t exist. The only exception is if you want to keep certain information obscure (like the names of the files on your website) which case you would respond with the status code of 403 whenever any error occurs (this is what Amazon S3 does to keep your bucket’s contents private).

# Conclusion

Vinay Sahni’s blog post is a resource I’ve visited multiple times, and it is one I’ll keep going back to for years. It has shaped the way I view API design, and I’ve applied these best practices at work ever since I read the article. I hope you’ve learned what I expect to see in a well-designed API, and are able to apply those lessons in your future backend projects.
