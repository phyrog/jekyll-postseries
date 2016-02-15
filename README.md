# jekyll-postseries

Group your posts into series.

## Usage

Just copy the `post_series.rb` file into your plugin folder and you're all set.

Add a `series` key to the frontmatter of your posts

```
---
title: "Foobar"
layout: post
series: my-very-special-series
---

Bla
```

It does not matter what value you use, as long as it is the same on every post of the series.

You can add a block with links to other posts in this series by using the Liquid tag:

```
{% post_series %}
```
