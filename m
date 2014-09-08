From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 3/9] PM / Domains: Add APIs to attach/detach a PM domain for a device
Date: Tue, 09 Sep 2014 00:11:53 +0200
Message-ID: <2898464.MGK3rBhRTU@vostro.rjw.lan>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org> <1409838756-31963-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1409838756-31963-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 04, 2014 03:52:30 PM Ulf Hansson wrote:
> To maintain scalability let's add common methods to attach and detach
> a PM domain for a device, dev_pm_domain_attach|detach().
> 
> Typically dev_pm_domain_attach() shall be invoked from subsystem level
> code at the probe phase to try to attach a device to its PM domain.
> The reversed actions may be done a the remove phase and then by invoking
> dev_pm_domain_detach().
> 
> The supported PM domains at this point are the ACPI and the generic
> PM domains.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/base/power/common.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm.h          | 14 ++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index df2e5ee..9a86b16 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -11,6 +11,8 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/pm_clock.h>
> +#include <linux/acpi.h>
> +#include <linux/pm_domain.h>
>  
>  /**
>   * dev_pm_get_subsys_data - Create or refcount power.subsys_data for device.
> @@ -82,3 +84,57 @@ int dev_pm_put_subsys_data(struct device *dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
> +
> +/**
> + * dev_pm_domain_attach - Attach a device to its PM domain.
> + * @dev: Device to attach.
> + * @power_on: Used to indicate whether we should power on the device.
> + *
> + * The @dev may only be attached to a single PM domain. By iterating through
> + * the available alternatives we try to find a valid PM domain for the device.
> + *
> + * This function should typically be invoked from subsystem level code during
> + * the probe phase. Especially for those that holds devices which requires
> + * power management through PM domains.
> + *
> + * Callers must ensure proper synchronization of this function with power
> + * management callbacks.
> + *
> + * Returns 0 on successfully attached PM domain or negative error code.
> + */
> +int dev_pm_domain_attach(struct device *dev, bool power_on)
> +{
> +	int ret;
> +
> +	ret = acpi_dev_pm_attach(dev, power_on);
> +	if (!ret || ret == -EPROBE_DEFER)

acpi_dev_pm_attach() doesn't return EPROBE_DEFER and there are no plans for it
to do that.  IIRC, I pointed that out to you in the previous round (or even
earlier).  Please remove this check, it is pointless.

> +		return ret;
> +
> +	return genpd_dev_pm_attach(dev);

And why don't you write this as

	ret = acpi_dev_pm_attach(dev, power_on);
	if (ret)
		ret = genpd_dev_pm_attach(dev);

	return ret;

> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
> +
> +/**
> + * dev_pm_domain_detach - Detach a device from its PM domain.
> + * @dev: Device to attach.
> + * @power_off: Used to indicate whether we should power off the device.
> + *
> + * The @dev may be attached to a PM domain. By iterating through the available
> + * alternatives we detach it from its PM domain.
> + *
> + * This functions will reverse the actions from dev_pm_domain_attach() and thus
> + * detach the @dev from its PM domain. Typically it should be invoked from
> + * subsystem level code during the remove phase.
> + *
> + * Callers must ensure proper synchronization of this function with power
> + * management callbacks.
> + *
> + * Returns 0 on successfully detached PM domain or negative error code.
> + */
> +int dev_pm_domain_detach(struct device *dev, bool power_off)
> +{
> +	if (acpi_dev_pm_detach(dev, power_off))
> +		return genpd_dev_pm_detach(dev);

And analogously here?  Or the other way around?  Just please make them both
look analogously.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 72c0fe0..8176b07 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -621,6 +621,20 @@ struct dev_pm_domain {
>  	struct dev_pm_ops	ops;
>  };
>  
> +#ifdef CONFIG_PM
> +extern int dev_pm_domain_attach(struct device *dev, bool power_on);
> +extern int dev_pm_domain_detach(struct device *dev, bool power_off);
> +#else
> +static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
> +{
> +	return -ENODEV;
> +}
> +static inline int dev_pm_domain_detach(struct device *dev, bool power_off)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  /*
>   * The PM_EVENT_ messages are also used by drivers implementing the legacy
>   * suspend framework, based on the ->suspend() and ->resume() callbacks common
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
