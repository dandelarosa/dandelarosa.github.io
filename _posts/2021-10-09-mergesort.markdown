---
layout: post
title: "Mergesort"
---

If you’ve stumbled upon my blog and you’re applying to one of [these](https://smrtr.io/6sg-3) [positions](https://smrtr.io/6jMsq) on my team, you’re in luck! I’m one of the interviewers and I’ll use this opportunity to help you out in the interview process.

In the final round of interviews we test candidates on their knowledge of algorithms, which includes coding a sorting algorithm. This is an area where unfortunately I’ve witnessed many candidates struggle. Hopefully, after reading this you’ll be on track to succeed with this section.

[Mergesort](https://en.wikipedia.org/wiki/Merge_sort) is one of the algorithms most commonly mentioned when sorting arrays. It uses divide and conquer as a strategy to sort elements more efficiently than a brute-force approach. Here’s how mergesort works on a conceptual level:
- Divide an array in half until you have subarrays that are one element long.
- Combine adjacent subarrays into a larger array by iterating through both in ascending order. This procedure is commonly referred to as a [merge](https://en.wikipedia.org/wiki/Merge_algorithm) function. Doing this results in a sorted array when the two subarrays are already presorted. This presumption is always true when subarrays contain only one element, which is why we start at the one-element-long level.
- Continue combining subarrays until you’re back to a single array, now sorted.

Given an array of length n, mergesort runs in O(nlogn) time. This is because:
- We can only halve the array log(n) times.
- On each level, we iterate through all n elements using the merge function.
- Thus, we take n times log(n) operations.

Below is an implementation of mergesort that I’ve written…in C! Don’t think I can make this too easy for you. You’re going to have to figure out on your own how to port this code to JavaScript, Ruby, or your programming language of choice. Hopefully this resource will help you perform well in our interviews in the future.

<script src="https://gist.github.com/dandelarosa/e51cf86aed9ebcd83b7ec63769968a04.js"></script>
