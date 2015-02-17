From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Tue, 17 Feb 2015 19:42:43 +0000
Message-ID: <20150217194243.GR8656@n2100.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedA-00054Z-TK@rmk-PC.arm.linux.org.uk>
 <1582000.j702YZSJy3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:47050 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbbBQTm5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 14:42:57 -0500
Content-Disposition: inline
In-Reply-To: <1582000.j702YZSJy3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Tue, Feb 17, 2015 at 07:53:47PM +0100, Rafael J. Wysocki wrote:
> First off, sorry for being slow to respond lately, I'm traveling now.
> 
> Also adding Alan Stern to the CC (please always do that for discussions
> regarding the runtime PM core).

If that is the case, how about adding them into MAINTAINERS?  Without
this information in there, Alan will probably be forgotten for future
patches.

> On Saturday, February 14, 2015 03:27:40 PM Russell King wrote:
> > Runtime PM requires that pm_runtime_set_active() is called before
> > pm_runtime_enable() if the device is already powered up.
> 
> Well, this is an oversimplification of sorts.
> 
> What really is expected is that the RPM status of the device will agree
> with its actual state at the moment when pm_runtime_enable() is called.
> 
> If the actual state of the device is "not powered", then it is invalid to
> call pm_runtime_set_active() before pm_runtime_enable() even.

We're both saying exactly the same thing, so we're in full agreement,
which is good. :)

> > However, PM domains are not informed of this, and this is where the problem
> > really lies.  We need to keep PM domains properly and fully informed of their
> > associated device status.
> 
> This goes backwards.  Rather, PM domains should tell everyone about
> what they have done to the device IMO.  That is, since PM domains
> power up the device, it would be logical to change its RPM status at
> that point to me.

Right, so it may make sense for runtime PM to query the PM domain state,
and synchronise itself with that.

> That may lead to one subtle problem, though.
> 
> Suppose that, in addition to either having or not having a power domain
> under it, the device has a clock that is managed directly by the driver.
> The driver may then want to do the clock management in its runtime PM
> callbacks.  However, if genpd changes the device's RPM status to "active",
> the runtime PM framework will not execute the resume callback for the
> device, so things will break if the clock is not actually enabled to
> start with.
> 
> IOW, we need a way for the driver and genpd to agree on what the RPM status
> of the device should be set to before pm_runtime_enable() is executed.

It's worse than that.  If, in the probe, we decide at a point to query
the PM domain status, and transfer it into the RPM status, how does the
driver know whether it needs to do a "put" to cause a transition from
active to suspended?

In the case where the PM domain was suspended, the RPM status would also
be suspended at that point, and it requires a RPM get to resume it.

If the PM domain was active, then it would require a pm_runtime_put()
operation to allow it to suspend.

This is why I decided that the methodology in the runtime PM code should
apply to PM domains: runtime PM requires the actual state to match the
runtime PM state prior to calling pm_runtime_enable().  We should also
require that the PM domain state must also match the runtime PM state
prior to runtime PM being enabled too.

> > We fix this by adding a new callback - runtime_set_status() which is
> 
> I'm not sure if that's the way to address that, though.

I've come to the conclusion that this isn't a good way to handle it,
because those drivers which may make use of PM domains without using
runtime PM will be probed with the PM domain powered down.

I think we've got a rather sticky problem here, and my proposed
solution will cause problems in that scenario.

Another possibility may be to trigger PM domains to try to power down
the domain when it sees the driver call pm_runtime_enable().  If the
driver never calls pm_runtime_enable(), the PM domain will be left
active.  If it does call this function, the effect of this will be to
synchronise the PM domain with the runtime PM state.

> Our intention for the pm_runtime_set_active() etc. calls was that they didn't
> trigger any callbacks, since were are supposed to be executed with runtime
> PM disabled.
> 
> Moreover ->
> 
> > triggered whenever a successful call to __pm_runtime_set_status().
> > PM domain code hooks into this, and updates the PM domain appropriately.
> > 
> > This means a driver with the following sequence:
> > 
> > 	pm_runtime_set_active(dev);
> > 	pm_runtime_enable(dev);
> > 
> > will trigger the PM domain to be powered up at this point, which keeps
> > runtime PM and PM domains properly in sync with each other.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/base/power/domain.c  | 16 +++++++++++++++-
> >  drivers/base/power/runtime.c |  5 +++++
> >  include/linux/pm.h           |  1 +
> >  3 files changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 11a1023fa64a..2a700cea41fc 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -741,6 +741,20 @@ static int pm_genpd_runtime_resume(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static int pm_genpd_runtime_set_status(struct device *dev)
> > +{
> > +	int ret;
> > +
> > +	dev_dbg(dev, "%s()\n", __func__);
> > +
> > +	if (pm_runtime_suspended(dev))
> > +		ret = pm_genpd_runtime_suspend(dev);
> > +	else
> > +		ret = pm_genpd_runtime_resume(dev);
> > +
> > +	return ret;
> > +}
> > +
> >  static bool pd_ignore_unused;
> >  static int __init pd_ignore_unused_setup(char *__unused)
> >  {
> > @@ -1907,6 +1921,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
> >  	genpd->max_off_time_changed = true;
> >  	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
> >  	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
> > +	genpd->domain.ops.runtime_set_status = pm_genpd_runtime_set_status;
> >  	genpd->domain.ops.prepare = pm_genpd_prepare;
> >  	genpd->domain.ops.suspend = pm_genpd_suspend;
> >  	genpd->domain.ops.suspend_late = pm_genpd_suspend_late;
> > @@ -2223,7 +2238,6 @@ int genpd_dev_pm_attach(struct device *dev)
> >  	}
> >  
> >  	dev->pm_domain->detach = genpd_dev_pm_detach;
> > -	pm_genpd_poweron(pd);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 5070c4fe8542..a958cae67a37 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -981,6 +981,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
> >  	struct device *parent = dev->parent;
> >  	unsigned long flags;
> >  	bool notify_parent = false;
> > +	pm_callback_t callback;
> >  	int error = 0;
> >  
> >  	if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> > @@ -1029,6 +1030,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
> >   out_set:
> >  	__update_runtime_status(dev, status);
> >  	dev->power.runtime_error = 0;
> > +	if (dev->power.no_callbacks)
> > +		goto out;
> > +	callback = RPM_GET_CALLBACK(dev, runtime_set_status);
> > +	rpm_callback(callback, dev);
> 
> -> That is specific to PM domains and arguably not needed otherwise,
> so I would define it in struct dev_pm_domain outside of dev_pm_ops.

How does runtime PM know that we're using PM domains though?  How
does runtime PM know that it can cast the dev_pm_ops pointer safely?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
