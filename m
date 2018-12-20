From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v6 3/4] thermal: tegra: parse sensor id before sensor
 register
Date: Thu, 20 Dec 2018 10:44:07 +0800
Message-ID: <6f511eb9-e3f6-0a23-c0d0-5a866a6ec547@nvidia.com>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <1544780993-20744-4-git-send-email-wni@nvidia.com>
 <20181219012450.GA2842@localhost.localdomain>
 <5c48701f-aafc-2db0-2191-41f169c8f33f@nvidia.com>
 <20181219145732.GA3516@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219145732.GA3516@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 19/12/2018 10:57 PM, Eduardo Valentin wrote:
> On Wed, Dec 19, 2018 at 11:00:10AM +0800, Wei Ni wrote:
>>
>>
>> On 19/12/2018 9:24 AM, Eduardo Valentin wrote:
>>> On Fri, Dec 14, 2018 at 05:49:52PM +0800, Wei Ni wrote:
>>>> Since different platforms may not support all 4
>>>> sensors, so the sensor registration may be failed.
>>>> Add codes to parse dt to find sensor id which
>>>> need to be registered. So that the registration
>>>> can be successful on all platform.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>> ---
>>>>  drivers/thermal/tegra/soctherm.c | 45 ++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>>>> index fd2703c0cfc5..6bee31cd4621 100644
>>>> --- a/drivers/thermal/tegra/soctherm.c
>>>> +++ b/drivers/thermal/tegra/soctherm.c
>>>> @@ -1224,6 +1224,41 @@ static void soctherm_init(struct platform_device *pdev)
>>>>  	tegra_soctherm_throttle(&pdev->dev);
>>>>  }
>>>>  
>>>> +static bool tegra_soctherm_find_sensor_id(unsigned int sensor_id)
>>>> +{
>>>> +	bool ret = false;
>>>> +	struct of_phandle_args sensor_specs;
>>>> +	struct device_node *np, *sensor_np;
>>>> +
>>>> +	np = of_find_node_by_name(NULL, "thermal-zones");
>>>> +	if (!np)
>>>> +		return ret;
>>>> +
>>>> +	for_each_available_child_of_node(np, sensor_np) {
>>>> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
>>>> +						 "#thermal-sensor-cells",
>>>> +						 0, &sensor_specs))
>>>> +			continue;
>>>> +
>>>> +		if (sensor_specs.args_count != 1) {
>>>> +			WARN(sensor_specs.args_count != 1,
>>>> +			     "%s: wrong cells in sensor specifier %d\n",
>>>> +			     sensor_specs.np->name, sensor_specs.args_count);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		if (sensor_specs.args[0] == sensor_id) {
>>>> +			of_node_put(sensor_np);
>>>> +			ret = true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	of_node_put(np);
>>>> +
>>>> +	return ret;
>>>> +}
>>>
>>> So, I am still failing to see why this is really needed. 
>>>
>>> Why can't you simply resolve this with different compatibles?
>>> If the sensor is not present or disabled, the compatible is not, well,
>>> compatible anymore.
>>
>> This driver can support three Tegra chip t124, t132 and t210. And we
>> also support some platforms for every chips. As the description in the
>> commit, different platforms may not support all 4 sensors, so I
>> upstreamed this patch.
> 
> ok.. Which means, all platforms need to have a proper DT that describes
> the correct amount of sensors.

Thanks for your comments.
I thought about it carefully again, and found we doesn't need to change
any codes for this issue.
In the DT, actually the node "thermal-zones{} already describes the
correct sensors, so we doesn't need to add more changes in DT.

> 
>> If we use different compatibles, I think we can't resolve it simply,
>> because we also need to add codes to configure which platform support
>> which sensors, and may add more in the future. If use this patch, we
> 
> There is a very common way of solving this, you can pass .data and grab
> after calling of_node_match(), just like the tegra soc thermal driver
> already does.

Yes, for the driver, we just need to add a new file, something like
tegra210-soctherm.c, to configure a new platform, which can remove the
configuration for the disabled sensor, so that the soctherm driver will
not try to register that sensors anymore.

> 
>> doesn't need to do any more in the future.
> 
> Well, if the patch is needed to add support for different versions of
> your sensor block, then there is no reason why not patching.

Since in current released platforms, they support all 4 sensors, so I
will not send new patches by now.

So please ignore this change.
And will you take other 3 changes?


Thanks.
Wei.

> 
>> Actually in my original change, I just ignore the registration failure
>> to fix this issue, it will not affect loading driver, but as Daniel's
>> comment, it's not better to ignore, so I followed his comment to refer
> 
> It is not good to ignore. The correct thing to do here is for tegra to
> have correct DT entries for each sensor block version, to correctly
> represent the amount of sensors present in the RTL, then you reflect
> that in device driver using compatible. This way you wont need to ignore
> failures, and you will support the correct amount of sensors for each
> block version.
> 
>> the QORIQ thermal driver to get the sensor id.
>>
> 
> I am not sure that is a good example to follow.
> 
>> Thanks.
>> Wei.
>>
>>>
>>>> +
>>>>  static const struct of_device_id tegra_soctherm_of_match[] = {
>>>>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>>>>  	{
>>>> @@ -1365,13 +1400,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>>>>  		zone->sg = soc->ttgs[i];
>>>>  		zone->ts = tegra;
>>>>  
>>>> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
>>>> +			continue;
>>>> +
>>>>  		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>>>  							 soc->ttgs[i]->id, zone,
>>>>  							 &tegra_of_thermal_ops);
>>>>  		if (IS_ERR(z)) {
>>>>  			err = PTR_ERR(z);
>>>> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>>>> -				err);
>>>> +			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
>>>> +				soc->ttgs[i]->name, err);
>>>>  			goto disable_clocks;
>>>>  		}
>>>>  
>>>> @@ -1434,6 +1472,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>>>>  		struct thermal_zone_device *tz;
>>>>  
>>>>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
>>>> +		if (!tz)
>>>> +			continue;
>>>> +
>>>>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>>>>  		if (err) {
>>>>  			dev_err(&pdev->dev,
>>>> -- 
>>>> 2.7.4
>>>>
