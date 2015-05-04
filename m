From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH] power: max17042_battery: add HEALTH and TEMP_* properties
 support
Date: Tue, 05 May 2015 00:12:34 +0900
Message-ID: <55478C62.6080307@gmail.com>
References: <1430777920-16348-1-git-send-email-ramakrishna.pallala@intel.com> <55478533.9050109@gmail.com> <D854C92F57B1B347B57E531E78D05EAD578252A3@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36400 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbEDPMj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 11:12:39 -0400
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD578252A3@BGSMSX104.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>

W dniu 05.05.2015 o 00:07, Pallala, Ramakrishna pisze:
> Hi,
> 
>> W dniu 05.05.2015 o 07:18, Ramakrishna Pallala pisze:
>>> This patch adds the support for following battery properties to
>>> max17042 fuel gauge driver.
>>
>> The patchset itself looks good. Only minor nits and a question at the end.
>>
>>>
>>> POWER_SUPPLY_PROP_TEMP_ALERT_MIN
>>> POWER_SUPPLY_PROP_TEMP_ALERT_MAX
>>> POWER_SUPPLY_PROP_TEMP_MIN
>>> POWER_SUPPLY_PROP_TEMP_MAX
>>> POWER_SUPPLY_PROP_HEALTH
>>>
>>> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>>> ---
>>>  drivers/power/max17042_battery.c       |  190
>> ++++++++++++++++++++++++++++++--
>>>  include/linux/power/max17042_battery.h |    4 +
>>>  2 files changed, 183 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/power/max17042_battery.c
>>> b/drivers/power/max17042_battery.c
>>> index 6cc5e87..d8f15ce 100644
>>> --- a/drivers/power/max17042_battery.c
>>> +++ b/drivers/power/max17042_battery.c
>>> @@ -63,6 +63,8 @@
>>>  #define dP_ACC_100	0x1900
>>>  #define dP_ACC_200	0x3200
>>>
>>> +#define MAX17042_VMAX_TOLERENCE		50 /* 50 mV */
>>
>> s/TOLERENCE/TOLERANCE/
> Ok..
> 
> [snip]
> 
>>> +
>>> +static int max17042_get_battery_health(struct max17042_chip *chip,
>>> +int *health) {
>>> +	int temp, vavg, vbatt, ret;
>>> +	u32 val;
>>> +
>>> +	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, &val);
>>> +	if (ret < 0)
>>> +		goto health_error;
>>> +
>>> +	/* bits [0-3] unused */
>>> +	vavg = val * 625 / 8;
>>> +	/* Convert to milli volts */
>>
>> s/milli volts/millivolts/
> Ok..
> 
> [snip]
> 
>>> @@ -665,6 +829,8 @@ static const struct power_supply_desc
>> max17042_psy_desc = {
>>>  	.name		= "max170xx_battery",
>>>  	.type		= POWER_SUPPLY_TYPE_BATTERY,
>>>  	.get_property	= max17042_get_property,
>>> +	.set_property	= max17042_set_property,
>>> +	.property_is_writeable	= max17042_property_is_writeable,
>>>  	.properties	= max17042_battery_props,
>>>  	.num_properties	= ARRAY_SIZE(max17042_battery_props),
>>>  };
>>> @@ -673,6 +839,8 @@ static const struct power_supply_desc
>> max17042_no_current_sense_psy_desc = {
>>>  	.name		= "max170xx_battery",
>>>  	.type		= POWER_SUPPLY_TYPE_BATTERY,
>>>  	.get_property	= max17042_get_property,
>>> +	.set_property	= max17042_set_property,
>>> +	.property_is_writeable	= max17042_property_is_writeable,
>>>  	.properties	= max17042_battery_props,
>>>  	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
>>>  };
>>> diff --git a/include/linux/power/max17042_battery.h
>>> b/include/linux/power/max17042_battery.h
>>> index cf112b4..89ca4a8 100644
>>> --- a/include/linux/power/max17042_battery.h
>>> +++ b/include/linux/power/max17042_battery.h
>>> @@ -215,6 +215,10 @@ struct max17042_platform_data {
>>>  	 * the datasheet although it can be changed by board designers.
>>>  	 */
>>>  	unsigned int r_sns;
>>> +	int         vmin;	/* in milli volts */
>>> +	int         vmax;	/* in milli volts */
>>
>> s/milli volts/millivolts/
> Ok..
> 
>>> +	int         temp_min;	/* in tenths of degree Celsius */
>>> +	int         temp_max;	/* in tenths of degree Celsius */
>>>  };
>>>
>>>  #endif /* __MAX17042_BATTERY_H_ */
>>
>> The question is who will set these values in pdata? We do not have board files
>> anymore so I think you should extend the DT bindings so this could be used.
> 
> In our platform we don't use device tree...the enumeration is based on SFI model and
> there is board file in our platform.
> 
> To complete the platforms which use device tree, I can add of_property_read_u32() calls for
> new pdata variables and submit the patch.

Oh... I did not expect that these Maxim PMICs/MUICs are used outside of
ARM world. Anyway it is fine then:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Thanks for the patch.

Best regards,
Krzysztof

