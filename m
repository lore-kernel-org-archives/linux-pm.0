From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Tue, 2 Mar 2010 11:12:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003021103080.1375-100000@iolanthe.rowland.org>
References: <201003012306.38235.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003012306.38235.rjw@sisk.pl>
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

On Mon, 1 Mar 2010, Rafael J. Wysocki wrote:

> Updated patch is appended.  In the meantime I decided it would be better
> to return error code from pm_generic_runtime_[suspend|resume]() if the driver
> callback is not defined and I chose EINVAL (ie. shouldn't be called for a
> device whose driver has no corresponding runtime callback).

Okay.

> Index: linux-2.6/drivers/base/power/generic_ops.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/generic_ops.c
> +++ linux-2.6/drivers/base/power/generic_ops.c
> @@ -6,3 +6,137 @@
>   * This file is released under the GPLv2.
>   */
>  
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +

There's something strange about this patch -- it doesn't start at the
beginning.  Do you already have an 8-line file named generic_ops.c?  I
don't.

> +struct dev_pm_ops generic_subsys_pm_ops = {
> +#ifdef CONFIG_PM_SLEEP
> +	.suspend = pm_generic_suspend,
> +	.resume = pm_generic_resume,
> +	.freeze = pm_generic_suspend,
> +	.thaw = pm_generic_resume,
> +	.poweroff = pm_generic_suspend,
> +	.restore = pm_generic_resume,
> +#endif
> +#ifdef CONFIG_PM_RUNTIME
> +	.runtime_suspend = pm_generic_runtime_suspend,
> +	.runtime_resume = pm_generic_runtime_resume,
> +	.runtime_idle = pm_generic_runtime_idle,
> +#endif
> +};
> +EXPORT_SYMBOL_GPL(generic_subsys_pm_ops);

Heh, you could use the UNIVERSAL_DEV_PM_OPS macro here.

> Index: linux-2.6/include/linux/pm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pm.h
> +++ linux-2.6/include/linux/pm.h

>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>  const struct dev_pm_ops name = { \
> -	.suspend = suspend_fn, \
> -	.resume = resume_fn, \
> -	.freeze = suspend_fn, \
> -	.thaw = resume_fn, \
> -	.poweroff = suspend_fn, \
> -	.restore = resume_fn, \
> +	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>  }
>  
> +#define SET_UNIVERSAL_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
> +
> +/*
> + * Use this for defining a set of PM operations to be used in all situations
> + * (system suspend, hibernation or runtime PM).
> + */
> +#define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> +const struct dev_pm_ops name = { \
> +	SET_UNIVERSAL_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> +}

Personally, I would avoid defining SET_UNIVERSAL_PM_OPS (it doesn't
seem likely to be used anywhere else) and just put
SET_SYSTEM_SLEEP_PM_OPS followed by SET_RUNTIME_PM_OPS here.

> Index: linux-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pm_runtime.h
> +++ linux-2.6/include/linux/pm_runtime.h
> @@ -62,6 +62,11 @@ static inline void device_set_run_wake(s
>  	dev->power.run_wake = enable;
>  }
>  
> +static inline bool pm_runtime_suspended(struct device *dev)
> +{
> +	return dev->power.runtime_status == RPM_SUSPENDED;
> +}
> +
>  #else /* !CONFIG_PM_RUNTIME */
>  
>  static inline int pm_runtime_idle(struct device *dev) { return -ENOSYS; }
> @@ -89,6 +94,7 @@ static inline void pm_runtime_get_noresu
>  static inline void pm_runtime_put_noidle(struct device *dev) {}
>  static inline bool device_run_wake(struct device *dev) { return false; }
>  static inline void device_set_run_wake(struct device *dev, bool enable) {}
> +static inline bool pm_runtime_suspended(struct device *dev) { return false; }
>  
>  #endif /* !CONFIG_PM_RUNTIME */

The documentation should be updated as well.  You can use some of the 
text from my patch submission if you want.

Alan Stern
