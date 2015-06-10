From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/8] PM / QoS: Make it possible to expose device latency tolerance to userspace
Date: Thu, 11 Jun 2015 01:41:42 +0200
Message-ID: <2935466.0G66iQ7dR7@vostro.rjw.lan>
References: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com> <1433170082-117462-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1433170082-117462-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, June 01, 2015 05:47:55 PM Andy Shevchenko wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Typically when a device is created the bus core it belongs to (for example
> PCI) does not know if the device supports things like latency tolerance.
> This is left to the driver that binds to the device in question. However,
> at that time the device has already been created and there is no way to set
> its dev->power.set_latency_tolerance anymore.
> 
> So follow what has been done for other PM QoS attributes as well and allow
> drivers to expose and hide latency tolerance from userspace, if the device
> supports it.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/power/power.h |  2 ++
>  drivers/base/power/qos.c   | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/base/power/sysfs.c | 11 +++++++++++
>  include/linux/pm_qos.h     |  5 +++++
>  4 files changed, 55 insertions(+)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index b6b8a27..0e62fb2 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -33,6 +33,8 @@ extern int pm_qos_sysfs_add_resume_latency(struct device *dev);
>  extern void pm_qos_sysfs_remove_resume_latency(struct device *dev);
>  extern int pm_qos_sysfs_add_flags(struct device *dev);
>  extern void pm_qos_sysfs_remove_flags(struct device *dev);
> +extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
> +extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
>  
>  #else /* CONFIG_PM */
>  
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index e56d538..7f3646e 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -883,3 +883,40 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>  	mutex_unlock(&dev_pm_qos_mtx);
>  	return ret;
>  }
> +
> +/**
> + * dev_pm_qos_expose_latency_tolerance - Expose latency tolerance to userspace
> + * @dev: Device whose latency tolerance to expose
> + */
> +int dev_pm_qos_expose_latency_tolerance(struct device *dev)
> +{
> +	int ret;
> +
> +	if (!dev->power.set_latency_tolerance)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +	ret = pm_qos_sysfs_add_latency_tolerance(dev);
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_expose_latency_tolerance);
> +
> +/**
> + * dev_pm_qos_hide_latency_tolerance - Hide latency tolerance from userspace
> + * @dev: Device whose latency tolerance to hide
> + */
> +void dev_pm_qos_hide_latency_tolerance(struct device *dev)
> +{
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +	pm_qos_sysfs_remove_latency_tolerance(dev);
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +
> +	/* Remove the request from user space now */
> +	pm_runtime_get_sync(dev);
> +	dev_pm_qos_update_user_latency_tolerance(dev,
> +		PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT);
> +	pm_runtime_put(dev);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index d2be3f9..a7b4679 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -738,6 +738,17 @@ void pm_qos_sysfs_remove_flags(struct device *dev)
>  	sysfs_unmerge_group(&dev->kobj, &pm_qos_flags_attr_group);
>  }
>  
> +int pm_qos_sysfs_add_latency_tolerance(struct device *dev)
> +{
> +	return sysfs_merge_group(&dev->kobj,
> +				 &pm_qos_latency_tolerance_attr_group);
> +}
> +
> +void pm_qos_sysfs_remove_latency_tolerance(struct device *dev)
> +{
> +	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
> +}
> +
>  void rpm_sysfs_remove(struct device *dev)
>  {
>  	sysfs_unmerge_group(&dev->kobj, &pm_runtime_attr_group);
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 7b3ae0c..0f65d36 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -161,6 +161,8 @@ void dev_pm_qos_hide_flags(struct device *dev);
>  int dev_pm_qos_update_flags(struct device *dev, s32 mask, bool set);
>  s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev);
>  int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val);
> +int dev_pm_qos_expose_latency_tolerance(struct device *dev);
> +void dev_pm_qos_hide_latency_tolerance(struct device *dev);
>  
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
>  {
> @@ -229,6 +231,9 @@ static inline s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
>  			{ return PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT; }
>  static inline int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>  			{ return 0; }
> +static inline int dev_pm_qos_expose_latency_tolerance(struct device *dev)
> +			{ return 0; }
> +static inline void dev_pm_qos_hide_latency_tolerance(struct device *dev) {}
>  
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev) { return 0; }
>  static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
