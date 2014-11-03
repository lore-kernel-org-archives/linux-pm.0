From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: pm_runtime_enable() in ->probe()
Date: Tue, 04 Nov 2014 00:55:22 +0100
Message-ID: <2698247.SaeVHk4A16@vostro.rjw.lan>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org> <3099111.MYm8ByzLAF@vostro.rjw.lan> <7hwq7ci5hu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <7hwq7ci5hu.fsf@deeprootsystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aa
List-Id: linux-pm@vger.kernel.org

On Monday, November 03, 2014 09:00:29 AM Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Saturday, November 01, 2014 02:08:57 AM Rafael J. Wysocki wrote:
> >> On Saturday, November 01, 2014 01:20:38 AM Rafael J. Wysocki wrote:
> >> > On Friday, October 31, 2014 10:16:14 AM Ulf Hansson wrote:
> >> > > On 24 October 2014 18:12, Kevin Hilman <khilman@kernel.org> wrote:
> >> 
> >> [cut]
> >> 
> >> > > 
> >> > > 1)
> >> > > It's bad practice to use pm_runtime_get_sync() in the ->probe() path,
> >> > 
> >> > Honestly, I'm no longer amused.
> >> > 
> >> > > to bring your resources to full power. The consequence would be a
> >> > > driver that requires CONFIG_PM_RUNTIME to be even functional, which
> >> > > just isn't acceptable.
> >> > 
> >> > Sorry, but this is utter nonsense.
> >> > 
> >> > CONFIG_PM_RUNTIME unset means "no runtime PM at all", so all drivers can expect
> >> > everything they need to be always on.  If that is not the case, then someone is
> >> > doing runtime PM behind the scenes and therefore cheating.  Or in different
> >> > words, for CONFIG_PM_RUNTIME unset bus types, platforms etc must ensure that
> >> > everything is on from the drivers' perspective.
> >> > 
> >> > If that is the case, then calling pm_runtime_get_sync() from ->probe
> >> > for CONFIG_PM_RUNTIME unset simply doesn't matter.
> >> > 
> >> > Now, for CONFIG_PM_RUNTIME enabled, if power domains are in use, doing
> >> > pm_runtime_get_sync() from ->probe is the only way the driver can ensure
> >> > in a non-racy way that the device will be accessible going forward.
> >> > 
> >> > Why?  Simply because the probing need not happen during system initialization.
> >> > It very well may take places when the other devices in the same domain have
> >> > beein in use for quite a while and have been using runtime PM (in which
> >> > case the domain may go off at any time unless it is explicityly prevented from
> >> > doing that).
> >> > 
> >> > One thing that you may be missing is that, for CONFIG_PM_RUNTIME set,
> >> > runtime PM has to be either enabled or disabled for all devices in one
> >> > domain (and if it is disabled, then the domain needs to be always on for
> >> > all practical purposes).  Otherwise you can't just make all of them happy
> >> > at the same time.  The documentation doesn't cover this, because it had been
> >> > written before we even started to consider power domains.
> >> > 
> >> > > Drivers that behaves well within this context, follows the runtime PM
> >> > > documentation/recommendation.
> >> > 
> >> > So please go to Documentation/power/runtime_pm.txt and read it again.  Quote:
> >> > 
> >> > "If the default initial runtime PM status of the device (i.e. 'suspended')
> >> > reflects the actual state of the device, its bus type's or its driver's
> >> > ->probe() callback will likely need to wake it up using one of the PM core's
> >> > helper functions described in Section 4.  In that case, pm_runtime_resume()
> >> > should be used.  Of course, for this purpose the device's runtime PM has to be
> >> > enabled earlier by calling pm_runtime_enable()."
> >> 
> >> All that said there is a logical error related to calling pm_runtime_enable()
> >> and its derivatives from ->probe() that I've been overlooking pretty much
> >> from the start.
> >> 
> >> Namely, really_probe() sets dev->driver to drv before calling ->probe()
> >> for either the bus type or the driver itself, so if the driver's probe
> >> calls pm_runtime_enable(), it will execute the driver's own runtime PM
> >> resume callback before the driver can check whether or not it wants to handle
> >> the device in the first place.  That doesn't sound quite right to me.
> >> 
> >> This means we need a different mechanism to ensure that the device will
> >> be accessible to the driver and/or the bus type in ->probe().
> >> 
> >> At one point we had pm_runtime_get_sync() before really_probe() in
> >> driver_proble_device() IIRC, but people complained about it, so we dropped it
> >> and put a barrier in there instead, but that's not sufficient.
> >
> > So we actually had pm_runtime_get_noresume() before the barrier, but then
> > we dropped it due to complaints.
> >
> >> We need to explicitly ensure that the device won't be powered off while
> >> ->probe() is in progress *but* we need to avoid calling the driver's runtime
> >> PM resume callback before ->probe() returns.
> >
> > I wonder, then, if we just need to do pm_runtime_get_sync() instead of the
> > barrier and then pm_runtime_put() instead of pm_request_idle() in
> > driver_probe_device()?
> 
> Won't we still have the same problems in the case of ->probe failure
> that were fixed by removing those calls[1]?

Well, it looks like that might not be the best way to fix the problem.

First of all, I think that drivers can reasonably expect devices to be
accessible when ->probe() runs.  This means that the core and possibly
bus type/PM domain need to make that happen.

For this purpose it may be necessary to power up the device, but doing
that from the bus type's ->probe() requires either (a) not using runtime PM
or (b) bypassing the driver callbacks somehow.  On the other hand, arguably,
if either the bus type or a PM domain provide meaningful runtime suspend/resume
callbacks, then they should be available when driver_probe_device() runs
and it should be fine to run pm_runtime_resume() at that point to trigger
the power-up at least.

Now, pm_runtime_resume() would have been sufficient to power up the device
in driver_probe_device() if it hadn't trigger the "idle" check on return.
So, if you have concerns regarding the reference counting, we could do
something like

	/* Grab a referece on dev to prevent runtime idle from being triggered by resume. */
	pm_runtime_get_sync(dev);
	/* Drop the reference befor probing to make the driver's life easier. */
	pm_runtime_put_noidle(dev);
	ret = really_probe(dev, drv);
	pm_request_idle(dev);

in there.  But quite frankly, I don't see the point, because

	pm_runtime_get_sync(dev);
	ret = really_probe(dev, drv);
	pm_runtime_put(dev);

will suspend the device properly anyway after dropping the reference.

> IOW, after the driver's ->probe returns failure, it's no longer safe to
> call the driver's runtime PM callbacks, since they may be accessing
> resources that no longer exits.

Which we don't do anyway, because if ->probe() fails, dev->driver is cleared
by really_probe().

> Hmm, thinking a little more, maybe this kind of failure is a good time
> for the driver to use pm_runtime_force_suspend(), then later when the PM
> core does the _put(), it will see the device aleady suspended and there
> shouldn't be any problems.

Well, I rather think that ->probe() should leave the device in a state
which is as close as reasonably possible to the state it was in before.

Rafael
