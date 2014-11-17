From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 13:11:17 -0800
Message-ID: <20141117211117.GD5258@dtor-ws>
References: <20141117202855.GB5258@dtor-ws>
 <Pine.LNX.4.44L0.1411171542001.1747-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411171542001.1747-100000@iolanthe.rowland.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 17, 2014 at 03:49:14PM -0500, Alan Stern wrote:
> On Mon, 17 Nov 2014, Dmitry Torokhov wrote:
> 
> > On Mon, Nov 17, 2014 at 02:54:53PM -0500, Alan Stern wrote:
> > > On Mon, 17 Nov 2014, Dmitry Torokhov wrote:
> > > 
> > > > > For devices that aren't part of a power domain, things are simpler.
> > > > > The bus does _get_noresume() to make sure the device won't be runtime
> > > > > suspended while the probe routine is running.  It doesn't do
> > > > > _get_sync(), because that would end up calling the driver's
> > > > > runtime_resume routine before the driver was bound to the device.  (The
> > > > > bus could prevent that from happening by taking special precautions,
> > > > > like PCI does, but in general it's a nuisance.)
> > > > 
> > > > That's why I think we need some new call that would mean "make sure the
> > > > device is powered" which would properly handle power domain and bus, but
> > > > ignore all driver stuff since it may not be initialized yet. And similar
> > > > call for asking to put device and maybe domain in powered down state in
> > > > case probing failed.
> > > 
> > > I can't imagine how such a call would work.
> > > 
> > > The PM core invokes the subsystem's runtime_suspend/resume callback, 
> > > and then the subsystem's routine is responsible for invoking the 
> > > driver's callback (or _not_ invoking it, in this case).
> > > 
> > > Thus, the PM core has no way to tell the subsystem's callback not to
> > > invoke the driver's routine, and adding a new runtime PM call wouldn't
> > > change that.  You'd have to add a new pair of callbacks instead, which 
> > > IMO would be a tremendous waste.
> > > 
> > > Furthermore, the subsystem already _knows_ when the driver gets probed, 
> > > because probing works in the same sort of way: The subsystem's probe 
> > > routine gets invoked, and it is responsible for invoking the driver's 
> > > probe routine.  Therefore the PM core doesn't _need_ to provide this 
> > > extra information to the subsystem.  Rather, the subsystem just needs 
> > > to keep track of the information it already has available.
> > 
> > You are missing concept of power domains in this picture. True,
> > subsystem knows when it probes but power domain does not. Subsystem has
> > no knowledge of power domain (devices in the same subsystem can come
> > from different domains).
> 
> Okay, I take your point.
> 
> > We need to have either subsystem or device core to indicate to power
> > management core that we do not need "full" runtime resume, but rather a
> > "partial" one since driver is not ready yet.
> > 
> > We would not need new callbacks here I think, we just need to be able to
> > select appropriate set of callbacks, depending on the binding state.
> 
> When the runtime PM core invokes a power domain's callback routine,
> what does the domain's routine usually do?  Does it go ahead and invoke
> the driver's callback?  Or does it try to invoke the subsystem's
> callback?
> 
> Obviously this depends on how the power domain code is written.  But
> suppose every power domain would always use the same strategy as the PM
> core: Invoke the subsystem's callback if there is one; otherwise invoke
> the driver's callback.
> 
> Then there wouldn't be a problem.  Even when a runtime-resume went via
> the power domain, the subsystem would still be able to protect the
> not-yet-bound driver from being called.
> 
> (... Unless the subsystem itself was incapable of doing this the right 
> way.  But subsystems can be fixed.)

The genpd code currently starts by powering on the domain (if it is not
on already) and then does "device restore" which is:

/**
 * pm_genpd_default_restore_state - Default PM domians "restore device state".
 * @dev: Device to handle.
 */
static int pm_genpd_default_restore_state(struct device *dev)
{
	int (*cb)(struct device *__dev);

	cb = dev_gpd_data(dev)->ops.restore_state;
	if (cb)
		return cb(dev);

	if (dev->type && dev->type->pm)
		cb = dev->type->pm->runtime_resume;
	else if (dev->class && dev->class->pm)
		cb = dev->class->pm->runtime_resume;
	else if (dev->bus && dev->bus->pm)
		cb = dev->bus->pm->runtime_resume;
	else
		cb = NULL;

	if (!cb && dev->driver && dev->driver->pm)
		cb = dev->driver->pm->runtime_resume;

	return cb ? cb(dev) : 0;
}

So I guess bus (or class or type) can take care of it. Except buses
usually call pm_generic_runtime_resume() which ends up fetching driver's
callbacks. Maybe pm_generic_runtime_*() need be a bit smarter?

Thanks.

-- 
Dmitry
