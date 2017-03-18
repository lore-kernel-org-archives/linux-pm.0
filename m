From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [08/15] power: supply: bq24190_charger: Add support for external
 fuel gauge
Date: Sat, 18 Mar 2017 15:31:35 +0100
Message-ID: <a9286000-751f-dace-2408-f0389a6f44ac@redhat.com>
References: <20170318071019.4561-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdCROcM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Mar 2017 10:32:12 -0400
In-Reply-To: <20170318071019.4561-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi,

On 18-03-17 08:10, Liam Breck wrote:
> On Fri, 17 Mar 2017 10:55:20 +0100, Hans de Goede wrote:
>
>> Some platforms with a bq24190_charger have an external fuel gauge which
>> makes it possible to reliably report battery (dis)charge state, at
>> support for this by adding an optional get_ext_bat_property callback
>> to the platform_data and using this if the platform provides it.
>
> Please do not pollute the charger with fuel-gauge functionality; use the gauge driver directly.

That is not how the userspace ABI works, the userspace ABI says one
battery one power_supply device, so we need to combine the data from
the 2 sources.

> And calling into a mystery module with a pointer from platform-data is scary! St. Patrick's
> Day is wrong for this; try April Fool's or Halloween ;-)

Since we control both the caller and the callee I fail to see how
this is scary in any way.

Regards,

Hans


>
>> By convention the callback will return -ENXIO when it is not ready yet,
>> or the driver providing it has been unbound from its device. Since it
>> returns the same error when unbound it cannot return -EPROBE_DEFER
>> as that is not a valid errno.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 41 +++++++++++++++++++++++++++++++---
>>  include/linux/power/bq24190_charger.h  |  4 ++++
>>  2 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index 9014dee..9fe69a5 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -1111,7 +1111,10 @@ static int bq24190_battery_get_property(struct power_supply *psy,
>>  		ret = 0;
>>  		break;
>>  	default:
>> -		ret = -ENODATA;
>> +		if (bdi->pdata && bdi->pdata->get_ext_bat_property)
>> +			ret = bdi->pdata->get_ext_bat_property(psp, val);
>> +		else
>> +			ret = -ENODATA;
>>  	}
>>
>>  	pm_runtime_put_sync(bdi->dev);
>> @@ -1168,12 +1171,31 @@ static enum power_supply_property bq24190_battery_properties[] = {
>>  	POWER_SUPPLY_PROP_TECHNOLOGY,
>>  	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
>>  	POWER_SUPPLY_PROP_SCOPE,
>> +	/* Begin of extended battery properties */
>> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
>> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
>> +	POWER_SUPPLY_PROP_CURRENT_NOW,
>> +	POWER_SUPPLY_PROP_CURRENT_AVG,
>> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>> +	POWER_SUPPLY_PROP_CHARGE_FULL,
>> +	POWER_SUPPLY_PROP_CHARGE_NOW,
>>  };
>>
>>  static const struct power_supply_desc bq24190_battery_desc = {
>>  	.name			= "bq24190-battery",
>>  	.type			= POWER_SUPPLY_TYPE_BATTERY,
>>  	.properties		= bq24190_battery_properties,
>> +	.num_properties		= 6,
>> +	.get_property		= bq24190_battery_get_property,
>> +	.set_property		= bq24190_battery_set_property,
>> +	.property_is_writeable	= bq24190_battery_property_is_writeable,
>> +};
>> +
>> +static const struct power_supply_desc bq24190_ext_battery_desc = {
>> +	.name			= "bq24190-battery",
>> +	.type			= POWER_SUPPLY_TYPE_BATTERY,
>> +	.properties		= bq24190_battery_properties,
>>  	.num_properties		= ARRAY_SIZE(bq24190_battery_properties),
>>  	.get_property		= bq24190_battery_get_property,
>>  	.set_property		= bq24190_battery_set_property,
>> @@ -1336,6 +1358,15 @@ static int bq24190_probe(struct i2c_client *client,
>>  		return -EINVAL;
>>  	}
>>
>> +	if (bdi->pdata && bdi->pdata->get_ext_bat_property) {
>> +		union power_supply_propval val;
>> +
>> +		/* Check external fuel gauge is ready */
>> +		ret = bdi->pdata->get_ext_bat_property(0, &val);
>> +		if (ret == -ENXIO)
>> +			return -EPROBE_DEFER;
>> +	}
>> +
>>  	pm_runtime_enable(dev);
>>  	pm_runtime_resume(dev);
>>
>> @@ -1357,8 +1388,12 @@ static int bq24190_probe(struct i2c_client *client,
>>  	}
>>
>>  	battery_cfg.drv_data = bdi;
>> -	bdi->battery = power_supply_register(dev, &bq24190_battery_desc,
>> -						&battery_cfg);
>> +	if (bdi->pdata && bdi->pdata->get_ext_bat_property)
>> +		bdi->battery = power_supply_register(dev,
>> +				    &bq24190_ext_battery_desc, &battery_cfg);
>> +	else
>> +		bdi->battery = power_supply_register(dev,
>> +				    &bq24190_battery_desc, &battery_cfg);
>>  	if (IS_ERR(bdi->battery)) {
>>  		dev_err(dev, "Can't register battery\n");
>>  		ret = PTR_ERR(bdi->battery);
>> diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/bq24190_charger.h
>> index 8d918cb..02d248b 100644
>> --- a/include/linux/power/bq24190_charger.h
>> +++ b/include/linux/power/bq24190_charger.h
>> @@ -9,8 +9,12 @@
>>  #ifndef _BQ24190_CHARGER_H_
>>  #define _BQ24190_CHARGER_H_
>>
>> +#include <linux/power_supply.h>
>> +
>>  struct bq24190_platform_data {
>>  	bool no_register_reset;
>> +	int (*get_ext_bat_property)(enum power_supply_property prop,
>> +				    union power_supply_propval *val);
>>  };
>>
>>  #endif
>
