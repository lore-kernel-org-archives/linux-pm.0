From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] thermal: use device node to get thermal zone
Date: Thu, 9 Jan 2014 15:56:05 +0800
Message-ID: <52CE5615.8040204@nvidia.com>
References: <1389172011-32107-1-git-send-email-wni@nvidia.com>
 <4D68720C2E767A4AA6A8796D42C8EB59E09ED1@BGSMSX101.gar.corp.intel.com>
 <52CD452D.3080508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52CD452D.3080508-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "R, Durgadoss" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/08/2014 08:31 PM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
> 
> On 08-01-2014 07:10, R, Durgadoss wrote:
>> Hi Wei,
>>
>>> -----Original Message-----
>>> From: linux-pm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-pm-
>>> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Wei Ni
>>> Sent: Wednesday, January 08, 2014 2:37 PM
>>> To: eduardo.valentin-l0cyMroinI0@public.gmane.org; Zhang, Rui; mark.rutland-5wv7dgnIgG8@public.gmane.org
>>> Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org; linux-
>>> pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wei Ni
>>> Subject: [PATCH] thermal: use device node to get thermal zone
>>>
>>> If use name to get the thermal zone, sometimes it can't
>>> get the unique thermal zone, because the thermal fw support
>>> same name for different thermal zone.
>>> So we can change to use device node to get thermal zone.
> 
> Please check the documentation for .*by_name function. There is an error
> code for the case of multiple instances. In fact, it is designed to be
> used by users who know that in the system there is going to exist only
> one zone with that name.
> 
> I don't think it is correct to simply remove the existing API and
> enforce DT usage. What if the system does not use DT?
> 
>>
>> Eduardo introduced this API because we wanted to get the
>> tzd pointer by using the name. So, for your case, can you
>> introduce a new API *get_by_node instead of changing this
>> API ?
> 
> Agreed, if you need a search by DT node, then you need to provide the
> use cases and propose a new one.

Yes, you are right, I should not remove it simply, I will add a new API
.*by_node.

On the tegra board, it will use two or more sensors to estimate the skin
temperature by reading temps from these sensors and calculate them.
For example, we have two sensors: sensor1 and sensor2. We can register
them to thermal framework by using DT, something like:
thermal-zones {
                sensor1: lm90-local {
			...
                        thermal-sensors = <&lm90 0>;
                };

                sensor2: lm90-remote {
			...
                        thermal-sensors = <&lm90 1>;
                };
}

Then I will add a device node for my skin temperature driver, something
like:
skin_temp {
	...
	#thermal-sensor-cells = <0>;

	sub-devs {
		dev@0 {
			dev = <&sensor1>;
		};

		dev@1 {
			dev = <&sensor2>;
		};
	};
};
So I can parse the DT in the skin temperature driver to get the nodes of
the sensor1 and sensor2, and can use .*get_by_node to get thermal zone
device, then use .get_temp() and other callbacks to get temperature and
other information. If use the *.get_by_name, it may not get the uniqu
one, because I don't know if there has the same name thermal zone,
because some other driver may not use DT to register thermal zone, it
can define any name by itself.

> 
>>
>> Thanks,
>> Durga
>>
>>>
>>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/thermal/of-thermal.c   |    6 ++++--
>>>  drivers/thermal/thermal_core.c |   37 ++++++++++++++++---------------------
>>>  include/linux/thermal.h        |    4 +++-
>>>  3 files changed, 23 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>>> index 04b1be7..97c12cf 100644
>>> --- a/drivers/thermal/of-thermal.c
>>> +++ b/drivers/thermal/of-thermal.c
>>> @@ -330,7 +330,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>>>  	struct thermal_zone_device *tzd;
>>>  	struct __thermal_zone *tz;
>>>
>>> -	tzd = thermal_zone_get_zone_by_name(zone->name);
>>> +	tzd = thermal_zone_get_zone_by_node(zone);
> 
> In DT, nodes have unique names. Are you seen a problem with the above code?

this file is used for DT parse, I think it's better to use .*by_node
instead.

> 
>>>  	if (IS_ERR(tzd))
>>>  		return ERR_PTR(-EPROBE_DEFER);
>>>
>>> @@ -804,6 +804,8 @@ int __init of_parse_thermal_zones(void)
>>>  			of_thermal_free_zone(tz);
>>>  			/* attempting to build remaining zones still */
>>>  		}
>>> +
>>> +		zone->np = child;
>>>  	}
>>>
>>>  	return 0;
>>> @@ -837,7 +839,7 @@ void of_thermal_destroy_zones(void)
>>>  	for_each_child_of_node(np, child) {
>>>  		struct thermal_zone_device *zone;
>>>
>>> -		zone = thermal_zone_get_zone_by_name(child->name);
>>> +		zone = thermal_zone_get_zone_by_node(child);
>>>  		if (IS_ERR(zone))
>>>  			continue;
>>>
>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>> index 338a88b..89e0637 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -1635,42 +1635,37 @@ void thermal_zone_device_unregister(struct
>>> thermal_zone_device *tz)
>>>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>>>
>>>  /**
>>> - * thermal_zone_get_zone_by_name() - search for a zone and returns its ref
>>> - * @name: thermal zone name to fetch the temperature
>>> + * thermal_zone_get_zone_by_node() - search for a zone and returns its ref
>>> + * @node: device node of the thermal zone
>>>   *
>>> - * When only one zone is found with the passed name, returns a reference to it.
>>> + * When thermal zone is found with the passed device node, returns a
>>> reference
>>> + * to it.
>>>   *
>>>   * Return: On success returns a reference to an unique thermal zone with
>>> - * matching name equals to @name, an ERR_PTR otherwise (-EINVAL for invalid
>>> - * paramenters, -ENODEV for not found and -EEXIST for multiple matches).
>>> + * matching device node, an ERR_PTR otherwise (-EINVAL for invalid
>>> + * paramenters, -ENODEV for not found).
>>>   */
>>> -struct thermal_zone_device *thermal_zone_get_zone_by_name(const char
>>> *name)
>>> +struct thermal_zone_device *
>>> +thermal_zone_get_zone_by_node(struct device_node *node)
>>>  {
> 
> You are removing an API, are you checking that all existing users of
> this API are changed accordingly? I don't think so.

Sorry, it's my mistake, I will not remove it in my next pactch.

> 
>>> -	struct thermal_zone_device *pos = NULL, *ref = ERR_PTR(-EINVAL);
>>> -	unsigned int found = 0;
>>> +	struct thermal_zone_device *pos = NULL, *ref = ERR_PTR(-ENODEV);
>>> +	bool found = false;
>>>
>>> -	if (!name)
>>> -		goto exit;
>>> +	if (!node)
>>> +		return ERR_PTR(-EINVAL);
>>>
>>>  	mutex_lock(&thermal_list_lock);
>>>  	list_for_each_entry(pos, &thermal_tz_list, node)
>>> -		if (!strnicmp(name, pos->type, THERMAL_NAME_LENGTH)) {
>>> -			found++;
>>> +		if (node == pos->np) {
>>>  			ref = pos;
>>> +			found = true;
>>> +			break;
>>>  		}
>>>  	mutex_unlock(&thermal_list_lock);
>>>
>>> -	/* nothing has been found, thus an error code for it */
>>> -	if (found == 0)
>>> -		ref = ERR_PTR(-ENODEV);
>>> -	else if (found > 1)
>>> -	/* Success only when an unique zone is found */
>>> -		ref = ERR_PTR(-EEXIST);
>>> -
>>> -exit:
>>>  	return ref;
>>>  }
>>> -EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
>>> +EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
>>>
>>>  #ifdef CONFIG_NET
>>>  static const struct genl_multicast_group thermal_event_mcgrps[] = {
>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>> index f7e11c7..a94de8c 100644
>>> --- a/include/linux/thermal.h
>>> +++ b/include/linux/thermal.h
>>> @@ -162,6 +162,7 @@ struct thermal_zone_device {
>>>  	int id;
>>>  	char type[THERMAL_NAME_LENGTH];
>>>  	struct device device;
>>> +	struct device_node *np;
> 
> Please describe better if you want to add this node in here. Better to
> add it in a separated patch.
> 
>>>  	struct thermal_attr *trip_temp_attrs;
>>>  	struct thermal_attr *trip_type_attrs;
>>>  	struct thermal_attr *trip_hyst_attrs;
>>> @@ -285,7 +286,8 @@ struct thermal_cooling_device *
>>>  thermal_of_cooling_device_register(struct device_node *np, char *, void *,
>>>  				   const struct thermal_cooling_device_ops *);
>>>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>>> -struct thermal_zone_device *thermal_zone_get_zone_by_name(const char
>>> *name);
>>> +struct thermal_zone_device *
>>> +thermal_zone_get_zone_by_node(struct device_node *node);
>>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long
>>> *temp);
>>>
>>>  int get_tz_trend(struct thermal_zone_device *, int);
>>> --
>>> 1.7.9.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 
