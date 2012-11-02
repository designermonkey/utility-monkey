#Utility Monkey XSL

A small collection of useful templates for your Symphony development projects.

This kit relies on specific extensions for some of the templates to function without errors, namely Device Categorizr, and Environment.

Includes some templates from other kits.

##aspect-ratio-calculator.xsl

A very simple set of templates for calculating the output width or height.

###aspect-ratio-by-width

Supply original width and height, and desired output width to calculate the correct output height.

###aspect-ratio-by-height

Supply original width and height, and desired output height to calculate the correct output width.


##datetime.utilities.xsl

After struggling to correctly output a 'Time Ago' for a twitter account where none of the provided date timezones matched (which resulted on occasion with '4 hours in the future'), I created these simple templates to normalise dates to UTC time.

###get-utc-from-iso-datetime

Provided with a standard ISO-8601 datetime, this utility will normalise the date and time correctly as though it were UTC (GMT0) time.

###get-utc-from-string-datetime

Provided a datetime in the format of `Mon, 09 Oct 2012 16:19:00 +0400` this utility will output an IS)-8601 datetime for the above utility (for instance).


##email-obfuscation.xsl

This handy little utility will make sure that email addresses added to your website are not output into the HTML. This requires a simple JavaScript to operate correctly. Of course, this doesn't output anything if there is no JavaScript active in the browser.

The JavaScript (jQuery here) is like the following:

		$("a.obfuscated").each(function() {
			var emailLink = $(this),
				email = emailLink.data('identity') + '@' + emailLink.data('domain');

			emailLink.attr('href', 'mailto:' + email).text(email);
		});

##get.image.xsl

This set of utilities is for outputting images with the use of JIT. Methods for retina output, and lazy loading of images are included, which will rely on JavaScript to function correctly, although has a `noscript` fallback.

**All the retina functionality expects a device pixel ratio of 2.0**

###jit-basic-image

Output a basic image without resizing. Requires a standard Symphony `image` node from any of the `file-upload` extensions. Also, can have an `alt` string supplied, and gives the choice for outputting retina data, and whether to use a lazyload JavaScript.

###jit-resize-image

A little more complex JIT processing here, for a resize only. This utility was written to provide different sized images based on set size for devices, to try and help alleviate the download bandwidth for mobile devices. It is by no means perfect, and personally, I've used other more specific utilities for projects to provide more accurate images, but this is the best general one I can come up with.

As with the `jit-basic-image` utility, all the parametes are the same, other than a `device` parameter to tell the utility to format for a specific type of device. The default is to use `device-categorizr` to set the device type. This can be overridden by providing a `specific-width` that will force the utility to that width.

The parameters used to specify the device-widths are as folows:

* `image-width-mobile`
* `image-width-tablet`
* `image-width-desktop`
* `image-width-tv`

These are specified in the `html5.master.xsl` template, but can be specified instead for each page of your site. Obviously, these sizes are quite specific globally, as this utility was developed for a site that had hero images of the same size across the whole site.

###jit-image-meta

Used by the previous utility to get specific information about the image. Returns a `path`, `width` or `height`.

###Whu? How?? No JavaScript!

It's advisable to hide the images in case of no JavaScript. In practice this was done using Modernizr to check whether JS was enabled, hiding it if it wasn't. Utilise the `classes` parameter to make this easy.

		.no-js .your-class-name {
			display: none;
		}

Tht way the `noscript` tag can shine through without a massive gap in the page.

###Erm, Retina?

Using the `placeholder` parameter allows you to provide a transparent image to load before the JavaScript can check the pixel density of the page to choose the right image source. Again, Modernizr is useful for this, or [this script by Paul Irish, altered by cott Jehl](https://github.com/scottjehl/matchMedia.js), which is part of Modernizr anyway.

Retina and normal image paths are provided into `data-low` and `data-high` attributes which can be used to replace the `src` and then removed.

How you do this, and also Lazy Loading is entirely up to you.

##get.navigation.xsl

Pretty easy navigation utilities, uses `match` not `name`. We all know how to do these ;o)

##get.page-title.xsl

Pretty easy page title utility. We all know how to do these ;o)

##master templates

After trying different methods to output content in different formats, I came up with using a switchboard. This switchboard should be included in your pages instead of the usual master template for HTML output, as advised in the tutorials on getsymphony.com.

There is still a little issue with the output of JSON at present, as this outputs as xml :o(

A default API key for each method other than HTML5is provided, but **change these!!**

After this is all set up, create templates for each page that output data in the method you want.





