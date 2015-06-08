From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 3/8] Driver core: wakeup the parent device before trying probe
Date: Tue, 09 Jun 2015 01:42 +0200
Message-ID: <6646339.jahMH2QKDR@vostro.rjw.lan>
References: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com> <1433170082-117462-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65521 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753206AbbFHXQO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 19:16:14 -0400
In-Reply-To: <1433170082-117462-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>

On Monday, June 01, 2015 05:47:57 PM Andy Shevchenko wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> If the parent is still suspended when driver probe is
> attempted, the result may be failure.
> 
> For example, if the parent is a PCI MFD device that has been
> suspended when we try to probe our device, any register
> reads will return 0xffffffff.
> 
> To fix the problem, making sure the parent is always awake
> before attempting driver probe.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/dd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e843fdb..cfbeff3 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -399,6 +399,8 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe);
>   *
>   * This function must be called with @dev lock held.  When called for a
>   * USB interface, @dev->parent lock must be held as well.
> + *
> + * If device has a parent it will be powered on during device's probe().
>   */
>  int driver_probe_device(struct device_driver *drv, struct device *dev)
>  {
> @@ -410,10 +412,16 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>  		 drv->bus->name, __func__, dev_name(dev), drv->name);
>  
> +	if (dev->parent)
> +		pm_runtime_get_sync(dev->parent);
> +

For some bus types that will resume and suspend the parent for many times in
a row in device_attach() until an appropriate driver is found.  Would it be
more efficient to call it once before the bus_for_each_drv() loop in there?

>  	pm_runtime_barrier(dev);
>  	ret = really_probe(dev, drv);
>  	pm_request_idle(dev);
>  
> +	if (dev->parent)
> +		pm_runtime_put_sync(dev->parent);

Is there anything particularly wrong with calling pm_runtime_put() here
instead?

> +
>  	return ret;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
