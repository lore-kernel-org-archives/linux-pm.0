From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
	with device-specific OPPs
Date: Tue, 26 Apr 2011 13:09:47 +0200
Message-ID: <201104261309.47629.rjw@sisk.pl>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

To start with let me say I don't have any fundamental objections at this point,
although I'm not 100% sure I understand correctly how this feature is supposed
to be used.  My understanding is that if a device is known to have multiple
OPPs, its subsystem and driver may call dvfs_add_device() for it, which will
cause it to be periodically monitored and put into the "optimum" OPP using
the infrastructure introduced by your patch (on the basis of the given
usage profile and with the help of the given governor).  Is that correct?

That said I have some specific comments below.

On Tuesday, April 26, 2011, MyungJoo Ham wrote:
> With OPPs, a device may have multiple operable frequency and voltage
> sets. However, there can be multiple possible operable sets and a system
> will need to choose one from them. In order to reduce the power
> consumption (by reducing frequency and voltage) without affecting the
> performance too much, a DVFS scheme may be used.
> 
> This patch introduces the DVFS capability to non-CPU devices with OPPs.

Well, I'd like the DVFS acronym to be expanded at least once somewhere,
possibly in the comments describing the new files and necessarily in the
Kconfig option description.

> In this RTC version, we do not have specific gorvernors or device

RFC I guess?

> support, yet. However, we plan to test and use DVFS scheme on
> DRAM/BUS/GPU for our test boards (Exynos4-NURI), which have DVFS
> capability and have seperated DVFS-like drivers without any common code.
> 
> The generic DVFS may appear quite similar with /drivers/cpufreq.
> However, CPUFREQ does not allow to have multiple devices registered and
> is not suitable to have multiple heterogenous devices with different
> (but simple) governors.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/base/power/Makefile |    1 +
>  drivers/base/power/dvfs.c   |  401 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/power/opp.c    |    7 +
>  include/linux/dvfs.h        |   69 ++++++++
>  kernel/power/Kconfig        |    9 +
>  5 files changed, 487 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/power/dvfs.c
>  create mode 100644 include/linux/dvfs.h
> 
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 118c1b9..4d92d7f 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
>  obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
>  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>  obj-$(CONFIG_PM_OPP)	+= opp.o
> +obj-$(CONFIG_PM_GENERIC_DVFS)	+= dvfs.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>  ccflags-$(CONFIG_PM_VERBOSE)   += -DDEBUG
> diff --git a/drivers/base/power/dvfs.c b/drivers/base/power/dvfs.c
> new file mode 100644
> index 0000000..867ad70
> --- /dev/null
> +++ b/drivers/base/power/dvfs.c
> @@ -0,0 +1,401 @@
> +/*
> + * Generic DVFS Interface for Non-CPU Devices
> + *	Based on OPP.
> + *
> + * Copyright (C) 2011 Samsung Electronics
> + *	MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/opp.h>
> +#include <linux/dvfs.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_device.h>
> +#include <linux/list.h>
> +
> +#define DVFS_INTERVAL	20

You should state in a comment what's the unit of this and explain the choice
of the value.

> +/**
> + * struct dvfs - Device DVFS structure
> + * @node	list node - contains the devices with DVFS that have been
> + *		registered.
> + * @dev		device pointer
> + * @profile	device-specific dvfs profile
> + * @governor	method how to choose frequency based on the usage.
> + * @previous_freq	previously configured frequency value.
> + * @next_polling	the number of remaining "dvfs_monitor" executions to
> + *			reevaluate frequency/voltage of the device. Set by
> + *			profile's polling_ms interval.
> + * @tickle	positive if DVFS-tickling is activated for the device.
> + *		at each executino of dvfs_monitor, tickle is decremented.
> + *		User may tickle a device-dvfs in order to set maximum
> + *		frequency instaneously with some guaranteed duration.
> + *
> + * This structure stores the DVFS information for a give device.
> + */
> +struct dvfs {
> +	struct list_head node;
> +
> +	struct device *dev;
> +	struct dvfs_device_profile *profile;
> +	struct dvfs_governor *governor;
> +
> +	unsigned long previous_freq;
> +	unsigned int next_polling;
> +	unsigned int tickle;
> +};
> +

I'd move the structure definition to the header file you introduce below.
Even though it's supposed to be internal, it's better to have it defined
next to the other structures for the benefit of the people who will
try to understand your code in the future.

> +/*
> + * dvfs_work periodically (given by DVFS_INTERVAL) monitors every
> + * registered device.
> + */
> +static struct delayed_work dvfs_work;
> +/* The list of all device-dvfs */
> +static LIST_HEAD(dvfs_list);
> +/* Exclusive access to dvfs_list and its elements */
> +static DEFINE_MUTEX(dvfs_list_lock);
> +
> +/**
> + * find_device_dvfs() - find dvfs struct using device pointer
> + * @dev:	device pointer used to lookup device DVFS.
> + *
> + * Search the list of device DVFSs and return the matched device's DVFS info.
> + */
> +static struct dvfs *find_device_dvfs(struct device *dev)
> +{
> +	struct dvfs *tmp_dvfs, *dvfs = ERR_PTR(-ENODEV);
> +
> +	if (unlikely(IS_ERR_OR_NULL(dev))) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	list_for_each_entry(tmp_dvfs, &dvfs_list, node) {
> +		if (tmp_dvfs->dev == dev) {
> +			dvfs = tmp_dvfs;
> +			break;
> +		}
> +	}
> +
> +	return dvfs;
> +}
> +
> +/**
> + * dvfs_next_polling() - the number of dvfs-monitor iterations to satisfy
> + *		the given polling interval. The interval is rounded by
> + *		dvfs-monitor poling interval (DVFS_INTERVAL) with ceiling
> + *		function.
> + * @ms:		the length of polling interval in milli-second
> + */
> +static unsigned int dvfs_next_polling(int ms)
> +{
> +	unsigned int ret;
> +
> +	if (ms <= 0)
> +		return 0;
> +
> +	ret = ms / DVFS_INTERVAL;
> +	if (ms % DVFS_INTERVAL)
> +		ret++;
> +
> +	return ret;
> +}

It seems you could use DIV_ROUND_UP instead of this whole function.

> +
> +/**
> + * dvfs_do() - Check the usage profile of a given device and configure
> + *		frequency and voltage accordingly
> + * @dvfs:	DVFS info of the given device
> + */
> +static int dvfs_do(struct dvfs *dvfs)
> +{
> +	struct dvfs_usage_profile profile;
> +	struct opp *opp;
> +	unsigned long freq;
> +	int err;
> +
> +	err = dvfs->profile->get_usage_profile(dvfs->dev, &profile);
> +	if (err) {
> +		dev_err(dvfs->dev, "%s: Cannot get usage profile (%d)\n",
> +			__func__, err);
> +		return err;
> +	}
> +
> +	err = dvfs->governor->get_target_freq(&profile, dvfs->governor, &freq);

It may be better to define ->get_target_freq() so that it takes devfs as an arg.
In that case you'd need to pass fewer pointers and the governor would be
able to access all of its data anyway.

> +	if (err) {
> +		dev_err(dvfs->dev, "%s: Cannot get target frequency (%d)\n",
> +			__func__, err);
> +		return err;
> +	}
> +
> +	opp = opp_find_freq_ceil(dvfs->dev, &freq);
> +	if (opp == ERR_PTR(-ENODEV))
> +		opp = opp_find_freq_floor(dvfs->dev, &freq);
> +
> +	if (IS_ERR(opp)) {
> +		dev_err(dvfs->dev, "%s: Cannot find opp with %luHz.\n",
> +				__func__, freq);
> +		return PTR_ERR(opp);
> +	}
> +
> +	freq = opp_get_freq(opp);
> +	if (dvfs->previous_freq != freq) {
> +		err = dvfs->profile->target(dvfs->dev, freq,
> +					    opp_get_voltage(opp));
> +		dvfs->previous_freq = freq;
> +	}
> +
> +	if (err)
> +		dev_err(dvfs->dev, "%s: Cannot set %luHz/%luuV\n", __func__,
> +			opp_get_freq(opp), opp_get_voltage(opp));
> +	return err;
> +}

I'd generally consider using fewer error messages.  While they may be good
for debugging, they have a potential of spamming the kernel's message buffer
in case of a problem on a production system.  Also they don't really make
the code cleaner, so to speak. :-)

> +
> +/**
> + * dvfs_monitor() - Regularly run dvfs_do() and support device DVFS tickle.
> + * @work: the work struct used to run dvfs_monitor periodically.
> + */
> +static void dvfs_monitor(struct work_struct *work)
> +{
> +	struct dvfs *dvfs;
> +
> +	mutex_lock(&dvfs_list_lock);
> +
> +	list_for_each_entry(dvfs, &dvfs_list, node) {
> +		if (dvfs->next_polling == 0)
> +			continue;
> +		if (dvfs->tickle) {
> +			dvfs->tickle--;
> +			continue;
> +		}
> +		if (dvfs->next_polling == 1) {
> +			dvfs_do(dvfs);
> +			dvfs->next_polling = dvfs_next_polling(
> +						dvfs->profile->polling_ms);
> +		} else {
> +			dvfs->next_polling--;
> +		}
> +	}
> +
> +	schedule_delayed_work(&dvfs_work, msecs_to_jiffies(DVFS_INTERVAL));
> +	mutex_unlock(&dvfs_list_lock);
> +}
> +
> +/**
> + * dvfs_add_device() - Add dvfs feature to the device
> + * @dev:	the device to add dvfs feature.
> + * @profile:	device-specific profile to run dvfs.
> + * @governor:	the policy to choose frequency.
> + */
> +int dvfs_add_device(struct device *dev, struct dvfs_device_profile *profile,
> +		    struct dvfs_governor *governor)
> +{
> +	struct dvfs *new_dvfs, *dvfs;
> +	struct cpufreq_frequency_table *table;
> +	int err;
> +
> +	if (!dev || !profile || !governor) {
> +		dev_err(dev, "%s: Invalid parameters.\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	err = opp_init_cpufreq_table(dev, &table);

I'd change the name opp_init_cpufreq_table() to something more suitable,
since it's no longer used for the CPU frequencies alone.  Something like
opp_init_frequency_table() might work.

> +	if (err) {
> +		dev_err(dev, "%s: Device OPP cannot provide DVFS table (%d)\n",
> +			__func__, err);
> +		return err;
> +	}
> +
> +	new_dvfs = kzalloc(sizeof(struct dvfs), GFP_KERNEL);
> +	if (!new_dvfs) {
> +		dev_err(dev, "%s: Unable to create DVFS for the device\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&dvfs_list_lock);
> +
> +	dvfs = find_device_dvfs(dev);
> +	if (!IS_ERR(dvfs)) {
> +		dev_err(dev, "%s: Unable to create DVFS for the device. "
> +			"It already has one.\n", __func__);
> +		mutex_unlock(&dvfs_list_lock);
> +		kfree(new_dvfs);
> +		return -EINVAL;
> +	}

It seems that this should be checked before allocating the new object
(you can use kzalloc() under the mutex).  I'd even run it before initializing
the device's frequency table.

> +
> +	new_dvfs->dev = dev;
> +	new_dvfs->profile = profile;
> +	new_dvfs->governor = governor;
> +	new_dvfs->next_polling = dvfs_next_polling(profile->polling_ms);
> +	new_dvfs->previous_freq = 0;
> +
> +	list_add(&new_dvfs->node, &dvfs_list);
> +
> +	mutex_unlock(&dvfs_list_lock);
> +
> +	return 0;
> +}
> +
> +/**
> + * dvfs_remove_device() - Remove DVFS feature from a device.
> + * @device:	the device to remove dvfs feature.
> + */
> +int dvfs_remove_device(struct device *dev)
> +{
> +	struct dvfs *dvfs;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	mutex_lock(&dvfs_list_lock);
> +	dvfs = find_device_dvfs(dev);
> +	if (IS_ERR(dvfs)) {
> +		dev_err(dev, "%s: Unable to find DVFS entry for the device.\n",
> +			__func__);
> +		mutex_unlock(&dvfs_list_lock);
> +		return -EINVAL;
> +	}
> +
> +	list_del(&dvfs->node);
> +
> +	kfree(dvfs);
> +
> +	mutex_unlock(&dvfs_list_lock);
> +
> +	return 0;
> +}
> +
> +/**
> + * dvfs_update() - Notify that the device OPP has been changed.
> + * @dev:	the device whose OPP has been changed.
> + * @may_not_exist:	do not print error message even if the device
> + *			does not have dvfs entry.
> + */
> +int dvfs_update(struct device *dev, bool may_not_exist)
> +{
> +	struct dvfs *dvfs;
> +	int err = 0;
> +
> +	mutex_lock(&dvfs_list_lock);
> +	dvfs = find_device_dvfs(dev);
> +	if (!IS_ERR(dvfs)) {
> +		if (dvfs->tickle) {
> +			unsigned long freq = dvfs->profile->max_freq;
> +			struct opp *opp = opp_find_freq_floor(dvfs->dev, &freq);
> +
> +			freq = opp_get_freq(opp);
> +			if (dvfs->previous_freq != freq) {
> +				err = dvfs->profile->target(dvfs->dev, freq,
> +						opp_get_voltage(opp));
> +				dvfs->previous_freq = freq;
> +			}
> +		} else {
> +			err = dvfs_do(dvfs);
> +		}
> +	}
> +	mutex_unlock(&dvfs_list_lock);
> +
> +	if (IS_ERR(dvfs)) {
> +		if (may_not_exist && PTR_ERR(dvfs) == -EINVAL)
> +			return 0;
> +
> +		dev_err(dev, "%s: Device DVFS not found (%ld)\n", __func__,
> +			PTR_ERR(dvfs));
> +		return PTR_ERR(dvfs);
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * dvfs_tickle_device() - Guarantee maximum operation speed for a while
> + *			instaneously.
> + * @dev:	the device to be tickled.
> + * @duration_ms:	the duration of tickle effect.
> + *
> + * Tickle sets the device at the maximum frequency instaneously and
> + * the maximul frequency is guaranteed to be used for the given duration.
          ^^^^^^^
I guess that should be "maximum".

> + * For faster user reponse time, an input event may tickle a related device
> + * so that the input event does not need to wait for the DVFS to react with
> + * normal interval.
> + */

Can you explain how this function is supposed to be used, please?

> +int dvfs_tickle_device(struct device *dev, unsigned long duration_ms)
> +{
> +	struct dvfs *dvfs;
> +	struct opp *opp;
> +	unsigned long freq;
> +	int err = 0;
> +
> +	mutex_lock(&dvfs_list_lock);
> +	dvfs = find_device_dvfs(dev);
> +	if (!IS_ERR(dvfs)) {
> +		freq = dvfs->profile->max_freq;
> +		opp = opp_find_freq_floor(dvfs->dev, &freq);
> +		freq = opp_get_freq(opp);
> +		if (dvfs->previous_freq != freq) {
> +			err = dvfs->profile->target(dvfs->dev, freq,
> +						    opp_get_voltage(opp));
> +			dvfs->previous_freq = freq;
> +		}
> +		if (err)
> +			dev_err(dev, "%s: Cannot set frequency.\n", __func__);
> +		else
> +			dvfs->tickle = dvfs_next_polling(duration_ms);
> +	}
> +	mutex_unlock(&dvfs_list_lock);
> +
> +	if (IS_ERR(dvfs)) {
> +		dev_err(dev, "%s: Cannot find dvfs.\n", __func__);
> +		err = PTR_ERR(dvfs);
> +	}
> +
> +	return err;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dvfs_pause(struct device *dev)
> +{
> +	cancel_delayed_work_sync(&dvfs_work);
> +	return 0;
> +}
> +
> +static void dvfs_continue(struct device *dev)
> +{
> +	schedule_delayed_work(&dvfs_work, msecs_to_jiffies(DVFS_INTERVAL));
> +}
> +#else
> +#define dvfs_pause	NULL
> +#define dvfs_continue	NULL
> +#endif
> +static const struct dev_pm_ops dvfs_pm = {
> +	.prepare	= dvfs_pause,
> +	.complete	= dvfs_continue,
> +};
> +static struct platform_driver dvfs_pm_drv = {
> +	.driver = {
> +		.name	= "generic_dvfs_pm",
> +		.pm	= &dvfs_pm,
> +	},
> +};
> +static struct platform_device dvfs_pm_dev = {
> +	.name = "generic_dvfs_pm",
> +};

Please don't do that.  You can simply use the freezable workqueue introduced
by commit 4149efb (workqueue: add system_freezeable_wq) and then you won't
have to worry about system suspend.

> +
> +static int __init dvfs_init(void)
> +{
> +	platform_driver_register(&dvfs_pm_drv);
> +	platform_device_register(&dvfs_pm_dev);
> +
> +	INIT_DELAYED_WORK_DEFERRABLE(&dvfs_work, dvfs_monitor);
> +	schedule_delayed_work(&dvfs_work, msecs_to_jiffies(DVFS_INTERVAL));
> +
> +	return 0;
> +}
> +late_initcall(dvfs_init);
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 56a6899..df74655 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -21,6 +21,7 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  #include <linux/opp.h>
> +#include <linux/dvfs.h>
>  
>  /*
>   * Internal data structure organization with the OPP layer library is as
> @@ -428,6 +429,9 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>  	list_add_rcu(&new_opp->node, head);
>  	mutex_unlock(&dev_opp_list_lock);
>  
> +	/* Notify generic dvfs for the change */
> +	dvfs_update(dev, true);
> +
>  	return 0;
>  }
>  
> @@ -512,6 +516,9 @@ unlock:
>  	mutex_unlock(&dev_opp_list_lock);
>  out:
>  	kfree(new_opp);
> +
> +	/* Notify generic dvfs for the change */
> +	dvfs_update(dev, true);
>  	return r;
>  }
>  
> diff --git a/include/linux/dvfs.h b/include/linux/dvfs.h
> new file mode 100644
> index 0000000..de3e53d
> --- /dev/null
> +++ b/include/linux/dvfs.h
> @@ -0,0 +1,69 @@
> +/*
> + * Generic DVFS Interface for Non-CPU Devices
> + *
> + * Copyright (C) 2011 Samsung Electronics
> + *	MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_DVFS_H__
> +#define __LINUX_DVFS_H__
> +
> +struct dvfs;
> +
> +struct dvfs_usage_profile {
> +	/* both since the last measure */
> +	unsigned long total_time;
> +	unsigned long busy_time;
> +};
> +
> +struct dvfs_device_profile {
> +	unsigned long max_freq; /* may be larger than the actual value */
> +	int (*target)(struct device *dev, unsigned long freq,
> +		      unsigned long u_volt);
> +	int (*get_usage_profile)(struct device *dev,
> +				 struct dvfs_usage_profile *profile);
> +	int polling_ms;	/* 0 for at opp change only */
> +};
> +
> +struct dvfs_governor {
> +	void *data; /* private data for get_target_freq */
> +	int (*get_target_freq)(struct dvfs_usage_profile *profile,
> +			       struct dvfs_governor *this, unsigned long *freq);
> +};
> +
> +#if defined(CONFIG_PM_GENERIC_DVFS)
> +extern int dvfs_add_device(struct device *ev,
> +			   struct dvfs_device_profile *profile,
> +			   struct dvfs_governor *governor);
> +extern int dvfs_remove_device(struct device *dev);
> +extern int dvfs_update(struct device *dev, bool may_not_exist);
> +extern int dvfs_tickle_device(struct device *dev, unsigned long duration_ms);
> +#else /* !CONFIG_PM_GENERIC_DVFS */
> +static int dvfs_add_device(struct device *ev,
> +			   struct dvfs_device_profile *profile,
> +			   struct dvfs_governor *governor)
> +{
> +	return 0;
> +}
> +
> +static int dvfs_remove_device(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int dvfs_update(struct device *dev, bool may_not_exist)
> +{
> +	return 0;
> +}
> +
> +static int dvfs_tickle_device(struct device *dev, unsigned long duration_ms)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_PM_GENERIC_DVFS */
> +
> +#endif /* __LINUX_DVFS_H__ */
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 4603f08..7d191ec 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -225,3 +225,12 @@ config PM_OPP
>  	  representing individual voltage domains and provides SOC
>  	  implementations a ready to use framework to manage OPPs.
>  	  For more information, read <file:Documentation/power/opp.txt>
> +
> +config PM_GENERIC_DVFS
> +	bool "Generic DVFS framework"
> +	depends on PM_OPP
> +	help
> +	  With OPP support, a device may have a list of frequencies and
> +	  voltages available. Generic DVFS framework provides a method to
> +	  control frequency/voltage of a device with OPP with given profile
> +	  and governor per device.
> 

Thanks,
Rafael
