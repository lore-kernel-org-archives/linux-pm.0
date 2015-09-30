From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 1/2] PM / sleep: Go direct_complete if driver has no callbacks
Date: Wed, 30 Sep 2015 13:33:29 +0200
Message-ID: <CAPDyKFoSWLEzeLUWC0gPY2_a0Mvo3vbbWm5e0f-_rjZbwdY0Sw@mail.gmail.com>
References: <1443607098-26666-1-git-send-email-tomeu.vizoso@collabora.com>
	<1443607098-26666-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36219 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbbI3Ldb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2015 07:33:31 -0400
Received: by wicgb1 with SMTP id gb1so190646520wic.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 04:33:29 -0700 (PDT)
In-Reply-To: <1443607098-26666-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

On 30 September 2015 at 11:58, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> If a suitable prepare callback cannot be found for a given device and
> its driver has no PM callbacks at all, assume that it can go direct to
> complete when the system goes to sleep.
>
> The reason for this is that there's lots of devices in a system that do
> no PM at all and there's no reason for them to prevent their ancestors
> to do direct_complete if they can support it.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Changes in v7:
> - Reduce indentation by adding a label in device_prepare()
>
> Changes in v6:
> - Add stub for !CONFIG_PM.
> - Move implementation of device_check_pm_callbacks to power/main.c as it
>   doesn't belong to CONFIG_PM_SLEEP.
> - Take dev->power.lock before modifying flag.
>
> Changes in v5:
> - Check for all dev_pm_ops instances associated to a device, updating a
>   no_pm_callbacks flag at the times when that could change.
>
>  drivers/base/dd.c           |  3 +++
>  drivers/base/power/common.c | 27 +++++++++++++++++++++++++++
>  drivers/base/power/domain.c |  5 +++++
>  drivers/base/power/main.c   |  8 ++++++++
>  drivers/base/power/power.h  |  6 ++++++
>  include/linux/pm.h          |  1 +
>  6 files changed, 50 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index be0eb4639128..fe0e9cb684b8 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -205,6 +205,8 @@ static void driver_bound(struct device *dev)
>
>         klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
>
> +       device_check_pm_callbacks(dev);
> +
>         /*
>          * Make sure the device is no longer in one of the deferred lists and
>          * kick off retrying all pending devices
> @@ -695,6 +697,7 @@ static void __device_release_driver(struct device *dev)
>                         dev->pm_domain->dismiss(dev);
>
>                 klist_remove(&dev->p->knode_driver);
> +               device_check_pm_callbacks(dev);
>                 if (dev->bus)
>                         blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>                                                      BUS_NOTIFY_UNBOUND_DRIVER,
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index f32b802b98f4..1bba85f8bf8a 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -128,3 +128,30 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
>                 dev->pm_domain->detach(dev, power_off);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
> +
> +static bool pm_ops_is_empty(const struct dev_pm_ops *ops)
> +{
> +       if (!ops)
> +               return true;
> +
> +       return !ops->prepare &&
> +              !ops->suspend &&
> +              !ops->suspend_late &&
> +              !ops->suspend_noirq &&
> +              !ops->resume_noirq &&
> +              !ops->resume_early &&
> +              !ops->resume &&
> +              !ops->complete;
> +}
> +
> +void device_check_pm_callbacks(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +       dev->power.no_pm_callbacks =
> +               (!dev->bus || pm_ops_is_empty(dev->bus->pm)) &&
> +               (!dev->class || pm_ops_is_empty(dev->class->pm)) &&
> +               (!dev->type || pm_ops_is_empty(dev->type->pm)) &&
> +               (!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
> +               (!dev->driver || pm_ops_is_empty(dev->driver->pm));
> +       spin_unlock_irq(&dev->power.lock);
> +}
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 16550c63d611..3cae1aa1885b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -20,6 +20,8 @@
>  #include <linux/suspend.h>
>  #include <linux/export.h>
>
> +#include "power.h"
> +
>  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
> @@ -1305,6 +1307,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>
>         list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
>
> +       device_check_pm_callbacks(dev);

Don't do this while the genpd mutex is held as there is no need to.
Please move it outside the lock and only do it for non-error case.

>   out:
>         mutex_unlock(&genpd->lock);
>
> @@ -1369,6 +1372,8 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>
>         genpd_free_dev_data(dev, gpd_data);
>
> +       device_check_pm_callbacks(dev);
> +
>         return 0;

I can't tell whether this is an interesting feature to use for devices
that gets attached to the ACPI PM domain. Although, you currently
doesn't deal with that case, and too me I think this looks a bit
weird/unsymmetrical.

>
>   out:
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 1710c26ba097..5af45d20b677 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -131,6 +131,8 @@ void device_pm_add(struct device *dev)
>                         dev_name(dev->parent));
>         list_add_tail(&dev->power.entry, &dpm_list);
>         mutex_unlock(&dpm_list_mtx);
> +
> +       device_check_pm_callbacks(dev);
>  }
>
>  /**
> @@ -1569,6 +1571,11 @@ static int device_prepare(struct device *dev, pm_message_t state)
>
>         dev->power.wakeup_path = device_may_wakeup(dev);
>
> +       if (dev->power.no_pm_callbacks) {
> +               ret = 1;        /* Let device go direct_complete */
> +               goto unlock;
> +       }
> +
>         if (dev->pm_domain) {
>                 info = "preparing power domain ";
>                 callback = dev->pm_domain->ops.prepare;
> @@ -1591,6 +1598,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>         if (callback)
>                 ret = callback(dev);
>
> +unlock:
>         device_unlock(dev);
>
>         if (ret < 0) {
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 998fa6b23084..f665a7850016 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -29,6 +29,8 @@ struct wake_irq {
>  extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
>  extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
>
> +extern void device_check_pm_callbacks(struct device *dev);
> +
>  #ifdef CONFIG_PM_SLEEP
>
>  extern int device_wakeup_attach_irq(struct device *dev,
> @@ -102,6 +104,10 @@ static inline void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
>  {
>  }
>
> +static inline void device_check_pm_callbacks(struct device *dev)
> +{
> +}
> +
>  #endif
>
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 35d599e7250d..e334b9b8cd46 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -566,6 +566,7 @@ struct dev_pm_info {
>         bool                    ignore_children:1;
>         bool                    early_init:1;   /* Owned by the PM core */
>         bool                    direct_complete:1;      /* Owned by the PM core */
> +       bool                    no_pm_callbacks:1;      /* Owned by the PM core */

This flag is only being used while CONFIG_PM is set. I suggest we move
within that ifdef.

>         spinlock_t              lock;
>  #ifdef CONFIG_PM_SLEEP
>         struct list_head        entry;
> --
> 2.4.3
>

Kind regards
Uffe
