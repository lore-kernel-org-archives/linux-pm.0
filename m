From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] thermal: dove: convert to a thermal OF sensor
 device
Date: Mon, 13 Mar 2017 14:31:42 +0530
Message-ID: <c22ff77f-57f3-93cd-acb9-2bad21a82d67@ti.com>
References: <E1cn8qH-0002v6-SE@rmk-PC.armlinux.org.uk>
 <08ea53ed-d7be-2206-57f4-65c06d5e4a40@ti.com>
 <20170313082109.GY21222@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170313082109.GY21222-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On Monday 13 March 2017 01:51 PM, Russell King - ARM Linux wrote:
> On Mon, Mar 13, 2017 at 10:57:20AM +0530, Keerthy wrote:
>>
>>
>> On Monday 13 March 2017 12:37 AM, Russell King wrote:
>>> Convert the dove thermal infrastructure to an OF sensor device, and add
>>> the thermal zones for the SoC, with a critical trip point of 120°C.
>>> This allows us to specify thermal zones and couple them to cooling
>>> devices in DT.
>>>
>>> Signed-off-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
>>> ---
>>> arch/arm/boot/dts/dove.dtsi    | 17 +++++++++++++++++
>>> drivers/thermal/dove_thermal.c | 33 +++++++++++++++++++++++++--------
>>> 2 files changed, 42 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
>>> index 698d58cea20d..40fb98687230 100644
>>> --- a/arch/arm/boot/dts/dove.dtsi
>>> +++ b/arch/arm/boot/dts/dove.dtsi
>>> @@ -455,6 +455,7 @@
>>> 				};
>>>
>>> 				thermal: thermal-diode@001c {
>>> +					#thermal-sensor-cells = <0>;
>>> 					compatible = "marvell,dove-thermal";
>>> 					reg = <0x001c 0x0c>, <0x005c 0x08>;
>>> 				};
>>> @@ -800,4 +801,20 @@
>>> 			};
>>> 		};
>>> 	};
>>> +
>>> +	thermal-zones {
>>> +		soc-thermal {
>>> +			polling-delay-passive = <250>; /* ms */
>>> +			polling-delay = <1000>; /* ms */
>>> +			thermal-sensors = <&thermal>;
>>> +
>>> +			soc_trips: trips {
>>> +				soc_trip_crit: soc-crit {
>>> +					temperature = <120000>; /* °mC */
>>> +					hysteresis = <2000>; /* °mC */
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> };
>>> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
>>> index a0bc9de42553..51b1a9e78576 100644
>>> --- a/drivers/thermal/dove_thermal.c
>>> +++ b/drivers/thermal/dove_thermal.c
>>> @@ -46,6 +46,7 @@
>>> struct dove_thermal_priv {
>>> 	void __iomem *sensor;
>>> 	void __iomem *control;
>>> +	struct device *dev;
>>> };
>>>
>>> static int dove_init_sensor(const struct dove_thermal_priv *priv)
>>> @@ -92,17 +93,15 @@ static int dove_init_sensor(const struct dove_thermal_priv *priv)
>>> 	return 0;
>>> }
>>>
>>> -static int dove_get_temp(struct thermal_zone_device *thermal,
>>> -			  int *temp)
>>> +static int dove_of_get_temp(void *data, int *temp)
>>> {
>>> +	struct dove_thermal_priv *priv = data;
>>> 	unsigned long reg;
>>> -	struct dove_thermal_priv *priv = thermal->devdata;
>>>
>>> 	/* Valid check */
>>> 	reg = readl_relaxed(priv->control + PMU_TEMP_DIOD_CTRL1_REG);
>>> 	if ((reg & PMU_TDC1_TEMP_VALID_MASK) == 0x0) {
>>> -		dev_err(&thermal->device,
>>> -			"Temperature sensor reading not valid\n");
>>> +		dev_err(priv->dev, "Temperature sensor reading not valid\n");
>>> 		return -EIO;
>>> 	}
>>>
>>> @@ -118,10 +117,22 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
>>> 	return 0;
>>> }
>>>
>>> +static int dove_get_temp(struct thermal_zone_device *thermal,
>>> +			  int *temp)
>>> +{
>>> +	struct dove_thermal_priv *priv = thermal->devdata;
>>> +
>>> +	return dove_of_get_temp(priv, temp);
>>> +}
>>> +
>>> static struct thermal_zone_device_ops ops = {
>>> 	.get_temp = dove_get_temp,
>>> };
>>>
>>> +static const struct thermal_zone_of_device_ops of_ops = {
>>> +	.get_temp = dove_of_get_temp,
>>> +};
>>> +
>>> static const struct of_device_id dove_thermal_id_table[] = {
>>> 	{ .compatible = "marvell,dove-thermal" },
>>> 	{}
>>> @@ -138,6 +149,8 @@ static int dove_thermal_probe(struct platform_device *pdev)
>>> 	if (!priv)
>>> 		return -ENOMEM;
>>>
>>> +	priv->dev = &pdev->dev;
>>> +
>>> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> 	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
>>> 	if (IS_ERR(priv->sensor))
>>> @@ -154,8 +167,11 @@ static int dove_thermal_probe(struct platform_device *pdev)
>>> 		return ret;
>>> 	}
>>>
>>> -	thermal = thermal_zone_device_register("dove_thermal", 0, 0,
>>> -					       priv, &ops, NULL, 0, 0);
>>> +	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
>>> +						       priv, &of_ops);
>>> +	if (IS_ERR(thermal))
>>> +		thermal = thermal_zone_device_register("dove_thermal", 0, 0,
>>> +						       priv, &ops, NULL, 0, 0);
>>> 	if (IS_ERR(thermal)) {
>>> 		dev_err(&pdev->dev,
>>> 			"Failed to register thermal zone device\n");
>>> @@ -172,7 +188,8 @@ static int dove_thermal_exit(struct platform_device *pdev)
>>> 	struct thermal_zone_device *dove_thermal =
>>> 		platform_get_drvdata(pdev);
>>>
>>> -	thermal_zone_device_unregister(dove_thermal);
>>> +	if (!pdev->dev.of_node)
>>> +		thermal_zone_device_unregister(dove_thermal);
>>
>> Russell,
>>
>> Now that thermal-zones is defined in dove.dtsi do you see any need to call
>> thermal_zone_device_register? Is there a case where in
>> devm_thermal_zone_of_sensor_register is known to fail?
>>
>> If not then we can even get rid of ops, dove_get_temp function.
>
> That's there because I also boot non-DT from time to time, and having
> the thermal driver still register means that I don't have to carry the
> older hwmon implementation of the same around.  However, it can probably
> be dropped for mainline at the expense of an additional small patch
> carried locally.

Okay. If there is still a non-DT case then it makes sense to keep it the 
way it is now and may be add that point in the commit log that there is 
fall back mechanism in place for non-DT.

>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
