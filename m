From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Tue, 17 Feb 2015 19:53:47 +0100
Message-ID: <1582000.j702YZSJy3@vostro.rjw.lan>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk> <E1YMedA-00054Z-TK@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49321 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751726AbbBQSaf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 13:30:35 -0500
In-Reply-To: <E1YMedA-00054Z-TK@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

First off, sorry for being slow to respond lately, I'm traveling now.

Also adding Alan Stern to the CC (please always do that for discussions
regarding the runtime PM core).

On Saturday, February 14, 2015 03:27:40 PM Russell King wrote:
> Synchronise the PM domain status with runtime PM's status.  This
> provides a better solution to the problem than commit 2ed127697eb1
> ("PM / Domains: Power on the PM domain right after attach completes").
> 
> The above commit added a call to power up the PM domain when a device
> attaches to the domain.  The assumption is that the device driver
> will cause a runtime PM transition, which will synchronise the PM
> domain state with the runtime PM state.
> 
> However, runtime PM will, by default, assume that the device is
> initially suspended.  So we have two subsystems which have differing
> initial state expectations.  This is silly.
> 
> Runtime PM requires that pm_runtime_set_active() is called before
> pm_runtime_enable() if the device is already powered up.

Well, this is an oversimplification of sorts.

What really is expected is that the RPM status of the device will agree
with its actual state at the moment when pm_runtime_enable() is called.

If the actual state of the device is "not powered", then it is invalid to
call pm_runtime_set_active() before pm_runtime_enable() even.

> However, PM domains are not informed of this, and this is where the problem
> really lies.  We need to keep PM domains properly and fully informed of their
> associated device status.

This goes backwards.  Rather, PM domains should tell everyone about what they
have done to the device IMO.  That is, since PM domains power up the device,
it would be logical to change its RPM status at that point to me.

That may lead to one subtle problem, though.

Suppose that, in addition to either having or not having a power domain under
it, the device has a clock that is managed directly by the driver.  The driver
may then want to do the clock management in its runtime PM callbacks.
However, if genpd changes the device's RPM status to "active", the runtime
PM framework will not execute the resume callback for the device, so things
will break if the clock is not actually enabled to start with.

IOW, we need a way for the driver and genpd to agree on what the RPM status
of the device should be set to before pm_runtime_enable() is executed.

> We fix this by adding a new callback - runtime_set_status() which is

I'm not sure if that's the way to address that, though.

Our intention for the pm_runtime_set_active() etc. calls was that they didn't
trigger any callbacks, since were are supposed to be executed with runtime
PM disabled.

Moreover ->

> triggered whenever a successful call to __pm_runtime_set_status().
> PM domain code hooks into this, and updates the PM domain appropriately.
> 
> This means a driver with the following sequence:
> 
> 	pm_runtime_set_active(dev);
> 	pm_runtime_enable(dev);
> 
> will trigger the PM domain to be powered up at this point, which keeps
> runtime PM and PM domains properly in sync with each other.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/power/domain.c  | 16 +++++++++++++++-
>  drivers/base/power/runtime.c |  5 +++++
>  include/linux/pm.h           |  1 +
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 11a1023fa64a..2a700cea41fc 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -741,6 +741,20 @@ static int pm_genpd_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int pm_genpd_runtime_set_status(struct device *dev)
> +{
> +	int ret;
> +
> +	dev_dbg(dev, "%s()\n", __func__);
> +
> +	if (pm_runtime_suspended(dev))
> +		ret = pm_genpd_runtime_suspend(dev);
> +	else
> +		ret = pm_genpd_runtime_resume(dev);
> +
> +	return ret;
> +}
> +
>  static bool pd_ignore_unused;
>  static int __init pd_ignore_unused_setup(char *__unused)
>  {
> @@ -1907,6 +1921,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  	genpd->max_off_time_changed = true;
>  	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
>  	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
> +	genpd->domain.ops.runtime_set_status = pm_genpd_runtime_set_status;
>  	genpd->domain.ops.prepare = pm_genpd_prepare;
>  	genpd->domain.ops.suspend = pm_genpd_suspend;
>  	genpd->domain.ops.suspend_late = pm_genpd_suspend_late;
> @@ -2223,7 +2238,6 @@ int genpd_dev_pm_attach(struct device *dev)
>  	}
>  
>  	dev->pm_domain->detach = genpd_dev_pm_detach;
> -	pm_genpd_poweron(pd);
>  
>  	return 0;
>  }
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 5070c4fe8542..a958cae67a37 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -981,6 +981,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>  	struct device *parent = dev->parent;
>  	unsigned long flags;
>  	bool notify_parent = false;
> +	pm_callback_t callback;
>  	int error = 0;
>  
>  	if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> @@ -1029,6 +1030,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>   out_set:
>  	__update_runtime_status(dev, status);
>  	dev->power.runtime_error = 0;
> +	if (dev->power.no_callbacks)
> +		goto out;
> +	callback = RPM_GET_CALLBACK(dev, runtime_set_status);
> +	rpm_callback(callback, dev);

-> That is specific to PM domains and arguably not needed otherwise, so I would
define it in struct dev_pm_domain outside of dev_pm_ops.

>   out:
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
>  
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8b5976364619..ee098585d577 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -316,6 +316,7 @@ struct dev_pm_ops {
>  	int (*runtime_suspend)(struct device *dev);
>  	int (*runtime_resume)(struct device *dev);
>  	int (*runtime_idle)(struct device *dev);
> +	int (*runtime_set_status)(struct device *dev);
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
