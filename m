From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] PM / sysfs: Convert to use sysfs_streq()
Date: Wed, 15 Nov 2017 13:41:35 +0200
Message-ID: <1510746095.25007.238.camel@linux.intel.com>
References: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
         <20171115103252.GA32656@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:21943 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964986AbdKPN5x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Nov 2017 08:57:53 -0500
In-Reply-To: <20171115103252.GA32656@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wed, 2017-11-15 at 11:32 +0100, Pavel Machek wrote:
> Hi!
> 
> > ...instead of custom approach.
> > 

> >  			     const char * buf, size_t n)
> >  {
> > -	char *cp;
> > -	int len = n;
> > -
> > -	cp = memchr(buf, '\n', n);
> > -	if (cp)
> > -		len = cp - buf;
> >  	device_lock(dev);
> > -	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto,
> > len) == 0)
> > +	if (sysfs_streq(buf, ctrl_auto))
> >  		pm_runtime_allow(dev);
> > -	else if (len == sizeof ctrl_on - 1 && strncmp(buf, ctrl_on,
> > len) == 0)
> > +	else if (sysfs_streq(buf, ctrl_on))
> >  		pm_runtime_forbid(dev);
> >  	else
> >  		n = -EINVAL;
> 
> Are you sure?

Yes.

>  _streq does not get passed size_t n; how does it
> guarantee no out-of-bounds access?

It's guaranteed by kernfs for every attribute that relies on it.

https://www.spinics.net/lists/kernel/msg2635067.html

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
