From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm_runtime_enable() in ->probe()
Date: Tue, 4 Nov 2014 11:45:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411041122100.966-100000@iolanthe.rowland.org>
References: <1541129.B9pCFxZjPi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51307 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750914AbaKDQpc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 11:45:32 -0500
In-Reply-To: <1541129.B9pCFxZjPi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, 4 Nov 2014, Rafael J. Wysocki wrote:

> > I still think this needs to be handled at the level of the subsystem 
> > and device driver, not at the level of the PM core.  If somebody needs 
> > to insure that the device won't be powered off while the probe routine 
> > is running, the subsystem/driver should take care of it.
> 
> The problem with that is that doing pm_runtime_resume() (or equivalent)
> anywhere in the bus type's or driver's ->probe() will trigger the driver's
> PM callbacks (for the majority of bus types).

If the subsystems do the wrong thing, they should be fixed.

> PM domains complicate that even further, because they may override bus type
> callbacks.
> 
> > After all, as Kevin points out, sometimes we really _do_ want the
> > device to end up powered-down when the probing is finished.  There's
> > no way the PM core can guess what the driver layer will want in the
> > end.
> 
> And as I said in a reply to Kevin, if we do
> 
> 	pm_runtime_get_sync(dev);
> 	ret = really_probe(dev, drv);
> 	pm_runtime_put(dev);
> 
> in driver_probe_device(), then the last statement will power down the device
> properly, unless the driver's ->probe() bumped up the reference counter.

The problem is that the division of labor between the subsystem and the 
device driver is not clearly defined, and different subsystems handle 
things in different ways.

Scenario 1:	The subsystem does all the necessary preparation
		when the device is detected and probed.  The driver
		doesn't have to worry about runtime PM during either
		probe or remove.

		In this case it doesn't much matter what the PM core
		does.  Your suggestion would work well, and the 
		existing code is already okay.

Scenario 2:	The subsystem does very little preparation and expects
		the driver to take care of all the runtime PM.  When
		the driver's probe routine is called, the device is 
		still in its initial low-power state.  If the probe
		fails, the driver wants to leave the device in a low-
		power state and disabled for runtime PM.

		In this case calling pm_runtime_get_sync() before
		really_probe() and pm_runtime_put() afterward won't
		work.  The pm_runtime_put() will fail and the device 
		will be left at full power, because after the probe
		routine doesn't succeed, runtime PM is left disabled.

Nothing the PM core can do will work perfectly for both scenarios and 
relieve the subsystem and driver of their responsibilities.


> Suppose that the device is in a power domain that was turned off before
> probing the driver, whatever the reason.  It needs to but turned on for
> the driver to be able to access the device in ->probe() and now the question
> is how to do that.

How did the device get put into the power domain in the first place?  
If the subsystem put it there, then presumably the subsystem is
sophisticated enough about runtime PM to handle the requirements
properly (or to be fixed if it doesn't).

Similarly, power domains need to understand how runtime PM is meant to 
work.

> The natural way would be to call pm_runtime_get_sync(dev) at the beginning
> of ->probe(), but that would trigger the driver's own ->runtime_resume() to
> run and it would require the driver to do some extra checks in that routine.
> Those checks wouldn't be necessary at any other time.
> 
> However, if the core does pm_runtime_get_sync(dev) before calling
> really_probe(), it may turn on the power domain without invoking runtime
> PM callbacks from the driver.

What if the device is disabled for runtime PM before really_probe() 
runs?  Isn't that the default situation?

In general, if the kernel expects a device to operate properly only
when it is bound to the right driver, then we shouldn't expect runtime
PM to operate properly if the binding doesn't exist yet or is only
partially complete.


> It looks like we need an agreement on what to do and what the expectations
> should be for each driver core operation at the high level.  That is,
> what ->probe() should expect, what ->remove() should expect, what the   
> state after executing each of them should be for CONFIG_PM_RUNTIME set and
> unset etc.  Otherwise we'll always have various bus types doing what *they*
> think is appropriate and not agreeing with each other.

That's a very good idea.  If it can be done... since there is so much 
variation among all the different subsystems.

Alan Stern

