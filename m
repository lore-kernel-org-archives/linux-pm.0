From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/8] PM / Sleep: Make the runtime PM centric path known to the PM core
Date: Tue, 29 Aug 2017 17:15:02 +0200
Message-ID: <13933269.sbLfAJfmVU@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <1504018610-10822-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1504018610-10822-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 29, 2017 4:56:43 PM CEST Ulf Hansson wrote:
> The main principle behind the runtime PM centric path, is to re-use the
> runtime PM callbacks to implement system sleep - and while doing that also
> achieve a fully optimized behaviour from PM point of view.
> 
> More precisely, avoid to wake up a device from its low power state during
> system sleep, unless the device is really needed to be operational. That
> does not only mean avoiding to waste power, but may also decrease system
> suspend/resume time for a device.
> 
> However, using the runtime PM centric path for a device, does put some
> requirements on the behaviour of the PM core and a potential PM domain that
> may be attached to the device. So far, these requirements are not being
> specially considered, except by the generic PM domain.
> 
> To move forward and to make it possible to deploy the runtime PM centric
> path for cross SoC drivers, which may have different PM domains attached to
> its devices depending on the SoC, we must address how to deal with these
> requirements. This change starts by making some adoptions to the PM core,
> while other parts, such as the ACPI PM domain needs to be taken care of
> separately.
> 
> In the runtime PM centric path, the driver is expected to make use of the
> pm_runtime_force_suspend|resume() helpers, to deploy system sleep support.
> More precisely it may assign the system sleep callbacks to these helpers or
> may call them from its own callbacks, in case it needs to perform
> additional actions during system sleep.
> 
> In other words, the PM core must always invoke the system sleep callbacks
> for the device when they are present, to allow the driver to deal with
> the system sleep operations.
> 
> In case the PM core decides to run the direct_complete path for the device,
> it skips invoking most of the system sleep callbacks, besides
> ->prepare|complete(). Therefore using the direct_complete path in
> combination with the runtime PM centric patch for a device, does not play
> well.
> 
> To deal with this issue, let's add a flag 'is_rpm_sleep', to the struct
> dev_pm_info. The driver that deploys the runtime PM centric path, shall set
> the flag for the device during ->probe(), to inform the PM core about that
> it must not use the direct_complete path for the device.
> 
> Note, not allowing the direct_complete path for a device, doesn't implicit
> need to propagate to the device's parent/suppliers. Therefore make the PM
> core check this condition in device_suspend(), before it decides to abandon
> the direct_complete path for parent/suppliers.
> 
> To make the is_rpm_sleep flag internal to the PM core, let's add two APIs.
> 	- dev_pm_use_rpm_sleep(): It sets the flag and should be called by
> 	  the driver during ->probe().
> 	- dev_pm_is_rpm_sleep(): Makes it possible for users of the device,
> 	  like a PM domain, to fetch the state of the flag.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v3:
> 	- New patch.
> 	- This replaces the earlier method of adding the no_direct_complete to
> 	the ACPI structures, according to comments from Rafael.
> 	- This change also address the consern Rafael had around that
> 	direct_complete should not have to be disabled for parent/suppliers, in
> 	case a device use the runtime PM centric path for system sleep.
> 
> ---
>  drivers/base/power/main.c    | 49 +++++++++++++++++++++++++++++++++++++++-----
>  drivers/base/power/runtime.c |  1 +
>  include/linux/pm.h           |  7 +++++++
>  3 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index ea1732e..865737a 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1549,14 +1549,16 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  		if (parent) {
>  			spin_lock_irq(&parent->power.lock);
>  
> -			dev->parent->power.direct_complete = false;
> +			if (!dev->power.is_rpm_sleep)
> +				dev->parent->power.direct_complete = false;

This doesn't look good to me at all.

It potentially breaks the fundamental assumption of the direct_complete
mechanism that no devices with that flag set will ever be runtime resumed
during system suspend.

Which can happen with this change if a device with power.is_rpm_sleep is
resumed causing the parent to be resumed too.

>  			if (dev->power.wakeup_path
>  			    && !dev->parent->power.ignore_children)
>  				dev->parent->power.wakeup_path = true;
>  
>  			spin_unlock_irq(&parent->power.lock);
>  		}
> -		dpm_clear_suppliers_direct_complete(dev);
> +		if (!dev->power.is_rpm_sleep)
> +			dpm_clear_suppliers_direct_complete(dev);

And same here.

>  	}
>  
>  	device_unlock(dev);
> @@ -1709,11 +1711,14 @@ static int device_prepare(struct device *dev, pm_message_t state)
>  	 * A positive return value from ->prepare() means "this device appears
>  	 * to be runtime-suspended and its state is fine, so if it really is
>  	 * runtime-suspended, you can leave it in that state provided that you
> -	 * will do the same thing with all of its descendants".  This only
> -	 * applies to suspend transitions, however.
> +	 * will do the same thing with all of its descendants". To allow this,
> +	 * the is_rpm_sleep flag must not be set, which is default false, but
> +	 * may have been changed by a driver. This only applies to suspend
> +	 * transitions, however.
>  	 */
>  	spin_lock_irq(&dev->power.lock);
> -	dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
> +	dev->power.direct_complete = ret > 0 && !dev->power.is_rpm_sleep &&
> +				state.event == PM_EVENT_SUSPEND;

The only problem addressed by avoiding direct_complete is when runtime PM needs
to work during __device_suspend() for devices with direct_complete set.  You
said that this was not the case with the i2c designware driver, so I'm not sure
what the purpose of this is.

It doesn't solve any other problems at all.

>  	spin_unlock_irq(&dev->power.lock);
>  	return 0;
>  }
> @@ -1841,6 +1846,40 @@ void dpm_for_each_dev(void *data, void (*fn)(struct device *, void *))
>  }
>  EXPORT_SYMBOL_GPL(dpm_for_each_dev);
>  
> +/**
> + * dev_pm_use_rpm_sleep - use the runtime PM centric sleep path.
> + * @dev: the device to use the path for.
> + *
> + * The runtime PM centric path requires the system sleep callbacks for the
> + * driver of the device to be invoked. This function sets the is_rpm_sleep flag
> + * to enable this path to be used, which makes the PM core to adopt to this
> + * behaviour. More precisely the PM core makes sure to not run the
> + * direct_complete path for the chosen device during system sleep, when the
> + * is_rpm_sleep flag is set. A driver using the runtime PM centric path, shall
> + * use the pm_runtime_force_suspend|resume() helpers, to deploy system sleep
> + * support and call this function during ->probe().
> + * The is_rpm_sleep flag is cleared when unbinding/bind-failure of the driver.
> + */
> +void dev_pm_use_rpm_sleep(struct device *dev)
> +{
> +	dev->power.is_rpm_sleep = true;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_use_rpm_sleep);
> +
> +/**
> + * dev_pm_is_rpm_sleep - Returns the value of the is_rpm_sleep flag.
> + * @dev: the device to return the flag for.
> + *
> + * The caller of this function is typically a subsystem or a PM domain that
> + * needs to know if the runtime PM centric path is used for the device. It may
> + * be invoked during any of the system sleep phases.
> + */
> +bool dev_pm_is_rpm_sleep(struct device *dev)
> +{
> +	return dev->power.is_rpm_sleep;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_is_rpm_sleep);
> +
>  static bool pm_ops_is_empty(const struct dev_pm_ops *ops)
>  {
>  	if (!ops)
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7bcf80f..b2ab22c 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1522,6 +1522,7 @@ void pm_runtime_reinit(struct device *dev)
>  				pm_runtime_put(dev->parent);
>  		}
>  	}
> +	dev->power.is_rpm_sleep = false;
>  }
>  
>  /**
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 47ded8a..5bf96d2 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -559,6 +559,7 @@ struct dev_pm_info {
>  	bool			is_suspended:1;	/* Ditto */
>  	bool			is_noirq_suspended:1;
>  	bool			is_late_suspended:1;
> +	bool			is_rpm_sleep:1;	/* Owned by the PM core */

It is expected to be set by drivers, so by definition it is *not* owned by the
PM core.

>  	bool			early_init:1;	/* Owned by the PM core */
>  	bool			direct_complete:1;	/* Owned by the PM core */
>  	spinlock_t		lock;
> @@ -716,6 +717,9 @@ extern void __suspend_report_result(const char *function, void *fn, int ret);
>  extern int device_pm_wait_for_dev(struct device *sub, struct device *dev);
>  extern void dpm_for_each_dev(void *data, void (*fn)(struct device *, void *));
>  
> +extern void dev_pm_use_rpm_sleep(struct device *dev);
> +extern bool dev_pm_is_rpm_sleep(struct device *dev);
> +
>  extern int pm_generic_prepare(struct device *dev);
>  extern int pm_generic_suspend_late(struct device *dev);
>  extern int pm_generic_suspend_noirq(struct device *dev);
> @@ -759,6 +763,9 @@ static inline void dpm_for_each_dev(void *data, void (*fn)(struct device *, void
>  {
>  }
>  
> +static inline void dev_pm_use_rpm_sleep(struct device *dev) {}
> +static inline bool dev_pm_is_rpm_sleep(struct device *dev) { return false; }
> +
>  #define pm_generic_prepare		NULL
>  #define pm_generic_suspend_late		NULL
>  #define pm_generic_suspend_noirq	NULL
> 

Thanks,
Rafael

