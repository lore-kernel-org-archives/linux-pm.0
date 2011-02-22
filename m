From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv3] amba: support pm ops
Date: Tue, 22 Feb 2011 21:02:14 +0100
Message-ID: <201102222102.15089.rjw__7153.36243524707$1298407827$gmane$org@sisk.pl>
References: <201102212126.10742.rjw@sisk.pl>
	<1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: linux-pm@lists.linux-foundation.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 22, 2011, Rabin Vincent wrote:
> Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
> The implementation of AMBA bus pm ops is based on the platform bus
> implementation.
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

Looks good.

Who's supposed to take it?

Rafael


> ---
> v3: add a missing header. don't keep an empty dev_pm_ops struct when it's
>     not used.
> 
>  drivers/amba/bus.c       |  340 ++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/amba/bus.h |    2 +
>  2 files changed, 319 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index ca96b0a..7d38981 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -13,12 +13,13 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/amba/bus.h>
>  
>  #include <asm/irq.h>
>  #include <asm/sizes.h>
>  
> -#define to_amba_device(d)	container_of(d, struct amba_device, dev)
>  #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
>  
>  static struct amba_id *
> @@ -57,26 +58,6 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
>  #define amba_uevent NULL
>  #endif
>  
> -static int amba_suspend(struct device *dev, pm_message_t state)
> -{
> -	struct amba_driver *drv = to_amba_driver(dev->driver);
> -	int ret = 0;
> -
> -	if (dev->driver && drv->suspend)
> -		ret = drv->suspend(to_amba_device(dev), state);
> -	return ret;
> -}
> -
> -static int amba_resume(struct device *dev)
> -{
> -	struct amba_driver *drv = to_amba_driver(dev->driver);
> -	int ret = 0;
> -
> -	if (dev->driver && drv->resume)
> -		ret = drv->resume(to_amba_device(dev));
> -	return ret;
> -}
> -
>  #define amba_attr_func(name,fmt,arg...)					\
>  static ssize_t name##_show(struct device *_dev,				\
>  			   struct device_attribute *attr, char *buf)	\
> @@ -102,6 +83,320 @@ static struct device_attribute amba_dev_attrs[] = {
>  	__ATTR_NULL,
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int amba_legacy_suspend(struct device *dev, pm_message_t mesg)
> +{
> +	struct amba_driver *adrv = to_amba_driver(dev->driver);
> +	struct amba_device *adev = to_amba_device(dev);
> +	int ret = 0;
> +
> +	if (dev->driver && adrv->suspend)
> +		ret = adrv->suspend(adev, mesg);
> +
> +	return ret;
> +}
> +
> +static int amba_legacy_resume(struct device *dev)
> +{
> +	struct amba_driver *adrv = to_amba_driver(dev->driver);
> +	struct amba_device *adev = to_amba_device(dev);
> +	int ret = 0;
> +
> +	if (dev->driver && adrv->resume)
> +		ret = adrv->resume(adev);
> +
> +	return ret;
> +}
> +
> +static int amba_pm_prepare(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (drv && drv->pm && drv->pm->prepare)
> +		ret = drv->pm->prepare(dev);
> +
> +	return ret;
> +}
> +
> +static void amba_pm_complete(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +
> +	if (drv && drv->pm && drv->pm->complete)
> +		drv->pm->complete(dev);
> +}
> +
> +#else /* !CONFIG_PM_SLEEP */
> +
> +#define amba_pm_prepare		NULL
> +#define amba_pm_complete		NULL
> +
> +#endif /* !CONFIG_PM_SLEEP */
> +
> +#ifdef CONFIG_SUSPEND
> +
> +static int amba_pm_suspend(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->suspend)
> +			ret = drv->pm->suspend(dev);
> +	} else {
> +		ret = amba_legacy_suspend(dev, PMSG_SUSPEND);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_suspend_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->suspend_noirq)
> +			ret = drv->pm->suspend_noirq(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_resume(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->resume)
> +			ret = drv->pm->resume(dev);
> +	} else {
> +		ret = amba_legacy_resume(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_resume_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->resume_noirq)
> +			ret = drv->pm->resume_noirq(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +#else /* !CONFIG_SUSPEND */
> +
> +#define amba_pm_suspend		NULL
> +#define amba_pm_resume		NULL
> +#define amba_pm_suspend_noirq	NULL
> +#define amba_pm_resume_noirq	NULL
> +
> +#endif /* !CONFIG_SUSPEND */
> +
> +#ifdef CONFIG_HIBERNATION
> +
> +static int amba_pm_freeze(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->freeze)
> +			ret = drv->pm->freeze(dev);
> +	} else {
> +		ret = amba_legacy_suspend(dev, PMSG_FREEZE);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_freeze_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->freeze_noirq)
> +			ret = drv->pm->freeze_noirq(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_thaw(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->thaw)
> +			ret = drv->pm->thaw(dev);
> +	} else {
> +		ret = amba_legacy_resume(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_thaw_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->thaw_noirq)
> +			ret = drv->pm->thaw_noirq(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_poweroff(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->poweroff)
> +			ret = drv->pm->poweroff(dev);
> +	} else {
> +		ret = amba_legacy_suspend(dev, PMSG_HIBERNATE);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_poweroff_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->poweroff_noirq)
> +			ret = drv->pm->poweroff_noirq(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_restore(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->restore)
> +			ret = drv->pm->restore(dev);
> +	} else {
> +		ret = amba_legacy_resume(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amba_pm_restore_noirq(struct device *dev)
> +{
> +	struct device_driver *drv = dev->driver;
> +	int ret = 0;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (drv->pm) {
> +		if (drv->pm->restore_noirq)
> +			ret = drv->pm->restore_noirq(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +#else /* !CONFIG_HIBERNATION */
> +
> +#define amba_pm_freeze		NULL
> +#define amba_pm_thaw		NULL
> +#define amba_pm_poweroff		NULL
> +#define amba_pm_restore		NULL
> +#define amba_pm_freeze_noirq	NULL
> +#define amba_pm_thaw_noirq		NULL
> +#define amba_pm_poweroff_noirq	NULL
> +#define amba_pm_restore_noirq	NULL
> +
> +#endif /* !CONFIG_HIBERNATION */
> +
> +#ifdef CONFIG_PM
> +
> +static const struct dev_pm_ops amba_pm = {
> +	.prepare	= amba_pm_prepare,
> +	.complete	= amba_pm_complete,
> +	.suspend	= amba_pm_suspend,
> +	.resume		= amba_pm_resume,
> +	.freeze		= amba_pm_freeze,
> +	.thaw		= amba_pm_thaw,
> +	.poweroff	= amba_pm_poweroff,
> +	.restore	= amba_pm_restore,
> +	.suspend_noirq	= amba_pm_suspend_noirq,
> +	.resume_noirq	= amba_pm_resume_noirq,
> +	.freeze_noirq	= amba_pm_freeze_noirq,
> +	.thaw_noirq	= amba_pm_thaw_noirq,
> +	.poweroff_noirq	= amba_pm_poweroff_noirq,
> +	.restore_noirq	= amba_pm_restore_noirq,
> +	SET_RUNTIME_PM_OPS(
> +		pm_generic_runtime_suspend,
> +		pm_generic_runtime_resume,
> +		pm_generic_runtime_idle
> +	)
> +};
> +
> +#define AMBA_PM (&amba_pm)
> +
> +#else /* !CONFIG_PM */
> +
> +#define AMBA_PM	NULL
> +
> +#endif /* !CONFIG_PM */
> +
>  /*
>   * Primecells are part of the Advanced Microcontroller Bus Architecture,
>   * so we call the bus "amba".
> @@ -111,8 +406,7 @@ struct bus_type amba_bustype = {
>  	.dev_attrs	= amba_dev_attrs,
>  	.match		= amba_match,
>  	.uevent		= amba_uevent,
> -	.suspend	= amba_suspend,
> -	.resume		= amba_resume,
> +	.pm		= AMBA_PM,
>  };
>  
>  static int __init amba_init(void)
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index a0ccf28..1849975 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -58,6 +58,8 @@ enum amba_vendor {
>  
>  extern struct bus_type amba_bustype;
>  
> +#define to_amba_device(d)	container_of(d, struct amba_device, dev)
> +
>  #define amba_get_drvdata(d)	dev_get_drvdata(&d->dev)
>  #define amba_set_drvdata(d,p)	dev_set_drvdata(&d->dev, p)
>  
> 
