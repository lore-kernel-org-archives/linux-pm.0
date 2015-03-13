From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains
 after probe
Date: Fri, 13 Mar 2015 10:30:59 +0100
Message-ID: <CAPDyKFrcjfLXCjLL8SGJUDz6ErROW=B8oDEg0eRPA92=m-dRQA@mail.gmail.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YW7sv-0003mA-JP@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:44937 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbCMJbA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 05:31:00 -0400
Received: by qgfl89 with SMTP id l89so24425707qgf.11
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 02:30:59 -0700 (PDT)
In-Reply-To: <E1YW7sv-0003mA-JP@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> Synchronise the PM domain status with runtime PM's status after a
> platform device has been probed.  This augments the solution in commit
> 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach
> completes").
>
> The above commit added a call to power up the PM domain when a device
> attaches to the domain in order to match the behaviour required by
> drivers that make no use of runtime PM.  The assumption is that the
> device driver will cause a runtime PM transition, which will synchronise
> the PM domain state with the runtime PM state.
>
> However, by default, runtime PM will assume that the device is initially
> suspended, and some drivers may make use of this should they not need to
> touch the hardware during probe.
>
> In order to allow such drivers, trigger the PM domain code to check
> whether the PM domain can be suspended after the probe function, undoing
> the effect of the power-on prior to the probe.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/platform.c     |  2 ++

Don't we need this for more buses than the platform bus?

>  drivers/base/power/common.c | 15 +++++++++++++++
>  drivers/base/power/domain.c | 23 +++++++++++++++++++++++
>  include/linux/pm.h          |  1 +
>  include/linux/pm_domain.h   |  4 ++++
>  5 files changed, 45 insertions(+)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 9421fed40905..552d1affc060 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -512,6 +512,8 @@ static int platform_drv_probe(struct device *_dev)
>                 ret = drv->probe(dev);
>                 if (ret)
>                         dev_pm_domain_detach(_dev, true);
> +               else
> +                       dev_pm_domain_sync(_dev);
>         }
>
>         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index b0f138806bbc..8c739a14d3c7 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -134,3 +134,18 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
>                 dev->pm_domain->detach(dev, power_off);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
> +
> +/**
> + * dev_pm_domain_sync - synchronise the PM domain state with its devices
> + * @dev: device corresponding with domain
> + *
> + * Synchronise the PM domain state with the recently probed device, which
> + * may be in a variety of PM states.  This ensures that a device which
> + * enables runtime PM in suspended state, and never transitions to active
> + * in its probe handler is properly suspended after the probe.
> + */
> +void dev_pm_domain_sync(struct device *dev)
> +{
> +       if (dev->pm_domain && dev->pm_domain->sync)
> +               dev->pm_domain->sync(dev);
> +}

This is more of a taste and flavour comment, regarding the design approach.

To address the issue which @subject patch does, and together with the
original problem, which was about making sure a PM domain stays
powered during probe, that to me seems like a perfect match for a
get/put API.

The current solution from commit 2ed127697eb1 ("PM / Domains: Power on
the PM domain right after attach completes"), is to me just a hacky
workaround (which obviously wasn't the proper solution) . $subject
patch follows that approach.

What do you think of using a get/put approach instead, that would also
give us nice symmetry of the API. As you know I have patches available
for this, I am happy to post them if needed.

> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 11a1023fa64a..13ae3355dff7 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2157,6 +2157,28 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>         genpd_queue_power_off_work(pd);
>  }
>
> +static void genpd_dev_pm_sync(struct device *dev)
> +{
> +       struct generic_pm_domain *pd = NULL, *gpd;
> +
> +       if (!dev->pm_domain)
> +               return;
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +               if (&gpd->domain == dev->pm_domain) {
> +                       pd = gpd;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);

Walking through the gpd list seems a bit "heavy". Can't we just expect
the caller to have a valid generic_pm_domain pointer for its device?

> +
> +       if (!pd)
> +               return;
> +
> +       genpd_queue_power_off_work(pd);
> +}
> +
>  /**
>   * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
>   * @dev: Device to attach.
> @@ -2223,6 +2245,7 @@ int genpd_dev_pm_attach(struct device *dev)
>         }
>
>         dev->pm_domain->detach = genpd_dev_pm_detach;
> +       dev->pm_domain->sync = genpd_dev_pm_sync;
>         pm_genpd_poweron(pd);
>
>         return 0;
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8b5976364619..676ca4055239 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -607,6 +607,7 @@ extern int dev_pm_put_subsys_data(struct device *dev);
>  struct dev_pm_domain {
>         struct dev_pm_ops       ops;
>         void (*detach)(struct device *dev, bool power_off);
> +       void (*sync)(struct device *dev);
>  };
>
>  /*
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a9edab2c787a..8d58b30e23ac 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -319,12 +319,16 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
>  #ifdef CONFIG_PM
>  extern int dev_pm_domain_attach(struct device *dev, bool power_on);
>  extern void dev_pm_domain_detach(struct device *dev, bool power_off);
> +void dev_pm_domain_sync(struct device *dev);
>  #else
>  static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
>  {
>         return -ENODEV;
>  }
>  static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
> +static inline void dev_pm_domain_sync(struct device *dev)
> +{
> +}
>  #endif
>
>  #endif /* _LINUX_PM_DOMAIN_H */
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
