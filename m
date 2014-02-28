From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
Date: Sat, 01 Mar 2014 00:24:38 +0100
Message-ID: <1458913.mU1RdcNOty@vostro.rjw.lan>
References: <1393588172-20640-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56500 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751184AbaB1XJe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2014 18:09:34 -0500
In-Reply-To: <1393588172-20640-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>

On Friday, February 28, 2014 12:49:32 PM Ulf Hansson wrote:
> While fetching the proper runtime PM callback, we walk the hierarchy of
> device's power domains, subsystems and drivers.
> 
> This is common for rpm_suspend(), rpm_idle() and rpm_resume(). Let's
> clean up the code by using a macro that handles this.
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Can you please repost the entire series?  It would be a bit easier to handle
this way.

> ---
> 
> Changes in v3:
> 	Added functions to return the callbacks, which will be the only users of
> 	the macro. According to comments from Alan Stern and Kevin Hilman.
> 
> Changes in v2:
> 	Updated the macro to return a callback instead.
> 	Suggested by Josh Cartwright.
> 
> ---
>  drivers/base/power/runtime.c |   78 +++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 72e00e6..ac495b1 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -13,6 +13,42 @@
>  #include <trace/events/rpm.h>
>  #include "power.h"
>  
> +#define RPM_GET_CALLBACK(dev, cb)				\
> +({								\
> +	int (*__rpm_cb)(struct device *__d);			\
> +								\
> +	if (dev->pm_domain)					\
> +		__rpm_cb = dev->pm_domain->ops.cb;		\
> +	else if (dev->type && dev->type->pm)			\
> +		__rpm_cb = dev->type->pm->cb;			\
> +	else if (dev->class && dev->class->pm)			\
> +		__rpm_cb = dev->class->pm->cb;			\
> +	else if (dev->bus && dev->bus->pm)			\
> +		__rpm_cb = dev->bus->pm->cb;			\
> +	else							\
> +		__rpm_cb = NULL;				\
> +								\
> +	if (!__rpm_cb && dev->driver && dev->driver->pm)	\
> +		__rpm_cb = dev->driver->pm->cb;			\
> +								\
> +	__rpm_cb;						\
> +})
> +
> +static int (*rpm_get_suspend_cb(struct device *dev))(struct device *)
> +{
> +	return RPM_GET_CALLBACK(dev, runtime_suspend);
> +}
> +
> +static int (*rpm_get_resume_cb(struct device *dev))(struct device *)
> +{
> +	return RPM_GET_CALLBACK(dev, runtime_resume);
> +}
> +
> +static int (*rpm_get_idle_cb(struct device *dev))(struct device *)
> +{
> +	return RPM_GET_CALLBACK(dev, runtime_idle);
> +}
> +
>  static int rpm_resume(struct device *dev, int rpmflags);
>  static int rpm_suspend(struct device *dev, int rpmflags);
>  
> @@ -310,19 +346,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
>  
>  	dev->power.idle_notification = true;
>  
> -	if (dev->pm_domain)
> -		callback = dev->pm_domain->ops.runtime_idle;
> -	else if (dev->type && dev->type->pm)
> -		callback = dev->type->pm->runtime_idle;
> -	else if (dev->class && dev->class->pm)
> -		callback = dev->class->pm->runtime_idle;
> -	else if (dev->bus && dev->bus->pm)
> -		callback = dev->bus->pm->runtime_idle;
> -	else
> -		callback = NULL;
> -
> -	if (!callback && dev->driver && dev->driver->pm)
> -		callback = dev->driver->pm->runtime_idle;
> +	callback = rpm_get_idle_cb(dev);
>  
>  	if (callback)
>  		retval = __rpm_callback(callback, dev);
> @@ -492,19 +516,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>  
>  	__update_runtime_status(dev, RPM_SUSPENDING);
>  
> -	if (dev->pm_domain)
> -		callback = dev->pm_domain->ops.runtime_suspend;
> -	else if (dev->type && dev->type->pm)
> -		callback = dev->type->pm->runtime_suspend;
> -	else if (dev->class && dev->class->pm)
> -		callback = dev->class->pm->runtime_suspend;
> -	else if (dev->bus && dev->bus->pm)
> -		callback = dev->bus->pm->runtime_suspend;
> -	else
> -		callback = NULL;
> -
> -	if (!callback && dev->driver && dev->driver->pm)
> -		callback = dev->driver->pm->runtime_suspend;
> +	callback = rpm_get_suspend_cb(dev);
>  
>  	retval = rpm_callback(callback, dev);
>  	if (retval)
> @@ -724,19 +736,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>  
>  	__update_runtime_status(dev, RPM_RESUMING);
>  
> -	if (dev->pm_domain)
> -		callback = dev->pm_domain->ops.runtime_resume;
> -	else if (dev->type && dev->type->pm)
> -		callback = dev->type->pm->runtime_resume;
> -	else if (dev->class && dev->class->pm)
> -		callback = dev->class->pm->runtime_resume;
> -	else if (dev->bus && dev->bus->pm)
> -		callback = dev->bus->pm->runtime_resume;
> -	else
> -		callback = NULL;
> -
> -	if (!callback && dev->driver && dev->driver->pm)
> -		callback = dev->driver->pm->runtime_resume;
> +	callback = rpm_get_resume_cb(dev);
>  
>  	retval = rpm_callback(callback, dev);
>  	if (retval) {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
