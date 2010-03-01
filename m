From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Mon, 01 Mar 2010 14:25:35 -0800
Message-ID: <87r5o3adcw.fsf@deeprootsystems.com>
References: <201002262224.02694.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1002261702070.2029-100000@iolanthe.rowland.org>
	<20100227104309.GB2994@sirena.org.uk> <201002272350.16523.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002272350.16523.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat\, 27 Feb 2010 23\:50\:16 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Saturday 27 February 2010, Mark Brown wrote:
>> On Fri, Feb 26, 2010 at 05:06:59PM -0500, Alan Stern wrote:
>> > On Fri, 26 Feb 2010, Rafael J. Wysocki wrote:
>> 
>> > > I have one problem with the design.  Namely, dpm_invoke_runtime_*() can
>> > > run a callback from another subsystem.  Say you are a device class and you
>> > > decide to use dpm_invoke_runtime_*(), but the device's bus type implements
>> > > the runtime PM callbacks, so they will be run as device class suspend and
>> > > resume callbacks.  That doesn't look particularly clean to me.
>> 
>> > That is a valid point.  I suppose there could be separate bus-type, 
>> > device-type, and device-class versions of these functions, but that 
>> > seems like excessive complication with little real benefit.
>> 
>> I do agree that it'd be good to avoid adding any further complexity here
>> - the use case I have is devices that only really have one suspend type
>> and don't want or need to know if it's a runtime, disk or memory suspend.
>
> What about the patch below, then (untested)?
>
> Use GENERIC_SUBSYS_PM_OPS for the subsystem and then
> UNIVERSAL_DEV_PM_OPS for drivers, possibly passing NULL as idle_fn.

This looks good to me for what I'm tinkering with too, but have not
tested it.

One thing missing from the orignal patch is a publicly availble
version of pm_is_runtime_suspended().  I found this useful in at least
one driver where I needed a slightly different suspend hook from he
runtime hook.

Kevin

>
> ---
>  drivers/base/power/Makefile      |    1 
>  drivers/base/power/generic_ops.c |  119 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pm.h               |   67 +++++++++++++++++++--
>  3 files changed, 181 insertions(+), 6 deletions(-)
>
> Index: linux-2.6/drivers/base/power/Makefile
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/Makefile
> +++ linux-2.6/drivers/base/power/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_PM)	+= sysfs.o
>  obj-$(CONFIG_PM_SLEEP)	+= main.o
>  obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
> +obj-$(CONFIG_PM_OPS)	+= generic_ops.o
>  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> Index: linux-2.6/drivers/base/power/generic_ops.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/generic_ops.c
> +++ linux-2.6/drivers/base/power/generic_ops.c
> @@ -6,3 +6,122 @@
>   * This file is released under the GPLv2.
>   */
>  
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +
> +#ifdef CONFIG_PM_RUNTIME
> +/**
> + * pm_generic_runtime_idle - Generic runtime idle callback for subsystems.
> + * @dev: Device to handle.
> + *
> + * If PM operations are defined for the driver of @dev and they include
> + * ->runtime_idle(), execute it and return the error code returned by it if
> + * nonzero.  Otherwise, execute pm_runtime_suspend() for the device.
> + */
> +int pm_generic_runtime_idle(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm && pm->runtime_idle) {
> +		int ret = pm->runtime_idle(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pm_runtime_suspend(dev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pm_generic_runtime_idle);
> +
> +/**
> + * pm_generic_runtime_suspend - Generic runtime suspend callback for subsystems.
> + * @dev: Device to suspend.
> + *
> + * If PM operations are defined for the driver of @dev and they include
> + * ->runtime_suspend(), execute it and return the error code returned by it.
> + * Otherwise, return zero.
> + */
> +int pm_generic_runtime_suspend(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int ret = 0;
> +
> +	if (pm && pm->runtime_suspend)
> +		ret = pm->runtime_suspend(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
> +
> +/**
> + * pm_generic_runtime_resume - Generic runtime resume callback for subsystems.
> + * @dev: Device to resume.
> + *
> + * If PM operations are defined for the driver of @dev and they include
> + * ->runtime_resume(), execute it and return the error code returned by it.
> + * Otherwise, return zero.
> + */
> +int pm_generic_runtime_resume(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int ret = 0;
> +
> +	if (pm && pm->runtime_resume)
> +		ret = pm->runtime_resume(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
> +#endif /* CONFIG_PM_RUNTIME */
> +
> +#define CONFIG_PM_SLEEP
> +/**
> + * pm_generic_suspend - Generic suspend callback for subsystems.
> + * @dev: Device to suspend.
> + *
> + * If the device has not been suspended at run time, execute the suspend
> + * callback provided by its driver, if defined, and return the error code
> + * returned by it.  Otherwise, return zero.
> + */
> +int pm_generic_suspend(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int ret = 0;
> +
> +	if (dev->power.runtime_status == RPM_SUSPENDED)
> +		return 0;
> +
> +	if (pm && pm->suspend)
> +		ret = pm->suspend(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_generic_suspend);
> +
> +/**
> + * pm_generic_resume - Generic resume callback for subsystems.
> + * @dev: Device to resume.
> + *
> + * Execute the resume callback provided by the driver of @dev, if defined.
> + * If it returns 0, change the device's runtime PM status to 'active'.  Return
> + * the error code returned by it.
> + */
> +int pm_generic_resume(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int ret;
> +
> +	if (!pm || !pm->resume)
> +		return 0;
> +
> +	ret = pm->resume(dev);
> +	if (!ret) {
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_active(dev);
> +		pm_runtime_enable(dev);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pm_generic_resume);
> +#endif /* CONFIG_PM_SLEEP */
> Index: linux-2.6/include/linux/pm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pm.h
> +++ linux-2.6/include/linux/pm.h
> @@ -215,18 +215,73 @@ struct dev_pm_ops {
>  	int (*runtime_idle)(struct device *dev);
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
> +#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +	.suspend = suspend_fn, \
> +	.resume = resume_fn, \
> +	.freeze = suspend_fn, \
> +	.thaw = resume_fn, \
> +	.poweroff = suspend_fn, \
> +	.restore = resume_fn,
> +#else
> +#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> +#endif
> +
> +#ifdef CONFIG_PM_RUNTIME
> +#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +	.runtime_suspend = suspend_fn, \
> +	.runtime_resume = resume_fn, \
> +	.runtime_idle = idle_fn,
> +#else
> +#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
> +#endif
> +
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
>   * to RAM and hibernation.
>   */
>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>  const struct dev_pm_ops name = { \
> -	.suspend = suspend_fn, \
> -	.resume = resume_fn, \
> -	.freeze = suspend_fn, \
> -	.thaw = resume_fn, \
> -	.poweroff = suspend_fn, \
> -	.restore = resume_fn, \
> +SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +}
> +
> +/*
> + * Use this for defining a set of PM operations to be used in all situations
> + * (system suspend, hibernation or runtime PM).
> + */
> +#define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> +const struct dev_pm_ops name = { \
> +SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +#define GENERIC_SYSTEM_SLEEP_PM_OPS \
> +	.suspend = pm_generic_suspend, \
> +	.resume = pm_generic_resume,
> +#else
> +#define GENERIC_SYSTEM_SLEEP_PM_OPS
> +
> +#endif
> +
> +#ifdef CONFIG_PM_RUNTIME
> +#define GENERIC_RUNTIME_PM_OPS \
> +	.runtime_suspend = pm_generic_runtime_suspend, \
> +	.runtime_resume = pm_generic_runtime_resume, \
> +	.runtime_idle = pm_generic_runtime_idle,
> +#else
> +#define GENERIC_RUNTIME_PM_OPS
> +#endif
> +
> +/*
> + * Use this for subsystems (bus types, device types, device classes) that only
> + * need to invoke PM callbacks provided by device drivers supporting both the
> + * system sleep PM and runtime PM.
> + */
> +#define GENERIC_SUBSYS_PM_OPS(name) \
> +const struct dev_pm_ops name = { \
> +GENERIC_SYSTEM_SLEEP_PM_OPS \
> +GENERIC_RUNTIME_PM_OPS \
>  }
>  
>  /**
