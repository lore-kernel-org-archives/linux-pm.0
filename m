From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Wed, 18 Feb 2015 08:02:30 +0100
Message-ID: <1685853.blxysuNkEh@vostro.rjw.lan>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk> <1582000.j702YZSJy3@vostro.rjw.lan> <20150217194243.GR8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57925 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751002AbbBRGjR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 01:39:17 -0500
In-Reply-To: <20150217194243.GR8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Tuesday, February 17, 2015 07:42:43 PM Russell King - ARM Linux wrote:
> On Tue, Feb 17, 2015 at 07:53:47PM +0100, Rafael J. Wysocki wrote:

[cut]

> > 
> > What really is expected is that the RPM status of the device will agree
> > with its actual state at the moment when pm_runtime_enable() is called.
> > 
> > If the actual state of the device is "not powered", then it is invalid to
> > call pm_runtime_set_active() before pm_runtime_enable() even.
> 
> We're both saying exactly the same thing, so we're in full agreement,
> which is good. :)
> 
> > > However, PM domains are not informed of this, and this is where the problem
> > > really lies.  We need to keep PM domains properly and fully informed of their
> > > associated device status.
> > 
> > This goes backwards.  Rather, PM domains should tell everyone about
> > what they have done to the device IMO.  That is, since PM domains
> > power up the device, it would be logical to change its RPM status at
> > that point to me.
> 
> Right, so it may make sense for runtime PM to query the PM domain state,
> and synchronise itself with that.
> 
> > That may lead to one subtle problem, though.
> > 
> > Suppose that, in addition to either having or not having a power domain
> > under it, the device has a clock that is managed directly by the driver.
> > The driver may then want to do the clock management in its runtime PM
> > callbacks.  However, if genpd changes the device's RPM status to "active",
> > the runtime PM framework will not execute the resume callback for the
> > device, so things will break if the clock is not actually enabled to
> > start with.
> > 
> > IOW, we need a way for the driver and genpd to agree on what the RPM status
> > of the device should be set to before pm_runtime_enable() is executed.
> 
> It's worse than that.  If, in the probe, we decide at a point to query
> the PM domain status, and transfer it into the RPM status, how does the
> driver know whether it needs to do a "put" to cause a transition from
> active to suspended?

When ->probe() runs, the cases are:
(1) There are no power domains, so the device is "active" when the clock is
    enabled and "suspended" when it is disabled.
(2) There is a power domain which is initially off.  The RPM status of the
    device has to be "suspended" or the domain needs to be powered up.
(3) There is a power domain which is initially on.  The RPM status of the
    device depends on the clock state like in (1).  Also it may not be
    possible to power down the domain.

Essentially, (1) and (3) are equivalent from the ->probe() perspective.
Moreover, if the driver does not intend to enable the clock, the device
is "suspended" regardless of the domain state.  This means that the only
really interesting case is (2) and only when ->probe() will attempt to
enable the clock.

In that case it needs to do something like
(a) Bump up the device's runtime PM usage counter.
(b) Execute "power up the device for me" (missing).
(c) Enable the clock, do whatever it wants to the device, set the RPM status
    to "active" and call pm_runtime_enable().
(d) Drop down the device's runtime PM usage counter (the core will trigger
    suspend).

> In the case where the PM domain was suspended, the RPM status would also
> be suspended at that point, and it requires a RPM get to resume it.

Yes, it does, if the driver wants to access the device.

> If the PM domain was active, then it would require a pm_runtime_put()
> operation to allow it to suspend.
>
> This is why I decided that the methodology in the runtime PM code should
> apply to PM domains: runtime PM requires the actual state to match the
> runtime PM state prior to calling pm_runtime_enable().  We should also
> require that the PM domain state must also match the runtime PM state
> prior to runtime PM being enabled too.

Agreed.

> > > We fix this by adding a new callback - runtime_set_status() which is
> > 
> > I'm not sure if that's the way to address that, though.
> 
> I've come to the conclusion that this isn't a good way to handle it,
> because those drivers which may make use of PM domains without using
> runtime PM will be probed with the PM domain powered down.

What would they use PM domains for, then?

PM_RUNTIME is gone now and PM is implied by PM_SLEEP, so you can't have system
suspend support without runtime PM (which presumably might be the case in
question).

> I think we've got a rather sticky problem here, and my proposed
> solution will cause problems in that scenario.
> 
> Another possibility may be to trigger PM domains to try to power down
> the domain when it sees the driver call pm_runtime_enable().  If the
> driver never calls pm_runtime_enable(), the PM domain will be left
> active.  If it does call this function, the effect of this will be to
> synchronise the PM domain with the runtime PM state.

That's more along the lines of what I'm thinking about.  I don't have a clean
idea how to implement that, though.

> > Our intention for the pm_runtime_set_active() etc. calls was that they didn't
> > trigger any callbacks, since were are supposed to be executed with runtime
> > PM disabled.
> > 
> > Moreover ->

[cut]

> > > @@ -1029,6 +1030,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
> > >   out_set:
> > >  	__update_runtime_status(dev, status);
> > >  	dev->power.runtime_error = 0;
> > > +	if (dev->power.no_callbacks)
> > > +		goto out;
> > > +	callback = RPM_GET_CALLBACK(dev, runtime_set_status);
> > > +	rpm_callback(callback, dev);
> > 
> > -> That is specific to PM domains and arguably not needed otherwise,
> > so I would define it in struct dev_pm_domain outside of dev_pm_ops.
> 
> How does runtime PM know that we're using PM domains though?  How
> does runtime PM know that it can cast the dev_pm_ops pointer safely?

dev->pm_domain is set then, so you basically do

	if (dev->pm_domain && dev->pm_domain->runtime_set_status)
		dev->pm_domain->runtime_set_status(dev);

(or whatever the new callback may be).

And if power domains are in use, dev->pm_domain has to be set before doing
anything with runtime PM to the device or things may break in more interesting
ways.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
