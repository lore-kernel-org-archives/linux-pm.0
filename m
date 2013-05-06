From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] thermal: cut the spaces when user sets policy
Date: Mon, 06 May 2013 10:39:07 +0300
Message-ID: <1367825947.8465.14.camel@smile>
References: <1367589128-19787-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <5183D8E7.8040708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28909 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3EFHjR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 03:39:17 -0400
In-Reply-To: <5183D8E7.8040708@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

On Fri, 2013-05-03 at 11:33 -0400, Eduardo Valentin wrote: 
> On 03-05-2013 09:52, Andy Shevchenko wrote:
> > Setting policy results in invalid value error.
> > 	% echo "step_wise" > policy
> > 	% echo: write error: Invalid argument
> > 
> > Need clean up of the buffer which "echo" may add based on the arguments, before
> > comparing aganist list of governor names.

> > @@ -716,7 +717,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
> >  
> >  	mutex_lock(&thermal_governor_lock);
> >  
> > -	gov = __find_governor(buf);
> > +	gov = __find_governor(strim(buf));
> 
> I am much happier with this approach, much cleaner and does the job. On
> the other hand, this patch introduces a compilation warning that we want
> to avoid:
> drivers/thermal/thermal_sys.c: In function 'policy_store':
> drivers/thermal/thermal_sys.c:708: warning: passing argument 1 of
> 'strim' discards qualifiers from pointer target type
> include/linux/string.h:63: note: expected 'char *' but argument is of
> type 'const char *'
> 

Oops.
What about introduce temporary variable and pass it as a parameter?
It seems explicit casting looks not good, though it makes the job.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
