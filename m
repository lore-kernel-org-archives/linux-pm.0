From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/8] Driver core: wakeup the parent device before
 trying probe
Date: Wed, 10 Jun 2015 12:43:15 +0300
Message-ID: <1433929395.26331.116.camel@linux.intel.com>
References: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1433170082-117462-4-git-send-email-andriy.shevchenko@linux.intel.com>
	 <6646339.jahMH2QKDR@vostro.rjw.lan> <3252449.XN2pzxrAPQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35826 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbbFJJnV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Jun 2015 05:43:21 -0400
In-Reply-To: <3252449.XN2pzxrAPQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>

On Wed, 2015-06-10 at 02:08 +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 09, 2015 01:42:00 AM Rafael J. Wysocki wrote:
> > On Monday, June 01, 2015 05:47:57 PM Andy Shevchenko wrote:
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > If the parent is still suspended when driver probe is
> > > attempted, the result may be failure.
> > > 
> > > For example, if the parent is a PCI MFD device that has been
> > > suspended when we try to probe our device, any register
> > > reads will return 0xffffffff.
> > > 
> > > To fix the problem, making sure the parent is always awake
> > > before attempting driver probe.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/base/dd.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index e843fdb..cfbeff3 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -399,6 +399,8 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe);
> > >   *
> > >   * This function must be called with @dev lock held.  When called for a
> > >   * USB interface, @dev->parent lock must be held as well.
> > > + *
> > > + * If device has a parent it will be powered on during device's probe().
> > >   */
> > >  int driver_probe_device(struct device_driver *drv, struct device *dev)
> > >  {
> > > @@ -410,10 +412,16 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
> > >  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
> > >  		 drv->bus->name, __func__, dev_name(dev), drv->name);
> > >  
> > > +	if (dev->parent)
> > > +		pm_runtime_get_sync(dev->parent);
> > > +
> > 
> > For some bus types that will resume and suspend the parent for many times in
> > a row in device_attach() until an appropriate driver is found.  Would it be
> > more efficient to call it once before the bus_for_each_drv() loop in there?
> 
> Actually, something like the below should work too (the bumping up of the
> parent's usage counter before the loop will keep it in the runtime-active
> state throughout the loop).
> 

Thanks for the patch! We are going to test this soon.

By the way, can you give your Ack for patches 1 and 2 if there is no
objection?


> ---
>  drivers/base/dd.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> Index: linux-pm/drivers/base/dd.c
> ===================================================================
> --- linux-pm.orig/drivers/base/dd.c
> +++ linux-pm/drivers/base/dd.c
> @@ -399,6 +399,8 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe)
>   *
>   * This function must be called with @dev lock held.  When called for a
>   * USB interface, @dev->parent lock must be held as well.
> + *
> + * If the device has a parent, runtime-resume the parent before driver probing.
>   */
>  int driver_probe_device(struct device_driver *drv, struct device *dev)
>  {
> @@ -410,10 +412,16 @@ int driver_probe_device(struct device_dr
>  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>  		 drv->bus->name, __func__, dev_name(dev), drv->name);
>  
> +	if (dev->parent)
> +		pm_runtime_get_sync(dev->parent);
> +
>  	pm_runtime_barrier(dev);
>  	ret = really_probe(dev, drv);
>  	pm_request_idle(dev);
>  
> +	if (dev->parent)
> +		pm_runtime_put(dev->parent);
> +
>  	return ret;
>  }
>  
> @@ -459,8 +467,14 @@ int device_attach(struct device *dev)
>  			ret = 0;
>  		}
>  	} else {
> +		if (dev->parent)
> +			pm_runtime_get_sync(dev->parent);
> +
>  		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
>  		pm_request_idle(dev);
> +
> +		if (dev->parent)
> +			pm_runtime_put(dev->parent);
>  	}
>  out_unlock:
>  	device_unlock(dev);
> 


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

