From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/7] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Thu, 23 Mar 2017 09:31:40 +0100
Message-ID: <8ba709ce-f9f0-e52c-7632-c881509db28c@redhat.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-4-hdegoede@redhat.com>
 <CAKvHMgRrH4GVvMkO-7HDRGtV8gs1mjiwdq7S4P74j=KJwWqOdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932627AbdCWIjj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 04:39:39 -0400
In-Reply-To: <CAKvHMgRrH4GVvMkO-7HDRGtV8gs1mjiwdq7S4P74j=KJwWqOdw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

Hi,

On 22-03-17 19:50, Liam Breck wrote:
> On Wed, Mar 22, 2017 at 7:55 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Add support for monitoring an extcon device with USB SDP/CDP/DCP and HOST
>> cables and adjust ilimit and enable/disable the 5V boost converter
>> accordingly. This is necessary on systems where the PSEL pin is hardwired
>> high and ILIM needs to be set by software based on the detected charger
>> type, as well as on systems where the 5V boost converter is used, as
>> that always needs to be enabled from software.
>>
>> Cc: Liam Breck <kernel@networkimprov.net>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Sebastian Reichel <sre@kernel.org>
>> ---
>> Changes in v2:
>> -Use a device-property for extcon-name instead of platform_data
>> -Delay 300ms before applying the extcon detected charger-type to iinlim
>>  (see the added comment for why this is done)
>> ---
>>  drivers/power/supply/Kconfig           |   1 +
>>  drivers/power/supply/bq24190_charger.c | 107 +++++++++++++++++++++++++++++++++
>>  2 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index f8b6e64..fd93110 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -442,6 +442,7 @@ config CHARGER_BQ2415X
>>  config CHARGER_BQ24190
>>         tristate "TI BQ24190 battery charger driver"
>>         depends on I2C
>> +       depends on EXTCON
>>         depends on GPIOLIB || COMPILE_TEST
>>         help
>>           Say Y to enable support for the TI BQ24190 battery charger.
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index d74c8cc..7a2a496 100644
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
>> @@ -36,6 +38,8 @@
>>  #define BQ24190_REG_POC_WDT_RESET_SHIFT                6
>>  #define BQ24190_REG_POC_CHG_CONFIG_MASK                (BIT(5) | BIT(4))
>>  #define BQ24190_REG_POC_CHG_CONFIG_SHIFT       4
>> +#define BQ24190_REG_POC_CHG_CONFIG_CHARGE      1
>> +#define BQ24190_REG_POC_CHG_CONFIG_OTG         2
>>  #define BQ24190_REG_POC_SYS_MIN_MASK           (BIT(3) | BIT(2) | BIT(1))
>>  #define BQ24190_REG_POC_SYS_MIN_SHIFT          1
>>  #define BQ24190_REG_POC_BOOST_LIM_MASK         BIT(0)
>> @@ -148,6 +152,9 @@ struct bq24190_dev_info {
>>         struct device                   *dev;
>>         struct power_supply             *charger;
>>         struct power_supply             *battery;
>> +       struct extcon_dev               *extcon;
>> +       struct notifier_block           extcon_nb;
>> +       struct delayed_work             extcon_work;
>>         char                            model_name[I2C_NAME_SIZE];
>>         bool                            initialized;
>>         bool                            irq_event;
>> @@ -164,6 +171,11 @@ struct bq24190_dev_info {
>>   * number at that index in the array is the real-world value that it
>>   * represents.
>>   */
>> +
>> +/* REG00[2:0] (IINLIM) in uAh */
>> +static const int bq24190_iinlim_values[] = {
>> +       100000, 150000, 500000, 900000, 1200000, 1500000, 2000000, 3000000 };
>> +
>>  /* REG02[7:2] (ICHG) in uAh */
>>  static const int bq24190_ccc_ichg_values[] = {
>>          512000,  576000,  640000,  704000,  768000,  832000,  896000,  960000,
>> @@ -1277,6 +1289,78 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>>         return IRQ_HANDLED;
>>  }
>>
>> +static void bq24190_extcon_work(struct work_struct *work)
>> +{
>> +       struct bq24190_dev_info *bdi =
>> +               container_of(work, struct bq24190_dev_info, extcon_work.work);
>> +       int ret, iinlim = 0;
>> +
>> +       ret = pm_runtime_get_sync(bdi->dev);
>> +       if (ret < 0) {
>> +               dev_err(bdi->dev, "Error getting runtime-pm ref: %d\n", ret);
>> +               return;
>> +       }
>> +
>> +       if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) == 1)
>> +               iinlim = 500000;
>> +       else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_CDP) == 1 ||
>> +                extcon_get_state(bdi->extcon, EXTCON_CHG_USB_ACA) == 1)
>> +               iinlim = 1500000;
>> +       else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_DCP) == 1)
>> +               iinlim = 2000000;
>> +
>> +       if (iinlim) {
>> +               ret = bq24190_set_field_val(bdi, BQ24190_REG_ISC,
>> +                               BQ24190_REG_ISC_IINLIM_MASK,
>> +                               BQ24190_REG_ISC_IINLIM_SHIFT,
>> +                               bq24190_iinlim_values,
>> +                               ARRAY_SIZE(bq24190_iinlim_values),
>> +                               iinlim);
>> +               if (ret)
>> +                       dev_err(bdi->dev, "Can't set IINLIM: %d\n", ret);
>> +       }
>> +
>> +       /*
>> +        * If no charger has been detected and host mode is requested, activate
>> +        * the 5V boost converter, otherwise deactivate it.
>> +        */
>> +       if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) == 1) {
>> +               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> +                                        BQ24190_REG_POC_CHG_CONFIG_MASK,
>> +                                        BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> +                                        BQ24190_REG_POC_CHG_CONFIG_OTG);
>> +       } else {
>> +               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> +                                        BQ24190_REG_POC_CHG_CONFIG_MASK,
>> +                                        BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> +                                        BQ24190_REG_POC_CHG_CONFIG_CHARGE);
>> +       }
>> +       if (ret)
>> +               dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", ret);
>> +
>> +       pm_runtime_mark_last_busy(bdi->dev);
>> +       pm_runtime_put_autosuspend(bdi->dev);
>> +}
>> +
>> +static int bq24190_extcon_event(struct notifier_block *nb, unsigned long event,
>> +                               void *param)
>> +{
>> +       struct bq24190_dev_info *bdi =
>> +               container_of(nb, struct bq24190_dev_info, extcon_nb);
>> +
>> +       /*
>> +        * The Power-Good detection may take up to 220ms, sometimes
>> +        * the external charger detection is quicker, and the bq24190 will
>> +        * reset to iinlim based on its own charger detection (which is not
>> +        * hooked up when using external charger detection) resulting in
>> +        * a too low default 500mA iinlim. Delay applying the extcon value
>> +        * for 300ms to avoid this.
>> +        */
>> +       queue_delayed_work(system_wq, &bdi->extcon_work, msecs_to_jiffies(300));
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
>>  static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>>  {
>>         u8 v;
>> @@ -1314,6 +1398,7 @@ static int bq24190_probe(struct i2c_client *client,
>>         struct device *dev = &client->dev;
>>         struct power_supply_config charger_cfg = {}, battery_cfg = {};
>>         struct bq24190_dev_info *bdi;
>> +       const char *name;
>>         int ret;
>>
>>         if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>> @@ -1341,6 +1426,16 @@ static int bq24190_probe(struct i2c_client *client,
>>                 return -EINVAL;
>>         }
>>
>> +       /*
>> +        * The extcon-name property is purely an in kernel interface for
>> +        * x86/ACPI use, DT platforms should get extcon via phandle.
>> +        */
>> +       if (device_property_read_string(dev, "extcon-name", &name) == 0) {
>> +               bdi->extcon = extcon_get_extcon_dev(name);
>> +               if (!bdi->extcon)
>> +                       return -EPROBE_DEFER;
>
> needs
>                 dev_info(bdi->dev, "using extcon device %s\n", name);

Right, I forgot about that v3 coming up.

> I didn't see the device property for preferred charge voltage limit
> from v1 patchset?

I decided to drop that patch, the limit set by the firmware is within
the limits of the LiHV battery it just is not an ideal limit from a
number of charge-cycles the battery will endure pov, but second
guessing the firmware here / doing our own tweaks is in hindsight
a bad idea.

Regards,

Hans




>
>> +       }
>> +
>>         pm_runtime_enable(dev);
>>         pm_runtime_use_autosuspend(dev);
>>         pm_runtime_set_autosuspend_delay(dev, 600);
>> @@ -1391,6 +1486,18 @@ static int bq24190_probe(struct i2c_client *client,
>>                 goto out5;
>>         }
>>
>> +       if (bdi->extcon) {
>> +               INIT_DELAYED_WORK(&bdi->extcon_work, bq24190_extcon_work);
>> +               bdi->extcon_nb.notifier_call = bq24190_extcon_event;
>> +               ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
>> +                                                   &bdi->extcon_nb);
>> +               if (ret)
>> +                       goto out5;
>> +
>> +               /* Sync initial cable state */
>> +               queue_delayed_work(system_wq, &bdi->extcon_work, 0);
>> +       }
>> +
>>         enable_irq_wake(client->irq);
>>
>>         pm_runtime_mark_last_busy(dev);
>> --
>> 2.9.3
>>
