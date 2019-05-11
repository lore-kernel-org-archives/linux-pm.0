From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] thermal: Introduce
 devm_thermal_of_cooling_device_register
Date: Sat, 11 May 2019 13:22:19 -0700
Message-ID: <4be54a9c-ccc9-5489-6938-c66229d361b3@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-2-git-send-email-linux@roeck-us.net>
 <20190511190415.GA22816@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190511190415.GA22816@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

On 5/11/19 12:04 PM, Eduardo Valentin wrote:
> Hello Guenter,
> 
> On Thu, Apr 18, 2019 at 12:58:15PM -0700, Guenter Roeck wrote:
>> thermal_of_cooling_device_register() and thermal_cooling_device_register()
>> are typically called from driver probe functions, and
>> thermal_cooling_device_unregister() is called from remove functions. This
>> makes both a perfect candidate for device managed functions.
>>
>> Introduce devm_thermal_of_cooling_device_register(). This function can
>> also be used to replace thermal_cooling_device_register() by passing a NULL
>> pointer as device node. The new function requires both struct device *
>> and struct device_node * as parameters since the struct device_node *
>> parameter is not always identical to dev->of_node.
>>
>> Don't introduce a device managed remove function since it is not needed
>> at this point.
> 
> I don't have any objection on adding this API. Only a minor thing below:
> 
> 
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/thermal/thermal_core.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/thermal.h        |  5 +++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 6590bb5cb688..e0b530603db6 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1046,6 +1046,55 @@ thermal_of_cooling_device_register(struct device_node *np,
>>   }
>>   EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
>>   
>> +static void thermal_cooling_device_release(struct device *dev, void *res)
>> +{
>> +	thermal_cooling_device_unregister(
>> +				*(struct thermal_cooling_device **)res);
>> +}
>> +
>> +/**
>> + * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
>> + *					       device
>> + * @dev:	a valid struct device pointer of a sensor device.
>> + * @np:		a pointer to a device tree node.
>> + * @type:	the thermal cooling device type.
>> + * @devdata:	device private data.
>> + * @ops:	standard thermal cooling devices callbacks.
>> + *
>> + * This function will register a cooling device with device tree node reference.
>> + * This interface function adds a new thermal cooling device (fan/processor/...)
>> + * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
>> + * to all the thermal zone devices registered at the same time.
>> + *
>> + * Return: a pointer to the created struct thermal_cooling_device or an
>> + * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
>> + */
>> +struct thermal_cooling_device *
>> +devm_thermal_of_cooling_device_register(struct device *dev,
>> +				struct device_node *np,
>> +				char *type, void *devdata,
>> +				const struct thermal_cooling_device_ops *ops)
>> +{
>> +	struct thermal_cooling_device **ptr, *tcd;
>> +
>> +	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
>> +			   GFP_KERNEL);
>> +	if (!ptr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
>> +	if (IS_ERR(tcd)) {
>> +		devres_free(ptr);
>> +		return tcd;
>> +	}
>> +
>> +	*ptr = tcd;
>> +	devres_add(dev, ptr);
>> +
>> +	return tcd;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
>> +
>>   static void __unbind(struct thermal_zone_device *tz, int mask,
>>   		     struct thermal_cooling_device *cdev)
>>   {
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 5f4705f46c2f..43cf4fdd71d4 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -447,6 +447,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
>>   struct thermal_cooling_device *
>>   thermal_of_cooling_device_register(struct device_node *np, char *, void *,
>>   				   const struct thermal_cooling_device_ops *);
>> +struct thermal_cooling_device *
>> +devm_thermal_of_cooling_device_register(struct device *dev,
>> +				struct device_node *np,
>> +				char *type, void *devdata,
>> +				const struct thermal_cooling_device_ops *ops);
> 
> We need to stub this in case thermal is not selected.
> 

Yes. Sorry, that completely slipped my mind.

>>   void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>>   struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
>>   int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> 
> Something like:
> 
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 43cf4fd..9b1b365 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -508,6 +508,14 @@ static inline struct thermal_cooling_device *
>   thermal_of_cooling_device_register(struct device_node *np,
>          char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
>   { return ERR_PTR(-ENODEV); }
> +struct thermal_cooling_device *
> +devm_thermal_of_cooling_device_register(struct device *dev,
> +                               struct device_node *np,
> +                               char *type, void *devdata,
> +                               const struct thermal_cooling_device_ops *ops)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
>   static inline void thermal_cooling_device_unregister(
>          struct thermal_cooling_device *cdev)
>   { }
> ~
> 
> 
> If you want I can amend this to your patch and apply it.
> 
Please do.

> Also, do you prefer me to collect only this patch and you would collect hwmon changes,
> or are you ok if I collect all the series?
> 

Please go ahead and collect the entire series.

Thanks,
Guenter
