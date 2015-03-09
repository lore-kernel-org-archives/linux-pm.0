From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v5 1/2] power: rt5033_charger: Add RT5033 charger device
 driver
Date: Mon, 09 Mar 2015 12:46:03 +0900
Message-ID: <54FD177B.1050200@samsung.com>
References: <1425864191-4121-1-git-send-email-beomho.seo@samsung.com>
 <1425864191-4121-2-git-send-email-beomho.seo@samsung.com>
 <20150309015020.GA941@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50211 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbCIDqK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2015 23:46:10 -0400
In-reply-to: <20150309015020.GA941@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lee.jones@linaro.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>

On 03/09/2015 10:50 AM, Sebastian Reichel wrote:
> Hi Beomho,
> 
> On Mon, Mar 09, 2015 at 10:23:10AM +0900, Beomho Seo wrote:
>> This patch add device driver of Richtek RT5033 PMIC. The driver support
>> switching charger. rt5033 charger provide three charging mode.
>> Three charging mode are pre charge mode, fast cahrge mode and constant voltage
>> mode. They are have vary charge rate, charge parameters. The charge parameters
>> can be controlled by i2c interface.
> 
> Driver looks mostly ok, but I have some comments [inline].
> 
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> Changes in v5
>> - none.
>> Changes in v4
>> - Change power supply type to POWER_SUPPLY_TYPE_MAINS.
>> Changes in v3
>> Changes in v2
>> - none
>>
>>  drivers/power/Kconfig          |    8 +
>>  drivers/power/Makefile         |    1 +
>>  drivers/power/rt5033_charger.c |  485 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 494 insertions(+)
>>  create mode 100644 drivers/power/rt5033_charger.c
>>
>> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
>> index 27b751b..67e9af7 100644
>> --- a/drivers/power/Kconfig
>> +++ b/drivers/power/Kconfig
>> @@ -418,6 +418,14 @@ config BATTERY_RT5033
>>  	  The fuelgauge calculates and determines the battery state of charge
>>  	  according to battery open circuit voltage.
>>  
>> +config CHARGER_RT5033
>> +	tristate "RT5033 battery charger support"
>> +	depends on MFD_RT5033
>> +	help
>> +	  This adds support for battery charger in Richtek RT5033 PMIC.
>> +	  The device supports pre-charge mode, fast charge mode and
>> +	  constant voltage mode.
>> +
>>  source "drivers/power/reset/Kconfig"
>>  
>>  endif # POWER_SUPPLY
>> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
>> index 36f9e0d..c5d72e0 100644
>> --- a/drivers/power/Makefile
>> +++ b/drivers/power/Makefile
>> @@ -59,6 +59,7 @@ obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>>  obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
>>  obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
>>  obj-$(CONFIG_POWER_AVS)		+= avs/
>> +obj-$(CONFIG_POWER_RT5033)	+= rt5033_charger.o
> 
> this should be 
> 
> obj-$(CONFIG_CHARGER_RT5033) += rt5033_charger.o
> 
> according to your Kconfig patch. How did you test it actually?
> 

Sorry, My mistake. This patch have been tested on my board.
I will double-check before send patch set.

>>  obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
>>  obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
>>  obj-$(CONFIG_POWER_RESET)	+= reset/
>> diff --git a/drivers/power/rt5033_charger.c b/drivers/power/rt5033_charger.c
>> new file mode 100644
>> index 0000000..7f8f6c3
>> --- /dev/null
>> +++ b/drivers/power/rt5033_charger.c
>>
>> [...]
>>
>> +static int rt5033_get_charger_current(struct rt5033_charger *charger,
>> +		enum power_supply_property psp)
>> +{
>> +	struct regmap *regmap = charger->rt5033->regmap;
>> +	unsigned int state, reg_data, data;
>> +
>> +	if (psp == POWER_SUPPLY_PROP_CURRENT_MAX)
>> +		return RT5033_CHG_MAX_CURRENT;
> 
> drop this psp check and the psp parameter to this function, so that
> the function only takes care of the current current.
> 

OK. I will remove above lines.

>> +	regmap_read(regmap, RT5033_REG_CHG_CTRL5, &reg_data);
>> +
>> +	state = (reg_data >> RT5033_CHGCTRL5_ICHG_SHIFT) & 0xf;
>> +
>> +	if (state > RT5033_CHG_MAX_CURRENT)
>> +		state = RT5033_CHG_MAX_CURRENT;
>> +
>> +	data = state * 100 + 700;
>> +
>> +	return data;
>> +}
>> +
>> +static int rt5033_get_charge_voltage(struct rt5033_charger *charger,
>> +		enum power_supply_property psp)
>> +{
>> +	struct regmap *regmap = charger->rt5033->regmap;
>> +	unsigned int state, reg_data, data;
>> +
>> +	if (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX)
>> +		return RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX;
> 
> drop this psp check and the psp parameter to this function, so that
> the function only takes care of the current voltage.
> 

OK. I will remove above lines.

>> +	regmap_read(regmap, RT5033_REG_CHG_CTRL2, &reg_data);
>> +
>> +	state = reg_data >> 2;
>> +
>> +	data = RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN +
>> +		RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM * state;
>> +
>> +	if (data > RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX)
>> +		data = RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX;
>> +
>> +	return data;
>> +}
>>
>> [...]
>>
>> +
>> +static enum power_supply_property rt5033_charger_props[] = {
>> +	POWER_SUPPLY_PROP_STATUS,
>> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
>> +	POWER_SUPPLY_PROP_CURRENT_NOW,
>> +	POWER_SUPPLY_PROP_CURRENT_MAX,
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>> +	POWER_SUPPLY_PROP_MODEL_NAME,
>> +	POWER_SUPPLY_PROP_MANUFACTURER,
>> +};
>> +
>> +static int rt5033_charger_get_property(struct power_supply *psy,
>> +			enum power_supply_property psp,
>> +			union power_supply_propval *val)
>> +{
>> +	struct rt5033_charger *charger = container_of(psy,
>> +			struct rt5033_charger, psy);
>> +	int ret = 0;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		val->intval = rt5033_get_charger_state(charger);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
>> +		val->intval = rt5033_get_charger_type(charger);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
>> +		val->intval = rt5033_get_charger_current(charger, psp);
>> +		break;
> 
> remove the special handling of POWER_SUPPLY_PROP_CURRENT_MAX in 
> rt5033_get_charger_current() and do it like this:
> 
> case POWER_SUPPLY_PROP_CURRENT_NOW:
>     val->intval = rt5033_get_charger_current(charger);
>     break;
> case POWER_SUPPLY_PROP_CURRENT_MAX:
>     val->intval = RT5033_CHG_MAX_CURRENT;
>     break;
> 

OK. I will change comply with your comment.

>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> +		val->intval = rt5033_get_charge_voltage(charger, psp);
>> +		break;
> 
> same as current handling:
> 
> case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>     val->intval = rt5033_get_charge_voltage(charger);
>     break;
> case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>     val->intval = RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX;
>     break;
> 

Ditto.

>> +	case POWER_SUPPLY_PROP_MODEL_NAME:
>> +		val->strval = RT5033_CHARGER_MODEL;
>> +		break;
>> +	case POWER_SUPPLY_PROP_MANUFACTURER:
>> +		val->strval = RT5033_MANUFACTURER;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>>
>> [...]
>>
>> +static int rt5033_charger_probe(struct platform_device *pdev)
>> +{
>> +	struct rt5033_charger *charger;
>> +	struct rt5033_dev *rt5033 = dev_get_drvdata(pdev->dev.parent);
>> +	int ret;
>> +
>> +	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
>> +	if (!charger)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, charger);
>> +	charger->dev = &pdev->dev;
>> +	charger->rt5033 = rt5033;
>> +
>> +	charger->chg = rt5033_charger_dt_init(pdev);
>> +	if (IS_ERR_OR_NULL(charger->chg))
>> +		return -ENODEV;
>> +
>> +	ret = rt5033_charger_reg_init(charger);
>> +	if (ret)
>> +		return ret;
>> +
>> +	charger->psy.name = "rt5033-charger",
>> +	charger->psy.type = POWER_SUPPLY_TYPE_MAINS,
>> +	charger->psy.properties = rt5033_charger_props,
>> +	charger->psy.num_properties = ARRAY_SIZE(rt5033_charger_props),
>> +	charger->psy.get_property = rt5033_charger_get_property,
>> +
>> +	ret = power_supply_register(&pdev->dev, &charger->psy);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to register power supply\n");
>> +		return ret;
>> +	}
> 
> We have devm_power_supply_register() now, which would result in
> complete removal of the rt5033_charger_remove() function :)
> 

OK, I will change comply with your comment.

>> +	return 0;
>> +}
>> +
>> +static int rt5033_charger_remove(struct platform_device *pdev)
>> +{
>> +	struct rt5033_charger *charger = platform_get_drvdata(pdev);
>> +
>> +	power_supply_unregister(&charger->psy);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct platform_device_id rt5033_charger_id[] = {
>> +	{ "rt5033-charger", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, rt5033_charger_id);
>> +
>> +static struct platform_driver rt5033_charger_driver = {
>> +	.driver = {
>> +		.name = "rt5033-charger",
>> +	},
>> +	.probe = rt5033_charger_probe,
>> +	.remove = rt5033_charger_remove,
>> +	.id_table = rt5033_charger_id,
>> +};
>> +module_platform_driver(rt5033_charger_driver);
>> +
>> +MODULE_DESCRIPTION("Richtek RT5033 charger driver");
>> +MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
>> +MODULE_LICENSE("GPL");
> 
> This should be 
> 
> MODULE_LICENSE("GPL v2");
> 
> -- Sebastian
> 

Thanks your comment.
I will change this patch as soon as I possibly can.

Best regards,
Beomho Seo
