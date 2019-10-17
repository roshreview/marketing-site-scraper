# RoshReview Marking Website Crawler (www.roshreview.com)

This little app uses [Kimurai](https://github.com/vifreefly/kimuraframework) to crawl `www.roshreview.com` and look for all of the links within each page that point to `app.roshreview.com`.  It then spits out four files:
1. a file of all of the `www.roshreview.com` links the exist on `www.roshreview.com`
2. a file of all of the `www.roshreview.com` links that were visited urls on `www.roshreview.com`
3. a file of all of the `app.roshreview.com` links that exist on `www.roshreview.com`
4. a file of all of the `app.roshreview.com` links that were visited (_will be empty_)

Each file name has the following structure: `<hostname>_all_urls_<datetime>` or `<hostname>_visited_urls_<datetime>` where `<hostname>` will equal either `www.roshreview.com` or `app.roshreview.com` and `<datetime>` will be the date and time the file is created

## Prerequisites

In order to run this application, you'll need 
- ruby 2.5.0 or greater
- bundler

## Installation

Git clone this repository, then install dependencies with
```
bundle install
```

## Running

With depdencies installed you can now run the application with
```
ruby roshreview_marketing_crawler.rb
```

_Note: this crawler doesn't make use of any parrallelism so it's slow.  Go get yourself a cup of coffe or something after you start it_
