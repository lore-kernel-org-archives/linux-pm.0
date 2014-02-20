From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Sleep / Runtime: Add pm_runtime_suspend|resume_force functions
Date: Thu, 20 Feb 2014 02:27:31 +0100
Message-ID: <1566282.iCFPmzopVa@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1402191556170.1133-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61645 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751621AbaBTBMk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 20:12:40 -0500
In-Reply-To: <Pine.LNX.4.44L0.1402191556170.1133-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@linaro.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>

On Wednesday, February 19, 2014 03:59:13 PM Alan Stern wrote:
> On Thu, 13 Feb 2014, Ulf Hansson wrote:
> 
> > This patch provides two new runtime PM helper functions which intend to
> > be used from system suspend/resume callbacks, to make sure devices are
> > put into low power state during system suspend and brought back to full
> > power at system resume.
> > 
> > The prerequisite is to have all levels of a device's runtime PM
> > callbacks to be defined through the SET_PM_RUNTIME_PM_OPS macro, which
> > means these are available for CONFIG_PM.
> > 
> > By using the new runtime PM helper functions especially the two
> > scenarios below will be addressed.
> > 
> > 1) The PM core prevents .runtime_suspend callbacks from being invoked
> > during system suspend. That means even for a runtime PM centric
> > subsystem and driver, the device needs to be put into low power state
> > from a system suspend callback. Otherwise it may very well be left in
> > full power state (runtime resumed) while the system is suspended. By
> > using the new helper functions, we make sure to walk the hierarchy of
> > a device's power domain, subsystem and driver.
> > 
> > 2) Subsystems and drivers need to cope with all the combinations of
> > CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME. The two new helper functions
> > smothly addresses this.
> 
> I don't know how Rafael feels about this proposal.

Quite frankly, I don't see much point in adding helpers without any users.

> One aspect of it is striking, however...
> 
> > +#ifdef CONFIG_PM
> > +/**
> > + * pm_runtime_force_suspend - Force a device into suspend state if needed.
> > + * @dev: Device to suspend.
> > + *
> > + * Disable runtime PM so we safely can check the device's runtime PM status and
> > + * if it is active, invoke it's .runtime_suspend callback to bring it into
> > + * suspend state. Keep runtime PM disabled to preserve the state unless we
> > + * encounter errors.
> > + *
> > + * Typically this function may be invoked from a system suspend callback to make
> > + * sure the device is put into low power state.
> > + */
> > +int pm_runtime_force_suspend(struct device *dev)
> > +{
> > +	int (*callback)(struct device *);
> > +	int ret = 0;
> > +
> > +	pm_runtime_disable(dev);
> > +
> > +	/*
> > +	 * Note that pm_runtime_status_suspended() returns false while
> > +	 * !CONFIG_PM_RUNTIME, which means the device will be put into low
> > +	 * power state.
> > +	 */
> > +	if (pm_runtime_status_suspended(dev))
> > +		return 0;
> > +
> > +	if (dev->pm_domain)
> > +		callback = dev->pm_domain->ops.runtime_suspend;
> > +	else if (dev->type && dev->type->pm)
> > +		callback = dev->type->pm->runtime_suspend;
> > +	else if (dev->class && dev->class->pm)
> > +		callback = dev->class->pm->runtime_suspend;
> > +	else if (dev->bus && dev->bus->pm)
> > +		callback = dev->bus->pm->runtime_suspend;
> > +	else
> > +		callback = NULL;
> > +
> > +	if (!callback && dev->driver && dev->driver->pm)
> > +		callback = dev->driver->pm->runtime_suspend;
> > +
> > +	if (!callback) {
> > +		ret = -ENOSYS;
> > +		goto err;
> > +	}
> > +
> > +	ret = callback(dev);
> > +	if (ret)
> > +		goto err;
> > +
> > +	pm_runtime_set_suspended(dev);
> > +	return 0;
> > +err:
> > +	pm_runtime_enable(dev);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
> 
> Most of this code is already present in rpm_suspend.  Instead of 
> copying it, you should put it in a separate function that can be 
> invoked from both places.
> 
> The same is true of your pm_runtime_force_resume routine.

Agreed.

Thanks,
Rafael

