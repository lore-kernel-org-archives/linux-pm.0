From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 16/18] power: supply: bq24190_charger: Remove extcon
 handling
Date: Tue, 8 Aug 2017 11:12:45 +0200
Message-ID: <cdcf4506-0e64-d495-b40d-16f1f591af85@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-17-hdegoede@redhat.com>
 <CAKvHMgRKetHrqgWuUq9-QoL47_23f__04W6ZSGvH-AiG4RGKFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKvHMgRKetHrqgWuUq9-QoL47_23f__04W6ZSGvH-AiG4RGKFw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 08-08-17 10:27, Liam Breck wrote:
> Hi Hans,
> 
> On Sun, Aug 6, 2017 at 5:35 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Now that drivers/i2c/busses/i2c-cht-wc.c uses
>> "input-current-limit-from-supplier" instead of "extcon-name" the last
>> user of the bq24190 extcon code is gone, remove it.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/power/supply/bq24190_charger.c | 107 ---------------------------------
>>   1 file changed, 107 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index 1f6424f0772f..0376de6d8e70 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -11,7 +11,6 @@
>>   #include <linux/module.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/delay.h>
>> -#include <linux/extcon.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/of_device.h>
>>   #include <linux/pm_runtime.h>
>> @@ -155,9 +154,6 @@ struct bq24190_dev_info {
>>          struct device                   *dev;
>>          struct power_supply             *charger;
>>          struct power_supply             *battery;
>> -       struct extcon_dev               *extcon;
>> -       struct notifier_block           extcon_nb;
>> -       struct delayed_work             extcon_work;
>>          char                            model_name[I2C_NAME_SIZE];
>>          bool                            initialized;
>>          bool                            irq_event;
>> @@ -1530,75 +1526,6 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>>          return IRQ_HANDLED;
>>   }
>>
>> -static void bq24190_extcon_work(struct work_struct *work)
>> -{
>> -       struct bq24190_dev_info *bdi =
>> -               container_of(work, struct bq24190_dev_info, extcon_work.work);
>> -       int error, iinlim = 0;
>> -       u8 v;
>> -
>> -       error = pm_runtime_get_sync(bdi->dev);
>> -       if (error < 0) {
>> -               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
>> -               pm_runtime_put_noidle(bdi->dev);
>> -               return;
>> -       }
>> -
>> -       if      (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) == 1)
>> -               iinlim =  500000;
>> -       else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_CDP) == 1 ||
>> -                extcon_get_state(bdi->extcon, EXTCON_CHG_USB_ACA) == 1)
>> -               iinlim = 1500000;
>> -       else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_DCP) == 1)
>> -               iinlim = 2000000;
>> -
>> -       if (iinlim) {
>> -               error = bq24190_set_field_val(bdi, BQ24190_REG_ISC,
>> -                                             BQ24190_REG_ISC_IINLIM_MASK,
>> -                                             BQ24190_REG_ISC_IINLIM_SHIFT,
>> -                                             bq24190_isc_iinlim_values,
>> -                                             ARRAY_SIZE(bq24190_isc_iinlim_values),
>> -                                             iinlim);
>> -               if (error < 0)
>> -                       dev_err(bdi->dev, "Can't set IINLIM: %d\n", error);
>> -       }
>> -
>> -       /* if no charger found and in USB host mode, set OTG 5V boost, else normal */
>> -       if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) == 1)
>> -               v = BQ24190_REG_POC_CHG_CONFIG_OTG;
>> -       else
>> -               v = BQ24190_REG_POC_CHG_CONFIG_CHARGE;
>> -
>> -       error = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> -                                  BQ24190_REG_POC_CHG_CONFIG_MASK,
>> -                                  BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> -                                  v);
>> -       if (error < 0)
>> -               dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", error);
>> -
>> -       pm_runtime_mark_last_busy(bdi->dev);
>> -       pm_runtime_put_autosuspend(bdi->dev);
>> -}
>> -
>> -static int bq24190_extcon_event(struct notifier_block *nb, unsigned long event,
>> -                               void *param)
>> -{
>> -       struct bq24190_dev_info *bdi =
>> -               container_of(nb, struct bq24190_dev_info, extcon_nb);
>> -
>> -       /*
>> -        * The Power-Good detection may take up to 220ms, sometimes
>> -        * the external charger detection is quicker, and the bq24190 will
>> -        * reset to iinlim based on its own charger detection (which is not
>> -        * hooked up when using external charger detection) resulting in
>> -        * a too low default 500mA iinlim. Delay applying the extcon value
>> -        * for 300ms to avoid this.
>> -        */
>> -       queue_delayed_work(system_wq, &bdi->extcon_work, msecs_to_jiffies(300));
>> -
>> -       return NOTIFY_OK;
>> -}
>> -
>>   static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>>   {
>>          u8 v;
>> @@ -1636,7 +1563,6 @@ static int bq24190_probe(struct i2c_client *client,
>>          struct device *dev = &client->dev;
>>          struct power_supply_config charger_cfg = {}, battery_cfg = {};
>>          struct bq24190_dev_info *bdi;
>> -       const char *name;
>>          int ret;
>>
>>          if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
>> @@ -1668,25 +1594,6 @@ static int bq24190_probe(struct i2c_client *client,
>>                  device_property_read_bool(dev,
>>                                            "input-current-limit-from-supplier");
>>
>> -       /*
>> -        * Devicetree platforms should get extcon via phandle (not yet supported).
>> -        * On ACPI platforms, extcon clients may invoke us with:
>> -        * struct property_entry pe[] =
>> -        *   { PROPERTY_ENTRY_STRING("extcon-name", client_name), ... };
>> -        * struct i2c_board_info bi =
>> -        *   { .type = "bq24190", .addr = 0x6b, .properties = pe, .irq = irq };
>> -        * struct i2c_adapter ad = { ... };
>> -        * i2c_add_adapter(&ad);
>> -        * i2c_new_device(&ad, &bi);
>> -        */
> 
> Maybe we should keep a variation of the above comment, documenting how
> we're invoked by another driver, and the dev props it sets for us.

Ok, I will move this comment to one of the other props for v2.

Regards,

Hans
