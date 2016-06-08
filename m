From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] PM / Runtime: Add notifiers for device runtime PM events
Date: Wed, 8 Jun 2016 19:18:04 +0200
Message-ID: <CAJZ5v0g_7Xsmo0U4YU+V3xjEPfCL7R02VgyB524Mu=dwPwt+Ow@mail.gmail.com>
References: <1465381556-2230-1-git-send-email-m.szyprowski@samsung.com> <1465381556-2230-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32794 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651AbcFHRSI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 13:18:08 -0400
In-Reply-To: <1465381556-2230-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Jun 8, 2016 at 12:25 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Allow drivers registering for certain runtime PM events of other
> devices. Some drivers in power domain are more or less coupled. When one
> driver is suspending (thus leading to power domain being also turned
> off) the other might have to perform some necessary steps. For example
> Exynos IOMMU has to save its context.
>
> Based on previous work of Sylwester Nawrocki <s.nawrocki@samsung.com>.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

No, this is not the right way to address this and using notifiers for
that is just wrong (because of the potential ordering issues).

Also, the problem is not limited to runtime PM, but also to system
suspend/resume and initialization/shutdown.

I posted a series of device dependencies patches a few months ago that
might help to address this problem, but there was almost no interest
in it at that time.

Thanks,
Rafael


> ---
>  drivers/base/power/generic_ops.c |  9 +++++++
>  drivers/base/power/power.h       |  6 +++++
>  drivers/base/power/runtime.c     | 34 +++++++++++++++++++++++++--
>  include/linux/pm.h               |  2 ++
>  include/linux/pm_runtime.h       | 51 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 100 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
> index 07c3c4a9522d..f0838229b781 100644
> --- a/drivers/base/power/generic_ops.c
> +++ b/drivers/base/power/generic_ops.c
> @@ -10,6 +10,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/export.h>
>  #include <linux/suspend.h>
> +#include "power.h"
>
>  #ifdef CONFIG_PM
>  /**
> @@ -25,8 +26,12 @@ int pm_generic_runtime_suspend(struct device *dev)
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>         int ret;
>
> +       pm_runtime_notifier_call(dev, RPM_EVENT_SUSPEND_PRE);
> +
>         ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
>
> +       pm_runtime_notifier_call(dev, RPM_EVENT_SUSPEND_POST);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
> @@ -44,8 +49,12 @@ int pm_generic_runtime_resume(struct device *dev)
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>         int ret;
>
> +       pm_runtime_notifier_call(dev, RPM_EVENT_RESUME_PRE);
> +
>         ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
>
> +       pm_runtime_notifier_call(dev, RPM_EVENT_RESUME_POST);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 50e30e7b059d..30b6319ce96c 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -1,4 +1,5 @@
>  #include <linux/pm_qos.h>
> +#include <linux/pm_runtime.h>
>
>  static inline void device_pm_init_common(struct device *dev)
>  {
> @@ -20,6 +21,7 @@ static inline void pm_runtime_early_init(struct device *dev)
>  extern void pm_runtime_init(struct device *dev);
>  extern void pm_runtime_reinit(struct device *dev);
>  extern void pm_runtime_remove(struct device *dev);
> +extern int pm_runtime_notifier_call(struct device *dev, enum rpm_event event);
>
>  struct wake_irq {
>         struct device *dev;
> @@ -87,6 +89,10 @@ static inline void pm_runtime_early_init(struct device *dev)
>  static inline void pm_runtime_init(struct device *dev) {}
>  static inline void pm_runtime_reinit(struct device *dev) {}
>  static inline void pm_runtime_remove(struct device *dev) {}
> +static inline pm_runtime_notifier_call(struct device *dev, enum rpm_event event)
> +{
> +       return 0;
> +}
>
>  static inline int dpm_sysfs_add(struct device *dev) { return 0; }
>  static inline void dpm_sysfs_remove(struct device *dev) {}
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b74690418504..3a5637ca8400 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -227,6 +227,27 @@ void pm_runtime_set_memalloc_noio(struct device *dev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_set_memalloc_noio);
>
> +int pm_runtime_notifier_call(struct device *dev, enum rpm_event event)
> +{
> +       return atomic_notifier_call_chain(&dev->power.runtime_notifier,
> +                                         event, dev);
> +}
> +
> +int pm_runtime_register_notifier(struct device *dev, struct notifier_block *nb)
> +{
> +       return atomic_notifier_chain_register(&dev->power.runtime_notifier,
> +                                             nb);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_register_notifier);
> +
> +int pm_runtime_unregister_notifier(struct device *dev,
> +                                   struct notifier_block *nb)
> +{
> +       return atomic_notifier_chain_unregister(&dev->power.runtime_notifier,
> +                                               nb);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_unregister_notifier);
> +
>  /**
>   * rpm_check_suspend_allowed - Test whether a device may be suspended.
>   * @dev: Device to test.
> @@ -1174,6 +1195,7 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
>                 goto out;
>         }
>
> +       pm_runtime_notifier_call(dev, RPM_EVENT_DISABLE_PRE);
>         /*
>          * Wake up the device if there's a resume request pending, because that
>          * means there probably is some I/O to process and disabling runtime PM
> @@ -1195,6 +1217,7 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
>         if (!dev->power.disable_depth++)
>                 __pm_runtime_barrier(dev);
>
> +       pm_runtime_notifier_call(dev, RPM_EVENT_DISABLE_POST);
>   out:
>         spin_unlock_irq(&dev->power.lock);
>  }
> @@ -1210,10 +1233,16 @@ void pm_runtime_enable(struct device *dev)
>
>         spin_lock_irqsave(&dev->power.lock, flags);
>
> -       if (dev->power.disable_depth > 0)
> +       if (dev->power.disable_depth > 0) {
> +               if (dev->power.disable_depth == 1)
> +                       pm_runtime_notifier_call(dev, RPM_EVENT_ENABLE_PRE);
>                 dev->power.disable_depth--;
> -       else
> +       } else {
>                 dev_warn(dev, "Unbalanced %s!\n", __func__);
> +       }
> +
> +       if (dev->power.disable_depth == 0)
> +               pm_runtime_notifier_call(dev, RPM_EVENT_ENABLE_POST);
>
>         spin_unlock_irqrestore(&dev->power.lock, flags);
>  }
> @@ -1411,6 +1440,7 @@ void pm_runtime_init(struct device *dev)
>                         (unsigned long)dev);
>
>         init_waitqueue_head(&dev->power.wait_queue);
> +       ATOMIC_INIT_NOTIFIER_HEAD(&dev->power.runtime_notifier);
>  }
>
>  /**
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 06eb353182ab..bdf6eaaf62ec 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -27,6 +27,7 @@
>  #include <linux/wait.h>
>  #include <linux/timer.h>
>  #include <linux/completion.h>
> +#include <linux/notifier.h>
>
>  /*
>   * Callbacks for platform drivers to implement.
> @@ -604,6 +605,7 @@ struct dev_pm_info {
>         unsigned long           active_jiffies;
>         unsigned long           suspended_jiffies;
>         unsigned long           accounting_timestamp;
> +       struct atomic_notifier_head     runtime_notifier;
>  #endif
>         struct pm_subsys_data   *subsys_data;  /* Owned by the subsystem. */
>         void (*set_latency_tolerance)(struct device *, s32);
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 2e14d2667b6c..82d41a6a6f5c 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -23,6 +23,43 @@
>                                             usage_count */
>  #define RPM_AUTO               0x08    /* Use autosuspend_delay */
>
> +/**
> + * Runtime PM notifier events.
> + *
> + * TODO: RPM_EVENT_SUSPEND/RPM_EVENT_RESUME are supported
> + * currently only with generic power domains. They won't be executed
> + * in other cases. Fix this.
> + *
> + * RPM_EVENT_SUSPEND_PRE       Before calling device suspend callback
> + *                             and before turning domain off
> + * RPM_EVENT_SUSPEND_POST      After suspending device and before turning
> + *                             domain off
> + *
> + * RPM_EVENT_RESUME_PRE                Before calling device resume callback
> + *                             but after turning domain on
> + * RPM_EVENT_RESUME_POST       After resuming device
> + *
> + * RPM_EVENT_ENABLE_PRE                Before effectively enabling runtime PM
> + *                             (the pm_runtime_enable() call must undo the
> + *                             last pm_runtime_disable() call)
> + * RPM_EVENT_ENABLE_POST       After effectively enabling runtime PM
> + *
> + * RPM_EVENT_DISABLE_PRE       Before effectively disabling runtime PM
> + *                             (the first pm_runtime_disable() call)
> + * RPM_EVENT_DISABLE_POST      After effectively disabling runtime PM
> + */
> +enum rpm_event {
> +       RPM_EVENT_SUSPEND_PRE,
> +       RPM_EVENT_SUSPEND_POST,
> +       RPM_EVENT_RESUME_PRE,
> +       RPM_EVENT_RESUME_POST,
> +       RPM_EVENT_ENABLE_PRE,
> +       RPM_EVENT_ENABLE_POST,
> +       RPM_EVENT_DISABLE_PRE,
> +       RPM_EVENT_DISABLE_POST,
> +       RPM_EVENT_NUM,
> +};
> +
>  #ifdef CONFIG_PM
>  extern struct workqueue_struct *pm_wq;
>
> @@ -55,6 +92,10 @@ extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
>  extern void pm_runtime_update_max_time_suspended(struct device *dev,
>                                                  s64 delta_ns);
>  extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
> +extern int pm_runtime_register_notifier(struct device *dev,
> +                                       struct notifier_block *nb);
> +extern int pm_runtime_unregister_notifier(struct device *dev,
> +                                          struct notifier_block *nb);
>
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
>  {
> @@ -186,6 +227,16 @@ static inline unsigned long pm_runtime_autosuspend_expiration(
>                                 struct device *dev) { return 0; }
>  static inline void pm_runtime_set_memalloc_noio(struct device *dev,
>                                                 bool enable){}
> +static inline int pm_runtime_register_notifier(struct device *dev,
> +                                       struct notifier_block *nb)
> +{
> +       return -ENOSYS;
> +}
> +static innline int pm_runtime_unregister_notifier(struct device *dev,
> +                                          struct notifier_block *nb)
> +{
> +       return 0;
> +};
>
>  #endif /* !CONFIG_PM */
>
> --
