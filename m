From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 4/4] power: wm831x_power: Support USB charger current
 limit management
Date: Mon, 28 Mar 2016 14:45:10 +0800
Message-ID: <CAMz4ku+7-LmTMO0i-NCbWk6RiiA2Cbdcu6upkwy3xxa0EtMV7g@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<3609d98d4603efab7b2e50635efa9e36f64017a8.1458822334.git.baolin.wang@linaro.org>
	<CAMuHMdVUwbp4bJDYWjw6QyfngxYJgJCBe4=DN53tpFhjxUagcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36228 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcC1GpL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 02:45:11 -0400
Received: by mail-qk0-f181.google.com with SMTP id i4so60292995qkc.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Mar 2016 23:45:10 -0700 (PDT)
In-Reply-To: <CAMuHMdVUwbp4bJDYWjw6QyfngxYJgJCBe4=DN53tpFhjxUagcA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 27 March 2016 at 16:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Mar 24, 2016 at 1:35 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> --- a/drivers/power/wm831x_power.c
>> +++ b/drivers/power/wm831x_power.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/slab.h>
>> +#include <linux/usb/usb_charger.h>
>>
>>  #include <linux/mfd/wm831x/core.h>
>>  #include <linux/mfd/wm831x/auxadc.h>
>> @@ -31,6 +32,8 @@ struct wm831x_power {
>>         char usb_name[20];
>>         char battery_name[20];
>>         bool have_battery;
>> +       struct usb_charger *usb_charger;
>> +       struct notifier_block usb_notify;
>>  };
>>
>>  static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
>> @@ -125,6 +128,43 @@ static enum power_supply_property wm831x_usb_props[] = {
>>         POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>  };
>>
>> +/* In milliamps */
>> +static unsigned int wm831x_usb_limits[] = {
>
> const

OK.

>
>> +       0,
>> +       2,
>> +       100,
>> +       500,
>> +       900,
>> +       1500,
>> +       1800,
>> +       550,
>> +};
>> +
>> +static int wm831x_usb_limit_change(struct notifier_block *nb,
>> +                                  unsigned long limit, void *data)
>> +{
>> +       struct wm831x_power *wm831x_power = container_of(nb,
>> +                                                        struct wm831x_power,
>> +                                                        usb_notify);
>> +       int i, best;
>
> unsigned int

OK.

>
>> +
>> +       /* Find the highest supported limit */
>> +       best = 0;
>> +       for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
>> +               if (limit >= wm831x_usb_limits[i] &&
>> +                   wm831x_usb_limits[best] < wm831x_usb_limits[i])
>> +                       best = i;
>> +       }
>> +
>> +       dev_dbg(wm831x_power->wm831x->dev,
>> +               "Limiting USB current to %dmA", wm831x_usb_limits[best]);
>
> %u

OK. Thanks for your comments.

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Baolin.wang
Best Regards
