From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] thermal: introduce thermal_zone_get_zone_by_node
 helper function
Date: Tue, 14 Jan 2014 18:35:29 +0800
Message-ID: <52D512F1.1090008@nvidia.com>
References: <1389263879-10483-1-git-send-email-wni@nvidia.com>
 <1389263879-10483-2-git-send-email-wni@nvidia.com> <52D40EC6.6050509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D40EC6.6050509-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/14/2014 12:05 AM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
> 
> On 09-01-2014 06:37, Wei Ni wrote:
>> The thermal framework start to support device tree, this
>> patch adds a helper function to get a reference of a
>> thermal zone, based on the zone's device node.
> 
> I would prefer if you could provide a better justification why we need
> this API. Think of the scope of this API: would it be used only by the
> of-thermal code? only by the drivers/thermal code? or any driver?

I have talked it in the previous patch "Re: [PATCH] thermal: use device
node to get thermal zone".
So let me copy to here again:

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
other information.

> 
> So far you have provided only one user, and that user can already work
> with existing APIs. As I mention, DT does not support name duplications.

If the system only have the DT, then there will not have name
duplications. But some drivers will call the
thermal_zone_device_register directly with any thermal zone type, and at
same time, other drivers may use of-thermal to register, and set the
same name in the DT. Then if use the *.get_by_name, it can't get the
uniqu one.

> 
> Unless you enlighten  me with better uses of this API, I would prefer
> not to have it.
> 
> 
>>
>> It will add a device_node *np member in the struct
>> thermal_zone_device, and initialize it when create a thermal
>> zone. This funciton perform a zone device node lookup and
>> return a reference to a thermal zone device that matches
>> the device node requested.
>> In case the zone is not found or if the required parameters
>> are invalid, it will return the corresponding error code (ERR_PTR).
>>
>> Change-Id: I4d65f849e84425dddd387f70886a9c7c4c2002f2
> 
> For your next patches, please done include gerrit change IDs. Linux
> Kernel does not need to be linked to your inhouse development history
> via gerrit IDs.

It's so sorry, I forgot to remove it.

> 
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/thermal/of-thermal.c   |    2 ++
>>  drivers/thermal/thermal_core.c |   33 +++++++++++++++++++++++++++++++++
>>  include/linux/thermal.h        |    3 +++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>> index 04b1be7..53f2d3a 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -804,6 +804,8 @@ int __init of_parse_thermal_zones(void)
>>  			of_thermal_free_zone(tz);
>>  			/* attempting to build remaining zones still */
>>  		}
>> +
>> +		zone->np = child;
>>  	}
>>  
>>  	return 0;
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 338a88b..eeddb94 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1672,6 +1672,39 @@ exit:
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
>>  
>> +/**
>> +* thermal_zone_get_zone_by_node() - search for a zone and returns its ref
>> +* @node: device node of the thermal zone
>> +*
>> +* When thermal zone is found with the passed device node, returns a reference
>> +* to it.
>> +*
>> +* Return: On success returns a reference to an unique thermal zone with
>> +* matching device node, an ERR_PTR otherwise (-EINVAL for invalid
>> +* paramenters, -ENODEV for not found).
>> +*/
>> +struct thermal_zone_device *
>> +thermal_zone_get_zone_by_node(struct device_node *node)
>> +{
>> +	struct thermal_zone_device *pos = NULL, *ref = ERR_PTR(-ENODEV);
>> +	bool found = false;
>> +
>> +	if (!node)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	mutex_lock(&thermal_list_lock);
>> +	list_for_each_entry(pos, &thermal_tz_list, node)
>> +		if (node == pos->np) {
>> +			ref = pos;
>> +			found = true;
>> +			break;
>> +		}
>> +	mutex_unlock(&thermal_list_lock);
>> +
>> +	return ref;
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
>> +
>>  #ifdef CONFIG_NET
>>  static const struct genl_multicast_group thermal_event_mcgrps[] = {
>>  	{ .name = THERMAL_GENL_MCAST_GROUP_NAME, },
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index f7e11c7..288d272 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -162,6 +162,7 @@ struct thermal_zone_device {
>>  	int id;
>>  	char type[THERMAL_NAME_LENGTH];
>>  	struct device device;
>> +	struct device_node *np;
>>  	struct thermal_attr *trip_temp_attrs;
>>  	struct thermal_attr *trip_type_attrs;
>>  	struct thermal_attr *trip_hyst_attrs;
>> @@ -286,6 +287,8 @@ thermal_of_cooling_device_register(struct device_node *np, char *, void *,
>>  				   const struct thermal_cooling_device_ops *);
>>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
>> +struct thermal_zone_device *
>> +thermal_zone_get_zone_by_node(struct device_node *node);
>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp);
>>  
>>  int get_tz_trend(struct thermal_zone_device *, int);
>>
> 
> 
