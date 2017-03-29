From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Wed, 29 Mar 2017 01:21:54 -0700
Message-ID: <CAKvHMgTu_HNKoxX-Ogj33xLOvQwczFMCjcB1h6cLRxOLyvwyBg@mail.gmail.com>
References: <20170323083235.15072-1-hdegoede@redhat.com> <CAKvHMgTqyW8MnVLyzR5L3+DjQHZ+04GZtW+MhkNAt7HBrqUhBw@mail.gmail.com>
 <0b3d3f1e-0f86-1090-4812-1a574d9dadb0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35514 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754414AbdC2IWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 04:22:11 -0400
Received: by mail-it0-f67.google.com with SMTP id y18so8424490itc.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 01:22:10 -0700 (PDT)
In-Reply-To: <0b3d3f1e-0f86-1090-4812-1a574d9dadb0@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

On Wed, Mar 29, 2017 at 12:34 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 29-03-17 03:12, Liam Breck wrote:
>>
>> Sebastian, this patch needs some work, could you drop it from -next
>> and look for v4 from Hans?
>
>
> Nack.
>
> Liam this whole dropping patches from -next business is not how
> things are normally done in kernel-land, please stop expecting it.
>
> The whole dropping patches all the time thing means people don't have
> a stable base to base future patches on which is unworkable.

This was merged 3h after you posted it without acks from Tony or me.
So maybe asking for a do-over in this case isn't unreasonable :-)
Another of your patches has a replacement pending already. We'd both
benefit from a clean history wherever possible. And new-feature
patches should really simmer on the list for a little while.

>> Hans, I regret I couldn't study this sooner, but 5-day turnaround
>> isn't too bad :-)
>
>
> You actually already reviewed v2 which is why v3 has:
>
>>> Changes in v3:
>>> -Print a msg with dev_info when an extcon is used do determine iinlim
>
> As you requested,  so it is a bit weird to now ask for a version with
> the changes you requested to be dropped because you decided you want
> more changes now...

I took a quick look at v2. I didn't have a chance to respond to v3
before it landed in -next.

>> I will send a v3 of "Uniform pm_runtime_get ..." not rebased to this.
>
>
> Please base it on top instead and also fix the runtime_pm_get_sync()
> error-handling in the newly added function, that was copy pasted from
> what is in hindsight a bad example, so fixing it in the same patch
> makes sense.

The v2 of "Uniform..." I just posted is actually based on -next, but
doesn't touch your code, so has to be redone itself.

>> On Thu, Mar 23, 2017 at 1:32 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Add support for monitoring an extcon device with USB SDP/CDP/DCP and HOST
>>> cables and adjust ilimit and enable/disable the 5V boost converter
>>> accordingly. This is necessary on systems where the PSEL pin is hardwired
>>> high and ILIM needs to be set by software based on the detected charger
>>> type, as well as on systems where the 5V boost converter is used, as
>>> that always needs to be enabled from software.
>>>
>>> Cc: Liam Breck <kernel@networkimprov.net>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Acked-by: Sebastian Reichel <sre@kernel.org>
>>> ---
>>> Changes in v2:
>>> -Use a device-property for extcon-name instead of platform_data
>>> -Delay 300ms before applying the extcon detected charger-type to iinlim
>>>  (see the added comment for why this is done)
>>> Changes in v3:
>>> -Print a msg with dev_info when an extcon is used do determine iinlim
>>> ---
>>>  drivers/power/supply/Kconfig           |   1 +
>>>  drivers/power/supply/bq24190_charger.c | 109
>>> +++++++++++++++++++++++++++++++++
>>>  2 files changed, 110 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>>> index f8b6e64..fd93110 100644
>>> --- a/drivers/power/supply/Kconfig
>>> +++ b/drivers/power/supply/Kconfig
>>> @@ -442,6 +442,7 @@ config CHARGER_BQ2415X
>>>  config CHARGER_BQ24190
>>>         tristate "TI BQ24190 battery charger driver"
>>>         depends on I2C
>>> +       depends on EXTCON
>>>         depends on GPIOLIB || COMPILE_TEST
>>>         help
>>>           Say Y to enable support for the TI BQ24190 battery charger.
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index d74c8cc..2c404a5 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -11,10 +11,12 @@
>>>  #include <linux/module.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/delay.h>
>>> +#include <linux/extcon.h>
>>>  #include <linux/of_irq.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/power_supply.h>
>>> +#include <linux/workqueue.h>
>>>  #include <linux/gpio.h>
>>>  #include <linux/i2c.h>
>>>
>>> @@ -36,6 +38,8 @@
>>>  #define BQ24190_REG_POC_WDT_RESET_SHIFT                6
>>>  #define BQ24190_REG_POC_CHG_CONFIG_MASK                (BIT(5) | BIT(4))
>>>  #define BQ24190_REG_POC_CHG_CONFIG_SHIFT       4
>>> +#define BQ24190_REG_POC_CHG_CONFIG_CHARGE      1
>>> +#define BQ24190_REG_POC_CHG_CONFIG_OTG         2
>>
>>
>> Place these at the end of the reg_poc section, so the mask & shift
>> names are together.
>>
>>>  #define BQ24190_REG_POC_SYS_MIN_MASK           (BIT(3) | BIT(2) |
>>> BIT(1))
>>>  #define BQ24190_REG_POC_SYS_MIN_SHIFT          1
>>>  #define BQ24190_REG_POC_BOOST_LIM_MASK         BIT(0)
>>> @@ -148,6 +152,9 @@ struct bq24190_dev_info {
>>>         struct device                   *dev;
>>>         struct power_supply             *charger;
>>>         struct power_supply             *battery;
>>> +       struct extcon_dev               *extcon;
>>> +       struct notifier_block           extcon_nb;
>>> +       struct delayed_work             extcon_work;
>>>         char                            model_name[I2C_NAME_SIZE];
>>>         bool                            initialized;
>>>         bool                            irq_event;
>>> @@ -164,6 +171,11 @@ struct bq24190_dev_info {
>>>   * number at that index in the array is the real-world value that it
>>>   * represents.
>>>   */
>>> +
>>> +/* REG00[2:0] (IINLIM) in uAh */
>>> +static const int bq24190_iinlim_values[] = {
>>> +       100000, 150000, 500000, 900000, 1200000, 1500000, 2000000,
>>> 3000000 };
>>
>>
>> Correct name is bq24190_isc_iinlim_values, following convention of others.
>>
>>>  /* REG02[7:2] (ICHG) in uAh */
>>>  static const int bq24190_ccc_ichg_values[] = {
>>>          512000,  576000,  640000,  704000,  768000,  832000,  896000,
>>> 960000,
>>> @@ -1277,6 +1289,78 @@ static irqreturn_t bq24190_irq_handler_thread(int
>>> irq, void *data)
>>>         return IRQ_HANDLED;
>>>  }
>>>
>>> +static void bq24190_extcon_work(struct work_struct *work)
>>> +{
>>> +       struct bq24190_dev_info *bdi =
>>> +               container_of(work, struct bq24190_dev_info,
>>> extcon_work.work);
>>> +       int ret, iinlim = 0;
>>> +
>>> +       ret = pm_runtime_get_sync(bdi->dev);
>>> +       if (ret < 0) {
>>> +               dev_err(bdi->dev, "Error getting runtime-pm ref: %d\n",
>>> ret);
>>
>>
>> Needs pm_runtime_put_noidle()
>> Use same error msg as other pm_runtime_get_sync failures.
>
>
> This should be fixed in a v3 of your:
> "power: bq24190_charger: Uniform pm_runtime_get() failure handling"
> patch.
>
>
>
>>
>>> +               return;
>>> +       }
>>> +
>>> +       if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) == 1)
>>> +               iinlim = 500000;
>>> +       else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_CDP) == 1
>>> ||
>>> +                extcon_get_state(bdi->extcon, EXTCON_CHG_USB_ACA) == 1)
>>> +               iinlim = 1500000;
>>> +       else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_DCP) == 1)
>>> +               iinlim = 2000000;
>>> +
>>> +       if (iinlim) {
>>> +               ret = bq24190_set_field_val(bdi, BQ24190_REG_ISC,
>>> +                               BQ24190_REG_ISC_IINLIM_MASK,
>>> +                               BQ24190_REG_ISC_IINLIM_SHIFT,
>>> +                               bq24190_iinlim_values,
>>> +                               ARRAY_SIZE(bq24190_iinlim_values),
>>> +                               iinlim);
>>> +               if (ret)
>>
>>
>> ret < 0
>>
>>> +                       dev_err(bdi->dev, "Can't set IINLIM: %d\n", ret);
>>> +       }
>>> +
>>> +       /*
>>> +        * If no charger has been detected and host mode is requested,
>>> activate
>>> +        * the 5V boost converter, otherwise deactivate it.
>>> +        */
>>
>>
>> u8 val = BQ24190_REG_POC_CHG_CONFIG_CHARGE;
>>
>>> +       if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) ==
>>> 1) {
>>
>>
>> if (above) val = BQ24190_REG_POC_CHG_CONFIG_OTG;
>>
>> Then call write_mask once, with val.
>
>
> Good idea, but actually I found out by booting my board with a host-cable
> (USB-C equivalent of id-pin connected to ground) plugged in that there is
> a second 5v boost converter on the board and that that-one gets used by
> the firmware, so I will submit a patch soon-ish dropping the EXTCON_USB_HOST
> handling all together.

Since you're planning this fix anyway, perhaps re-do this patch with
that change and my feedback?

> As Sebastian already said (I believe) it would be best to export the 5V
> boost
> converter as a regulator, but that can wait until we actually need it
> somewhere.
>
>
>>
>>> +               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>>> +                                        BQ24190_REG_POC_CHG_CONFIG_MASK,
>>> +
>>> BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>>> +                                        BQ24190_REG_POC_CHG_CONFIG_OTG);
>>> +       } else {
>>> +               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>>> +                                        BQ24190_REG_POC_CHG_CONFIG_MASK,
>>> +
>>> BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>>> +
>>> BQ24190_REG_POC_CHG_CONFIG_CHARGE);
>>> +       }
>>> +       if (ret)
>>
>>
>> ret < 0
>>
>>> +               dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", ret);
>>> +
>>> +       pm_runtime_mark_last_busy(bdi->dev);
>>> +       pm_runtime_put_autosuspend(bdi->dev);
>>> +}
>>> +
>>> +static int bq24190_extcon_event(struct notifier_block *nb, unsigned long
>>> event,
>>> +                               void *param)
>>> +{
>>> +       struct bq24190_dev_info *bdi =
>>> +               container_of(nb, struct bq24190_dev_info, extcon_nb);
>>> +
>>> +       /*
>>> +        * The Power-Good detection may take up to 220ms, sometimes
>>> +        * the external charger detection is quicker, and the bq24190
>>> will
>>> +        * reset to iinlim based on its own charger detection (which is
>>> not
>>> +        * hooked up when using external charger detection) resulting in
>>> +        * a too low default 500mA iinlim. Delay applying the extcon
>>> value
>>> +        * for 300ms to avoid this.
>>> +        */
>>> +       queue_delayed_work(system_wq, &bdi->extcon_work,
>>> msecs_to_jiffies(300));
>>> +
>>> +       return NOTIFY_OK;
>>> +}
>>> +
>>>  static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>>>  {
>>>         u8 v;
>>> @@ -1314,6 +1398,7 @@ static int bq24190_probe(struct i2c_client *client,
>>>         struct device *dev = &client->dev;
>>>         struct power_supply_config charger_cfg = {}, battery_cfg = {};
>>>         struct bq24190_dev_info *bdi;
>>> +       const char *name;
>>>         int ret;
>>>
>>>         if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>>> {
>>> @@ -1341,6 +1426,18 @@ static int bq24190_probe(struct i2c_client
>>> *client,
>>>                 return -EINVAL;
>>>         }
>>>
>>> +       /*
>>> +        * The extcon-name property is purely an in kernel interface for
>>> +        * x86/ACPI use, DT platforms should get extcon via phandle.
>>> +        */
>>> +       if (device_property_read_string(dev, "extcon-name", &name) == 0)
>>> {
>>
>>
>> Is the "extcon-name" in-kernel interface documented, or a convention,
>> or custom to your gauge/setup?
>
>
> It is documented right above the use of it :)  Since this is the first
> case of passing an extcon-name through a device property AFAIK we
> are starting the convention of doing this this way I guess.

Is there somewhere we could document this convention where others
might find it? :-)

>>> +               bdi->extcon = extcon_get_extcon_dev(name);
>>> +               if (!bdi->extcon)
>>> +                       return -EPROBE_DEFER;
>>> +
>>> +               dev_info(bdi->dev, "using extcon device %s\n", name);
>>> +       }
>>> +
>>>         pm_runtime_enable(dev);
>>>         pm_runtime_use_autosuspend(dev);
>>>         pm_runtime_set_autosuspend_delay(dev, 600);
>>> @@ -1391,6 +1488,18 @@ static int bq24190_probe(struct i2c_client
>>> *client,
>>>                 goto out5;
>>>         }
>>>
>>> +       if (bdi->extcon) {
>>> +               INIT_DELAYED_WORK(&bdi->extcon_work,
>>> bq24190_extcon_work);
>>> +               bdi->extcon_nb.notifier_call = bq24190_extcon_event;
>>> +               ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
>>> +                                                   &bdi->extcon_nb);
>>> +               if (ret)
>>> +                       goto out5;
>>
>>
>> Needs a dev_err msg. Also out5 changes to out_sysfs in my recent patch.
>
>
> Again you should rebase your patch on top of next, not expect me to
> do a new version of my already merged patch, and then fix this up
> in your new version.
>
> Regards,
>
> Hans
>
>
>
>>
>>> +               /* Sync initial cable state */
>>> +               queue_delayed_work(system_wq, &bdi->extcon_work, 0);
>>> +       }
>>> +
>>>         enable_irq_wake(client->irq);
>>>
>>>         pm_runtime_mark_last_busy(dev);
>>> --
>>> 2.9.3
>>>
>
