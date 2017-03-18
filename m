From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [10/15] power: supply: bq24190_charger: Use extcon to determine
 ilimit, 5v boost
Date: Sat, 18 Mar 2017 15:42:33 +0100
Message-ID: <7c95dcef-b93f-0f71-8f1c-13f1329eb64d@redhat.com>
References: <20170318071019.4561-7-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdCRPgN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Mar 2017 11:36:13 -0400
In-Reply-To: <20170318071019.4561-7-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi,

On 18-03-17 08:10, Liam Breck wrote:
> Tony, question for you below...
>
> On Fri, 17 Mar 2017 10:55:22 +0100, Hans de Goede wrote:
>
>> Add support for monitoring an extcon device with SDP/CDP/DCP and HOST
>
> insert: USB X.0
>
>> cables and adjust ilimit and enable/disable the 5v boost converter
>> accordingly. This is necessary on systems where the PSEL pin is hardwired
>> high and ILIM needs to be set by software based on the detected charger
>> type.
>
> This description is rather thin for the extent of the changes. What specific systems
> require this?

Systems which use a variant with a PSEL pin where the PSEL pin is hardwired
high.

> What drivers generate the event?

The driver which registers the extcon with the name "extcon_name"
the bq24190_charger driver really does not need to know more.
In the use-case we are talking about now the driver is
the new extcon-cht-wc.c driver which is part of the patch-set
as I initially posted it.

> Also provide URLs to docs/datasheets.

I've no access to docs / datasheets for the Whiskey Cove PMIC.



>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/Kconfig           |  1 +
>>  drivers/power/supply/bq24190_charger.c | 85 ++++++++++++++++++++++++++++++++++
>>  include/linux/power/bq24190_charger.h  |  1 +
>>  3 files changed, 87 insertions(+)
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index f8b6e64..fd93110 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -442,6 +442,7 @@ config CHARGER_BQ2415X
>>  config CHARGER_BQ24190
>>  	tristate "TI BQ24190 battery charger driver"
>>  	depends on I2C
>> +	depends on EXTCON
>>  	depends on GPIOLIB || COMPILE_TEST
>>  	help
>>  	  Say Y to enable support for the TI BQ24190 battery charger.
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index 82cb33d..03990e2 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -11,10 +11,12 @@
>>  #include <linux/module.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>> +#include <linux/extcon.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/of_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/power_supply.h>
>> +#include <linux/workqueue.h>
>>  #include <linux/gpio.h>
>>  #include <linux/i2c.h>
>>
>> @@ -39,6 +41,8 @@
>>  #define BQ24190_REG_POC_WDT_RESET_SHIFT		6
>>  #define BQ24190_REG_POC_CHG_CONFIG_MASK		(BIT(5) | BIT(4))
>>  #define BQ24190_REG_POC_CHG_CONFIG_SHIFT	4
>> +#define BQ24190_REG_POC_CHG_CONFIG_CHARGE	1
>> +#define BQ24190_REG_POC_CHG_CONFIG_OTG		2
>>  #define BQ24190_REG_POC_SYS_MIN_MASK		(BIT(3) | BIT(2) | BIT(1))
>>  #define BQ24190_REG_POC_SYS_MIN_SHIFT		1
>>  #define BQ24190_REG_POC_BOOST_LIM_MASK		BIT(0)
>> @@ -152,6 +156,9 @@ struct bq24190_dev_info {
>>  	struct power_supply		*charger;
>>  	struct power_supply		*battery;
>>  	struct bq24190_platform_data	*pdata;
>> +	struct extcon_dev		*extcon;
>> +	struct notifier_block		extcon_nb;
>> +	struct work_struct		extcon_work;
>>  	char				model_name[I2C_NAME_SIZE];
>>  	kernel_ulong_t			model;
>>  	struct mutex			f_reg_lock;
>> @@ -167,6 +174,11 @@ struct bq24190_dev_info {
>>   * number at that index in the array is the real-world value that it
>>   * represents.
>>   */
>> +
>> +/* REG00[2:0] (IINLIM) in uAh */
>> +static const int bq24190_iinlim_values[] = {
>> +	100000, 150000, 500000, 900000, 1200000, 1500000, 2000000, 3000000 };
>> +
>>  /* REG02[7:2] (ICHG) in uAh */
>>  static const int bq24190_ccc_ichg_values[] = {
>>  	 512000,  576000,  640000,  704000,  768000,  832000,  896000,  960000,
>> @@ -1290,6 +1302,61 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>
>> +static void bq24190_extcon_work(struct work_struct *work)
>> +{
>
> Does this need pm_runtime_get_sync(), etc?
> (See linux-next patches to driver.)

Yes with runtime pm this will need to do a
pm_runtime_get_sync(bdi->Dev) before accessing
the device.



>
>> +	struct bq24190_dev_info *bdi =
>> +		container_of(work, struct bq24190_dev_info, extcon_work);
>> +	int ret, iinlim = 0;
>> +
>> +	if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) == 1)
>> +		iinlim = 500000;
>> +	else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_CDP) == 1 ||
>> +		 extcon_get_state(bdi->extcon, EXTCON_CHG_USB_ACA) == 1)
>> +		iinlim = 1500000;
>> +	else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_DCP) == 1)
>> +		iinlim = 2000000;
>> +
>> +	if (iinlim) {
>> +		ret = bq24190_set_field_val(bdi, BQ24190_REG_ISC,
>> +				BQ24190_REG_ISC_IINLIM_MASK,
>> +				BQ24190_REG_ISC_IINLIM_SHIFT,
>> +				bq24190_iinlim_values,
>> +				ARRAY_SIZE(bq24190_iinlim_values),
>> +				iinlim);
>> +		if (ret)
>> +			dev_err(bdi->dev, "Can't set IINLIM: %d\n", ret);
>> +	}
>> +
>> +	/*
>> +	 * If no charger has been detected and host mode is requested, activate
>> +	 * the 5V boost converter, otherwise deactivate it.
>> +	 */
>> +	if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) == 1) {
>> +		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> +					 BQ24190_REG_POC_CHG_CONFIG_MASK,
>> +					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> +					 BQ24190_REG_POC_CHG_CONFIG_OTG);
>> +	} else {
>> +		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> +					 BQ24190_REG_POC_CHG_CONFIG_MASK,
>> +					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> +					 BQ24190_REG_POC_CHG_CONFIG_CHARGE);
>> +	}
>> +	if (ret)
>> +		dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", ret);
>> +}
>> +
>> +static int bq24190_extcon_event(struct notifier_block *nb, unsigned long event,
>> +				void *param)
>> +{
>> +	struct bq24190_dev_info *bdi =
>> +		container_of(nb, struct bq24190_dev_info, extcon_nb);
>> +
>> +	schedule_work(&bdi->extcon_work);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>  static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>>  {
>>  	u8 v;
>> @@ -1375,6 +1442,12 @@ static int bq24190_probe(struct i2c_client *client,
>>  			return -EPROBE_DEFER;
>>  	}
>>
>> +	if (bdi->pdata && bdi->pdata->extcon_name) {
>
> Verify that extcon_name has an expected value?

The whole idea is that the bq24190 does not need to care about
which extcon driver it is told to use, just that it has to
use *a* extcon driver.

>
>> +		bdi->extcon = extcon_get_extcon_dev(bdi->pdata->extcon_name);
>> +		if (!bdi->extcon)
>> +			return -EPROBE_DEFER;
>
> dev_info() a msg about this linkage, including info about the other side.

dev_info on success I assume, not on PROBE_DEFER, otherwise we will
end up spamming the log quite a lot while modules are loading.



>
>> +	}
>> +
>>  	pm_runtime_enable(dev);
>>  	pm_runtime_resume(dev);
>>
>> @@ -1423,6 +1496,18 @@ static int bq24190_probe(struct i2c_client *client,
>>  		goto out4;
>>  	}
>>
>> +	if (bdi->extcon) {
>> +		INIT_WORK(&bdi->extcon_work, bq24190_extcon_work);
>> +		bdi->extcon_nb.notifier_call = bq24190_extcon_event;
>> +		ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
>> +						    &bdi->extcon_nb);
>> +		if (ret)
>> +			goto out4;
>> +
>> +		/* Sync initial cable state */
>> +		schedule_work(&bdi->extcon_work);
>> +	}
>> +
>>  	return 0;
>>
>>  out4:
>> diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/bq24190_charger.h
>> index 02d248b..909c5b9 100644
>> --- a/include/linux/power/bq24190_charger.h
>> +++ b/include/linux/power/bq24190_charger.h
>> @@ -13,6 +13,7 @@
>>
>>  struct bq24190_platform_data {
>>  	bool no_register_reset;
>> +	const char *extcon_name;
>>  	int (*get_ext_bat_property)(enum power_supply_property prop,
>>  				    union power_supply_propval *val);
>>  };
>

Regards,

Hans
