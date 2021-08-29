---
layout: post
title: "Learning Time Roundup: August 2021"
summary: "Programming articles I found this month"
excerpt: "Programming articles I found this month"
---

Here's a list of programming articles I found useful this month.

- [An important tip](https://vincenttunru.com/toBeTruthy-vs-toBe-true/) for writing tests for JavaScript functions that return boolean values: use the `toBe(true)` and `toBe(false)` checkers instead of the `toBeTruthy()` and `toBeFalsy()` matchers. The truthiness checkers coerce the parameter into a boolean meanining the method could be returning information you don't want to expose; the `toBe` checker solves this issue by verifying exact type.
- The second article on this list showed me how to [add a table with editable rows in an Angular reactive form](https://medium.com/@vap1231/inline-editable-table-using-dynamic-form-controls-in-angular-87eb24c0e5a5).
- Lastly here's [a primer on Reactive Programming](https://gist.github.com/staltz/868e7e9bc2a7b8c1f754) on GitHub. I probably want to make this required reading for teammates when they start their progression toward using [RxJS](https://rxjs.dev/) and [NgRx](https://ngrx.io/).
