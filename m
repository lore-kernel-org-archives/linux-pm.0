From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv8 1/9] devfreq: event: Add new devfreq_event class to
 provide basic data for devfreq governor
Date: Tue, 20 Jan 2015 14:29:19 +0900
Message-ID: <54BDE7AF.1040206@samsung.com>
References: <79052135.1306751421728453211.JavaMail.weblogic@epmlwas04a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <79052135.1306751421728453211.JavaMail.weblogic@epmlwas04a>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo,

On 01/20/2015 01:34 PM, MyungJoo Ham wrote:
>>   
>>  This patch add new devfreq_event class for devfreq_event device which provide
>> raw data (e.g., memory bus utilization/GPU utilization). This raw data from
>> devfreq_event data would be used for the governor of devfreq subsystem.
>> - devfreq_event device : Provide raw data for governor of existing devfreq device
>> - devfreq device       : Monitor device state and change frequency/voltage of device
>>                          using the raw data from devfreq_event device
>>
>> The devfreq subsystem support generic DVFS(Dynamic Voltage/Frequency Scaling)
>> for Non-CPU Devices. The devfreq device would dertermine current device state
>> using various governor (e.g., ondemand, performance, powersave). After completed
>> determination of system state, devfreq device would change the frequency/voltage
>> of devfreq device according to the result of governor.
>>
>> But, devfreq governor must need basic data which indicates current device state.
>> Existing devfreq subsystem only consider devfreq device which check current system
>> state and determine proper system state using basic data. There is no subsystem
>> for device providing basic data to devfreq device.
>>
>> The devfreq subsystem must need devfreq_event device(data-provider device) for
>> existing devfreq device. So, this patch add new devfreq_event class for
>> devfreq_event device which read various basic data(e.g, memory bus utilization,
>> GPU utilization) and provide measured data to existing devfreq device through
>> standard APIs of devfreq_event class.
>>
>> The following description explains the feature of two kind of devfreq class:
>> - devfreq class (existing)
>>  : devfreq consumer device use raw data from devfreq_event device for
>>    determining proper current system state and change voltage/frequency
>>    dynamically using various governors.
>>
>> - devfreq_event class (new)
>>  : Provide measured raw data to devfreq device for governor
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
> 
> []
> 
>> +/**
>> + * devfreq_event_enable_edev() - Enable the devfreq-event dev and increase
>> + *				 the enable_count of devfreq-event dev.
>> + * @edev	: the devfreq-event device
>> + *
>> + * Note that this function increase the enable_count and enable the
>> + * devfreq-event device. The devfreq-event device should be enabled before
>> + * using it by devfreq device.
>> + */
>> +int devfreq_event_enable_edev(struct devfreq_event_dev *edev)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!edev || !edev->desc)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&edev->lock);
>> +	if (edev->desc->ops && edev->desc->ops->enable) {
>> +		ret = edev->desc->ops->enable(edev);
>> +		if (ret < 0)
>> +			goto err;
>> +	}
> 
> Is there any reason to call enable(edev) even when enable_count is already > 0 
> while you do not call disable(edev) while enable_count > 0?
> 
> I think this may incur errors in the related device drivers.
> (e.g., incorrect pairing of clk/runtime-pm/regulator enable/disable
> at the device driver side)

You're right. This part has potential errors. I'll fix it as following:
If edev is already enabled, devfreq_event_enable_edev() will just return
without any operation because devfreq-event(edev) can handle only one event
at the same time.
 
	mutex_lock(&edev->lock);
	if (edev->enable_count)
		dev_warn(&edev->dev, "%s is already enabled\n", edev->desc->name);
		ret = -EINVAL;
		goto err;
	}

	if (edev->desc->ops && edev->desc->ops->enable) {		
		ret = edev->desc->ops->enable(edev);
		if (ret < 0)
			goto err;
	}
	edev->enable_count++;
	

> 
>> +	edev->enable_count++;
>> +err:
>> +	mutex_unlock(&edev->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(devfreq_event_enable_edev);
>> +
>> +/**
>> + * devfreq_event_disable_edev() - Disable the devfreq-event dev and decrease
>> + *				  the enable_count of the devfreq-event dev.
>> + * @edev	: the devfreq-event device
>> + *
>> + * Note that this function decrease the enable_count and disable the
>> + * devfreq-event device. After the devfreq-event device is disabled,
>> + * devfreq device can't use the devfreq-event device for get/set/reset
>> + * operations.
>> + */
>> +int devfreq_event_disable_edev(struct devfreq_event_dev *edev)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!edev || !edev->desc)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&edev->lock);
>> +	if (edev->enable_count > 0) {
>> +		edev->enable_count--;
>> +	} else {
>> +		dev_warn(&edev->dev, "unbalanced enable_count\n");
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	if (edev->desc->ops && edev->desc->ops->disable) {
>> +		ret = edev->desc->ops->disable(edev);
>> +		if (ret < 0) {
>> +			edev->enable_count++;
>> +			goto err;
>> +		}
>> +	}
> 
> You did it correctly with disable here;
> not calling it when it is not required.

As I explained, I'll fix it as following:

	mutex_lock(&edev->lock);
	if (!edev->enable_count) {
		dev_warn(&edev->dev, "%s is already disabled\n", edev->desc->name);
		ret = -EINVAL;
		goto err;
	}

	if (edev->desc->ops && edev->desc->ops->disable) {
		ret = edev->desc->ops->disable(edev);
		if (ret < 0)
			goto err;		
	}
	edev->enable_count--;

> 
>> +err:
>> +	mutex_unlock(&edev->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(devfreq_event_disable_edev);
>> +
> 
> []
>> +EXPORT_SYMBOL_GPL(devfreq_event_is_enabled);
> []
> 
>> +EXPORT_SYMBOL_GPL(devfreq_event_set_event);
> []
> 
>> +
>> +/**
>> + * devfreq_event_get_event() - Get event and total_event from devfreq-event dev.
>> + * @edev	: the devfreq-event device
>> + * @edata	: the calculated data of devfreq-event device
>> + *
>> + * Note that this function get the calculated event data from devfreq-event dev
>> + * after stoping the progress of whole sequence of devfreq-event dev.
>> + */
>> +int devfreq_event_get_event(struct devfreq_event_dev *edev,
>> +			    struct devfreq_event_data *edata)
>> +{
>> +	int ret;
>> +
>> +	if (!edev || !edev->desc)
>> +		return -EINVAL;
>> +
>> +	if (!edev->desc->ops || !edev->desc->ops->get_event)
>> +		return -EINVAL;
>> +
>> +	if (!devfreq_event_is_enabled(edev))
>> +		return -EINVAL;
>> +
>> +	edata->event = edata->total_event = 0;
>> +
>> +	mutex_lock(&edev->lock);
>> +	ret = edev->desc->ops->get_event(edev, edata);
>> +	mutex_unlock(&edev->lock);
>> +
>> +	if ((edata->total_event <= 0)
>> +		|| (edata->event > edata->total_event)) {
>> +		edata->event = edata->total_event = 0;
>> +		ret = -EINVAL;
> 
> total_event is unsigned. (cannot be < 0)
> 
> Plus, get_event() may already have returned a negative value with
> the intention of giving a error different from EINVAL.
> 
> I would just simply set total_event = event = 0 if ret < 0

OK, I'll fix it as following:

	if (ret < 0)
		edata->total_event = edata->event = 0;
> 
> 
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(devfreq_event_get_event);
>> +
>> +/**
>> + * devfreq_event_reset_event() - Reset all opeations of devfreq-event dev.
>> + * @edev	: the devfreq-event device
>> + *
>> + * Note that this function stop all operations of devfreq-event dev and reset
>> + * the current event data to make the devfreq-event device into initial state.
>> + */
>> +int devfreq_event_reset_event(struct devfreq_event_dev *edev)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!edev || !edev->desc)
>> +		return -EINVAL;
>> +
>> +	if (!devfreq_event_is_enabled(edev))
>> +		return -EPERM;
>> +
>> +	mutex_lock(&edev->lock);
>> +	if (edev->desc->ops && edev->desc->ops->reset)
>> +		ret = edev->desc->ops->reset(edev);
>> +	mutex_unlock(&edev->lock);
> 
> In the context of the get_event() handling "load",
> aren't you supposed to set total_event = event = 0; here?

But, devfreq_event_reset_event() function cannot handle edata instance
because edata is not included in edev. The edata instance is only used in devfreq_event_get_event().

> 
>> +
>> +	if (ret < 0)
>> +		return -EINVAL;
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(devfreq_event_reset_event);
>> +
>> +/**
>> + * devfreq_event_get_drvdata() - Return driver-data of devfreq-event dev.
>> + * @edev	: the devfreq-event device
>> + *
>> + * Note that this function return the driver-data of devfreq-event device.
>> + */
>> +void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
>> +{
>> +	return edev->desc->driver_data;
>> +}
>> +EXPORT_SYMBOL_GPL(devfreq_event_get_drvdata);
> 
> Looks like you can simply write this in the header file.
> (either #define or static inline function)

OK, I'll modify it by using static inline function.

> 
> []
> 
>> +EXPORT_SYMBOL_GPL(devfreq_event_get_edev_by_phandle);
> []
>> +EXPORT_SYMBOL_GPL(devfreq_event_get_edev_count);
> []
> 
>> +/**
>> + * devfreq_event_add_edev() - Add new devfreq-event device.
>> + * @dev		: the device owning the devfreq-event device being created
>> + * @desc	: the devfreq-event device's decriptor which include essential
>> + *		  data for devfreq-event device.
>> + *
>> + * Note that this function add new devfreq-event device to devfreq-event class
>> + * list and register the device of the devfreq-event device.
>> + */
>> +struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
>> +						struct devfreq_event_desc *desc)
>> +{
>> +	struct devfreq_event_dev *edev;
>> +	static atomic_t event_no = ATOMIC_INIT(0);
>> +	int ret;
>> +
>> +	if (!dev || !desc)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!desc->name || !desc->ops)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!desc->ops->set_event || !desc->ops->get_event)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	edev = kzalloc(sizeof(struct devfreq_event_dev), GFP_KERNEL);
> 
> devm_* here? (seeing no free)

Free edev instance in devfreq_event_release_edev() as following:

	+
	+static void devfreq_event_release_edev(struct device *dev)
	+{
	+	struct devfreq_event_dev *edev = to_devfreq_event(dev);
	+
	+	kfree(edev);
	+}

> 
>> +	if (!edev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mutex_init(&edev->lock);
>> +	edev->desc = desc;
>> +	edev->dev.parent = dev;
>> +	edev->dev.class = devfreq_event_class;
>> +	edev->dev.release = devfreq_event_release_edev;
>> +
>> +	dev_set_name(&edev->dev, "event.%d", atomic_inc_return(&event_no) - 1);
>> +	ret = device_register(&edev->dev);
>> +	if (ret < 0) {
>> +		put_device(&edev->dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +	dev_set_drvdata(&edev->dev, edev);
>> +
>> +	INIT_LIST_HEAD(&edev->node);
>> +
>> +	mutex_lock(&devfreq_event_list_lock);
>> +	list_add(&edev->node, &devfreq_event_list);
>> +	mutex_unlock(&devfreq_event_list_lock);
>> +
>> +	return edev;
>> +}
>> +EXPORT_SYMBOL_GPL(devfreq_event_add_edev);
>> +
>> +/**
>> + * devfreq_event_remove_edev() - Remove the devfreq-event device registered.
>> + * @dev		: the devfreq-event device
>> + *
>> + * Note that this function remove the registered devfreq-event device.
>> + */
>> +int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
>> +{
>> +	if (!edev)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&devfreq_event_list_lock);
>> +	WARN_ON(edev->enable_count);
> 
> Let's WARN before mutex_lock();

OK.

> 
>> +	list_del(&edev->node);
>> +	device_unregister(&edev->dev);
> 
> Let's unregister after mutex_unlock();
> 
> The two lines do not need to be protected by the mutex.

OK.

> 
>> +	mutex_unlock(&devfreq_event_list_lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(devfreq_event_remove_edev);
>> +
> 
> []
> 
>> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
>> new file mode 100644
>> index 0000000..1ced42c
>> --- /dev/null
>> +++ b/drivers/devfreq/event/Kconfig
>> @@ -0,0 +1,16 @@
>> +menuconfig PM_DEVFREQ_EVENT
>> +	bool "DEVFREQ-Event device Support"
>> +	help
>> +	  The devfreq-event device provide the raw data and events which
>> +	  indicate the current state of devfreq-event device. The provided
>> +	  data from devfreq-event device is used to monitor the state of
>> +	  device and determine the suitable size of resource to reduce the
>> +	  wasted resource.
>> +
>> +	  The devfreq-event device can support the various type of events
>> +	  (e.g., raw data, utilization, latency, bandwidth). The events
>> +	  may be used by devfreq governor and other subsystem.
>> +
>> +if PM_DEVFREQ_EVENT
>> +
>> +endif # PM_DEVFREQ_EVENT
>> diff --git a/drivers/devfreq/event/Makefile b/drivers/devfreq/event/Makefile
>> new file mode 100644
>> index 0000000..dc56005
>> --- /dev/null
>> +++ b/drivers/devfreq/event/Makefile
>> @@ -0,0 +1 @@
>> +# Exynos DEVFREQ Event Drivers
>> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
>> new file mode 100644
>> index 0000000..b7363f5
>> --- /dev/null
>> +++ b/include/linux/devfreq-event.h
>> @@ -0,0 +1,170 @@
>> +/*
>> + * devfreq-event: a framework to provide raw data and events of devfreq devices
>> + *
>> + * Copyright (C) 2014 Samsung Electronics
>> + * Author: Chanwoo Choi <cw00.choi@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __LINUX_DEVFREQ_EVENT_H__
>> +#define __LINUX_DEVFREQ_EVENT_H__
>> +
>> +#include <linux/device.h>
>> +
>> +/**
>> + * struct devfreq_event_dev - the devfreq-event device
>> + *
>> + * @node	: Contain the devfreq-event device that have been registered.
>> + * @dev		: the device registered by devfreq-event class. dev.parent is
>> + *		  the device using devfreq-event.
>> + * @lock	: a mutex to protect accessing devfreq-event.
>> + * @enable_count: the number of enable function have been called.
>> + * @desc	: the description for devfreq-event device.
>> + *
>> + * This structure contains devfreq-event device information.
>> + */
>> +struct devfreq_event_dev {
>> +	struct list_head node;
>> +
>> +	struct device dev;
>> +	struct mutex lock;
>> +	u32 enable_count;
>> +
>> +	const struct devfreq_event_desc *desc;
>> +};
>> +
>> +/**
>> + * struct devfreq_event_data - the devfreq-event data
>> + *
>> + * @event	: the load of devfreq-event device for polling period
>> + * @total_event	: the total load of devfreq-event device for polling period
>> + *
>> + * This structure contains the data of devfreq-event device for polling period.
>> + */
>> +struct devfreq_event_data {
>> +	unsigned long event;
>> +	unsigned long total_event;
>> +};
> 
> I would like to rephrase and rename as follows:
> 
> + * @load_count		: load count of devfreq-event device for the given period.
> + * @total_count	: total count of devfreq-event device for the given period.
> + *			each count may represent a clock cycle,
> + *			a time unit (ns/us/...), or anything the device driver wants.
> + *			Generally, utilization is load_count / total_count.

OK, I'll change it.

Thanks for your review.

Best Regards,
Chanwoo Choi
