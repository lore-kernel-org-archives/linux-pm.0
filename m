From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Sat, 8 Jul 2017 13:51:15 +0800
Message-ID: <20170708055115.GA25873@b29397-desktop>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com>
 <2629938.X3D3UTyHBr@aspire.rjw.lan>
 <20170707080107.GC21909@b29397-desktop>
 <2042394.b4eZkzrJ5f@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2042394.b4eZkzrJ5f-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, p.zabel@pe
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 07, 2017 at 03:03:06PM +0200, Rafael J. Wysocki wrote:
> On Friday, July 07, 2017 04:01:07 PM Peter Chen wrote:
> > On Fri, Jul 07, 2017 at 03:13:48AM +0200, Rafael J. Wysocki wrote:
> > > > 
> > > > - Can I write new code for it or I need to depend on something?
> > > 
> > > There is nothing this code needs to depend on AFAICS, but there are existing
> > > solutions in this problem space (ACPI power management, genpd), so it needs to
> > > be careful enough about possible overlaps etc.
> > > 
> > > > I find there is already "power state" concept at documentation.
> > > > Documentation/ABI/testing/sysfs-devices-power_state
> > > 
> > > This is ACPI-specific and only in sysfs directories representing ACPI device
> > > objects (which aren't physical devices).
> > > 
> > > Anyway, since ACPI covers the problem space you are working in already,
> > > your code has to be mutually exclusive with it.
> > > 
> > > > - If I can write the new code for it, except the problems I want
> > > > to fix, are there any other use cases I need to consider?
> > > 
> > > I would start simple and focus on the particular problem at hand, that is
> > > devices with two power states ("on" and "off") where the "on" state
> > > depends on a number of clocks and/or GPIOs.  Still, I'd also avoid making
> > > design choices that might prevent it from being extended in the future
> > > if need be.
> > > 
> > > One major problem I can see is how to "attach" the power states framework
> > > to a particular device (once we have discovered that it should be used with
> > > that device).
> > > 
> > > For bus types that don't do power management of their own you could follow
> > > ACPI (and genpd) and provide a PM domain for this purpose, but bus types
> > > doing their own PM (like USB) will probably need to be treated differently.
> > > In those cases the bus type code will have to know that it should call some
> > > helpers to switch power states of devices.
> > > 
> > 
> > After thinking more, using a power state framework is seems too heavy
> > for this use case. This use case is just do some clock and gpio
> > operations before device is created, and do some put operations
> > after device is deleted. We just need some helpers in one structure
> > (called "power sequence" or "power state") for this purpose.
> > 
> > For the use case, the clock and gpio operation can be done after device
> > is created, the power domain is more suitable.
> 
> There is a problem with PM domains that they only provide hooks for runtime PM
> and system suspend/resume (including hibernation) and not for generic
> "power up" and "power down" operations that may need to be carried out at
> probe time before the runtime PM framework can be used (and analogously
> at remove time).
> 
> I would consider starting with the patch below or similar.
> 
> Then you can define something like POWER_STATE_SEQUENCE type for your
> case and basically use almost what you have already with it, except that
> struct pwrsec_generic will now become struct power_state_sequence and
> struct power_state_info will be embedded in it instead of struct pwrsec.
> 
> The major comceptual difference is that ->power_up and ->power_down are
> now available at the level of the device that needs the power sequence and
> pm_device_power_up/down() can be used wherever necessary (in the code,
> in a bus type, in a controller driver or even in the driver for this particular
> device).

Rafeal, thanks for your patch.

The biggest problem for my use case is the device is still not created.
How can I call pm_device_power_up(dev)?

Peter
> 
> Most likely you will need a PM domain in addition to that, but mostly to avoid
> code duplication.
> 
> And in the future other types of power state definitions may be hooked up
> to that, including ACPI etc.
> 
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/base/power/common.c |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/pm.h          |   33 +++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -550,6 +550,30 @@ struct pm_subsys_data {
>  #endif
>  };
>  
> +enum power_state_type {
> +	POWER_STATE_GENERIC = 0,
> +};
> +
> +/**
> + * struct power_state_info - information related to device power states.
> + *
> + * @type: Power states definition type.
> + * @power_up: Device power up method.
> + * @power_down: Device power down method.
> + *
> + * @power_up is expected to put the device into a power state in which it can
> + * be operated by software (it doesn't have to be the full power state in
> + * principle as long as the device will respond to all software accesses in
> + * this state) and @power_down is expected to put the device into the lowest
> + * power state the device can be put into given all of the applicable
> + * constraints and limitations (it may not mean completely off).
> + */
> +struct power_state_info {
> +	enum power_state_type type;
> +	int (*power_up)(struct device *dev);
> +	int (*power_down)(struct device *dev);
> +};
> +
>  struct dev_pm_info {
>  	pm_message_t		power_state;
>  	unsigned int		can_wakeup:1;
> @@ -600,6 +624,7 @@ struct dev_pm_info {
>  	unsigned long		active_jiffies;
>  	unsigned long		suspended_jiffies;
>  	unsigned long		accounting_timestamp;
> +	struct power_state_info	*state;
>  #endif
>  	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
>  	void (*set_latency_tolerance)(struct device *, s32);
> @@ -610,6 +635,14 @@ extern void update_pm_runtime_accounting
>  extern int dev_pm_get_subsys_data(struct device *dev);
>  extern void dev_pm_put_subsys_data(struct device *dev);
>  
> +#ifdef CONFIG_PM
> +extern int pm_device_power_up(struct device *dev);
> +extern int pm_device_power_down(struct device *dev);
> +#else
> +static inline int pm_device_power_up(struct device *dev) { return 0; }
> +static inline int pm_device_power_down(struct device *dev) { return 0; }
> +#endif /* CONFIG_PM */
> +
>  /**
>   * struct dev_pm_domain - power management domain representation.
>   *
> Index: linux-pm/drivers/base/power/common.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/common.c
> +++ linux-pm/drivers/base/power/common.c
> @@ -152,3 +152,38 @@ void dev_pm_domain_set(struct device *de
>  	device_pm_check_callbacks(dev);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_set);
> +
> +/**
> + * pm_device_power_up - Power up a device using the power states framework.
> + * @dev: Device to power up.
> + *
> + * Put the device into a power state in which it will respond to all software
> + * accesses (that may not mean maximum power) using the callback provided
> + * through the device power state framework, if present.
> + */
> +int pm_device_power_up(struct device *dev)
> +{
> +	if (dev->power.state && dev->power.state->power_up)
> +		return dev->power.state->power_up(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pm_device_power_up);
> +
> +/**
> + * pm_device_power_down - Power down a device using the power states framework.
> + * @dev: Device to power down.
> + *
> + * Put the device into the lowest power state it can be put into given the
> + * applicable constraints and limitations (that may not mean maximum power)
> + * using the callback provided through the device power state framework, if
> + * present.
> + */
> +int pm_device_power_down(struct device *dev)
> +{
> +	if (dev->power.state && dev->power.state->power_down)
> +		return dev->power.state->power_down(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pm_device_power_down);
> 

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
