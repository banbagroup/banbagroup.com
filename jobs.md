---
title: Banba Group | Jobs
layout: default
---

<div class="content clearfix" style="margin-top: 50px;">
  <!-- Intro Title Section 2 -->
  <div class="section-block intro-title-1 small bkg-grey-ultralight">
    <div class="row">
      <div class="column width-10 offset-1">
	<div class="title-container">
	  <div class="title-container-inner">
	    <div class="row flex">
	      <div class="column width-6 v-align-middle">
		<div>
		  <h1 class="mb-0">Jobs</h1>
		  <p class="lead mb-0 mb-mobile-20">Stay in the loop with Banba Group</p>
		</div>
	      </div>
	      <div class="column width-6 v-align-middle">
		<div>
		  <ul class="breadcrumb mb-0 pull-right clear-float-on-mobile">
		    <li>
		      <a href="/">Home</a>
		    </li>
		    <li>
		      Jobs
		    </li>
		  </ul>
		</div>
	      </div>
	    </div>
	  </div>
	</div>
      </div>
    </div>
  </div>
  <!-- Intro Title Section 2 End -->
  {% for post in site.jobs reversed %}
    <div class="section-block clearfix pt-0 pb-0 bkg-grey-ultralight" style="padding-top: 20px;">
      <div class="row">

        <div class="column width-10 offset-1 content-inner blog-regular">
  	  <article class="post">
	    <div class="post-content with-background">
	      <h2 class="post-title"><a href="{{post.url}}">{{post.title}}</a></h2>
	      <div class="post-info">
	        <span class="post-date">{{ post.date | date: '%B %d, %Y' }}</span>
	      </div>
	      <p>{{ post.excerpt | strip_html | truncatewords:75 }}</p>
	    </div>
	  </article>
        </div>
      </div>
    </div>
  {% endfor %}
</div>
