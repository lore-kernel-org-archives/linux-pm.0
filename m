From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Wed, 26 Jul 2017 11:05:25 +0800
Message-ID: <CAMz4ku+ya_wMWoH7-rr7f=XpmRVkWBR0bh_3oq7HLNc9B04eQw@mail.gmail.com>
References: <cover.1500968744.git.baolin.wang@linaro.org> <c6dbaa6b4417eb9213032404b90330c924613ed0.1500968745.git.baolin.wang@linaro.org>
 <20170725095931.qmxtn766wam7vufe@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170725095931.qmxtn766wam7vufe@earth>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 25 July 2017 at 17:59, Sebastian Reichel
<sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
> Hi,
>
> On Tue, Jul 25, 2017 at 04:00:01PM +0800, Baolin Wang wrote:
>> Integrate with the newly added USB charger interface to limit the current
>> we draw from the USB input based on the input device configuration
>> identified by the USB stack, allowing us to charge more quickly from high
>> current inputs without drawing more current than specified from others.
>>
>> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
>>  drivers/power/supply/wm831x_power.c              |   58 ++++++++++++++++++++++
>>  2 files changed, 59 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/wm831x.txt b/Documentation/devicetree/bindings/mfd/wm831x.txt
>> index 9f8b743..4e3bc07 100644
>> --- a/Documentation/devicetree/bindings/mfd/wm831x.txt
>> +++ b/Documentation/devicetree/bindings/mfd/wm831x.txt
>> @@ -31,6 +31,7 @@ Required properties:
>>      ../interrupt-controller/interrupts.txt
>>
>>  Optional sub-nodes:
>> +  - usb-phy : Contains a phandle to the USB PHY.
>>    - regulators : Contains sub-nodes for each of the regulators supplied by
>>      the device. The regulators are bound using their names listed below:
>>
>> diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
>> index 7082301..d3948ab 100644
>> --- a/drivers/power/supply/wm831x_power.c
>> +++ b/drivers/power/supply/wm831x_power.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/slab.h>
>> +#include <linux/usb/phy.h>
>>
>>  #include <linux/mfd/wm831x/core.h>
>>  #include <linux/mfd/wm831x/auxadc.h>
>> @@ -31,6 +32,8 @@ struct wm831x_power {
>>       char usb_name[20];
>>       char battery_name[20];
>>       bool have_battery;
>> +     struct usb_phy *usb_phy;
>> +     struct notifier_block usb_notify;
>>  };
>>
>>  static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
>> @@ -125,6 +128,43 @@ static int wm831x_usb_get_prop(struct power_supply *psy,
>>       POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>  };
>>
>> +/* In milliamps */
>> +static const unsigned int wm831x_usb_limits[] = {
>> +     0,
>> +     2,
>> +     100,
>> +     500,
>> +     900,
>> +     1500,
>> +     1800,
>> +     550,
>> +};
>> +
>> +static int wm831x_usb_limit_change(struct notifier_block *nb,
>> +                                unsigned long limit, void *data)
>> +{
>> +     struct wm831x_power *wm831x_power = container_of(nb,
>> +                                                      struct wm831x_power,
>> +                                                      usb_notify);
>> +     unsigned int i, best;
>> +
>> +     /* Find the highest supported limit */
>> +     best = 0;
>> +     for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
>> +             if (limit >= wm831x_usb_limits[i] &&
>> +                 wm831x_usb_limits[best] < wm831x_usb_limits[i])
>> +                     best = i;
>> +     }
>> +
>> +     dev_dbg(wm831x_power->wm831x->dev,
>> +             "Limiting USB current to %umA", wm831x_usb_limits[best]);
>> +
>> +     wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
>> +                     WM831X_USB_ILIM_MASK, best);
>> +
>> +     return 0;
>> +}
>> +
>>  /*********************************************************************
>>   *           Battery properties
>>   *********************************************************************/
>> @@ -607,6 +647,19 @@ static int wm831x_power_probe(struct platform_device *pdev)
>>               }
>>       }
>>
>> +     power->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev,
>> +                                                  "usb-phy", 0);
>> +     if (!IS_ERR(power->usb_phy)) {
>> +             power->usb_notify.notifier_call = wm831x_usb_limit_change;
>> +             ret = usb_register_notifier(power->usb_phy,
>> +                                         &power->usb_notify);
>> +             if (ret) {
>> +                     dev_err(&pdev->dev, "Failed to register notifier: %d\n",
>> +                             ret);
>> +                     goto err_bat_irq;
>> +             }
>> +     }
>
> No error handling for power->usb_phy? I think you should bail out
> for all errors except for "not defined in DT". Especially I would
> expect probe defer handling in case the power supply driver is
> loaded before the phy driver.

Make sense. So I think I need to change like below:

power->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
if (!IS_ERR(power->usb_phy)) {
        power->usb_notify.notifier_call = wm831x_usb_limit_change;
        ret = usb_register_notifier(power->usb_phy, &power->usb_notify);
        if (ret) {
                dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
                goto err_bat_irq;
        }
} else if (PTR_ERR(power->usb_phy) != -ENODEV &&
PTR_ERR(power->usb_phy) != -EINVAL) {
       ret = PTR_ERR(power->usb_phy);
       dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
       goto err_bat_irq;
}

The return value -EINVAL means the platform device does not have a
device node and -ENODEV  means we did not set the 'usb-phy' phandle,
other errors we should bail out including -PROBE_DEFER. Is it OK for
you?

>
>>       return ret;
>>
>>  err_bat_irq:
>> @@ -637,6 +690,11 @@ static int wm831x_power_remove(struct platform_device *pdev)
>>       struct wm831x *wm831x = wm831x_power->wm831x;
>>       int irq, i;
>>
>> +     if (!IS_ERR(wm831x_power->usb_phy)) {
>> +             usb_unregister_notifier(wm831x_power->usb_phy,
>> +                                     &wm831x_power->usb_notify);
>> +     }
>> +
>>       for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
>>               irq = wm831x_irq(wm831x,
>>                                platform_get_irq_byname(pdev,
>
> -- Sebastian



-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
