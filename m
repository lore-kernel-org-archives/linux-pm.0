From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 14:02:38 -0800
Message-ID: <20141117220238.GE5258@dtor-ws>
References: <20141117211117.GD5258@dtor-ws>
 <Pine.LNX.4.44L0.1411171641170.855-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411171641170.855-100000@iolanthe.rowland.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 17, 2014 at 04:44:56PM -0500, Alan Stern wrote:
> On Mon, 17 Nov 2014, Dmitry Torokhov wrote:
> 
> > > When the runtime PM core invokes a power domain's callback routine,
> > > what does the domain's routine usually do?  Does it go ahead and invoke
> > > the driver's callback?  Or does it try to invoke the subsystem's
> > > callback?
> > > 
> > > Obviously this depends on how the power domain code is written.  But
> > > suppose every power domain would always use the same strategy as the PM
> > > core: Invoke the subsystem's callback if there is one; otherwise invoke
> > > the driver's callback.
> > > 
> > > Then there wouldn't be a problem.  Even when a runtime-resume went via
> > > the power domain, the subsystem would still be able to protect the
> > > not-yet-bound driver from being called.
> > > 
> > > (... Unless the subsystem itself was incapable of doing this the right 
> > > way.  But subsystems can be fixed.)
> > 
> > The genpd code currently starts by powering on the domain (if it is not
> > on already) and then does "device restore" which is:
> > 
> > /**
> >  * pm_genpd_default_restore_state - Default PM domians "restore device state".
> >  * @dev: Device to handle.
> >  */
> > static int pm_genpd_default_restore_state(struct device *dev)
> > {
> > 	int (*cb)(struct device *__dev);
> > 
> > 	cb = dev_gpd_data(dev)->ops.restore_state;
> > 	if (cb)
> > 		return cb(dev);
> > 
> > 	if (dev->type && dev->type->pm)
> > 		cb = dev->type->pm->runtime_resume;
> > 	else if (dev->class && dev->class->pm)
> > 		cb = dev->class->pm->runtime_resume;
> > 	else if (dev->bus && dev->bus->pm)
> > 		cb = dev->bus->pm->runtime_resume;
> > 	else
> > 		cb = NULL;
> > 
> > 	if (!cb && dev->driver && dev->driver->pm)
> > 		cb = dev->driver->pm->runtime_resume;
> > 
> > 	return cb ? cb(dev) : 0;
> > }
> > 
> > So I guess bus (or class or type) can take care of it.
> 
> The bus could.  I don't think the class or type knows when a driver is 
> being probed.
> 
> >  Except buses
> > usually call pm_generic_runtime_resume() which ends up fetching driver's
> > callbacks. Maybe pm_generic_runtime_*() need be a bit smarter?
> 
> No, the bus subsystem needs to be smarter.  It shouldn't call 
> pm_generic_runtime_resume() if the driver hasn't been probed yet, or if 
> the driver has already been unbound from the device.

But that code wold be exactly the same for all buses, right? So why
can't pm_generic_runtime_resume() be smarter?

However, is it allowed to call pm_runtime_get_sync() on devices that
didn't issue pm_runtime_enable()?

Thanks.

-- 
Dmitry
