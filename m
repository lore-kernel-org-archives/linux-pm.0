From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 13/16] power: supply: axp288_fuel_gauge: Cache charge_full
 value
Date: Tue, 26 Dec 2017 10:22:35 +0100
Message-ID: <fa66c7ea-8703-d20b-9dce-b00313b8c662@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
 <20171222123754.9622-13-hdegoede@redhat.com>
 <CAGb2v646ah-6Es8x+_mg6BdJQ--9D+=fsUX9Sp5RuGeen4aMmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38141 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZJWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 04:22:39 -0500
Received: by mail-wm0-f66.google.com with SMTP id 64so34144093wme.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2017 01:22:38 -0800 (PST)
In-Reply-To: <CAGb2v646ah-6Es8x+_mg6BdJQ--9D+=fsUX9Sp5RuGeen4aMmw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Sebastian Reichel <sre@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

Hi,

On 26-12-17 08:04, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Dec 22, 2017 at 8:37 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The charge_full value never changes on the axp288 (there is no
>> charge_full_design), so we can read it once and cache it.
> 
> The manual says on page 57:
> 
>      Additionally, the Fuel Gauge System is capable to learn the battery
>      characteristic on each Full charge cycle.  Information such as Battery
>      Maximum capacity (REG E0H, REG E1H) and Rdc (REG BAH, REG BBH) will be
>      updated automatically over time.
> 
> Tablets might spend more time in suspend than actually being powered off,
> meaning over time the value the kernel knows might be stale. But it looks
> like the driver doesn't support suspend. I'd advise against this patch, or
> at least leave some todo note to add a read-out call in the resume callback
> (when its implemented).

Ok, I will drop this patch from v2 of the patchset.

Regards,

Hans


> 
> ChenYu
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/power/supply/axp288_fuel_gauge.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
>> index eb60f75f00d7..800abecef45c 100644
>> --- a/drivers/power/supply/axp288_fuel_gauge.c
>> +++ b/drivers/power/supply/axp288_fuel_gauge.c
>> @@ -120,6 +120,7 @@ struct axp288_fg_info {
>>          struct power_supply *bat;
>>          struct mutex lock;
>>          int status;
>> +       int charge_full_raw;
>>          int max_volt;
>>          struct delayed_work status_monitor;
>>          struct dentry *debug_file;
>> @@ -504,11 +505,7 @@ static int fuel_gauge_get_property(struct power_supply *ps,
>>                  val->intval = ret * FG_DES_CAP_RES_LSB;
>>                  break;
>>          case POWER_SUPPLY_PROP_CHARGE_FULL:
>> -               ret = fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG);
>> -               if (ret < 0)
>> -                       goto fuel_gauge_read_err;
>> -
>> -               val->intval = ret * FG_DES_CAP_RES_LSB;
>> +               val->intval = info->charge_full_raw * FG_DES_CAP_RES_LSB;
>>                  break;
>>          case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>>                  val->intval = PROP_VOLT(info->max_volt);
>> @@ -732,15 +729,15 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
>>                  }
>>          }
>>
>> -       ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
>> -       if (ret < 0)
>> -               goto out_free_iio_chan;
>> -
>> -       if (!(ret & FG_DES_CAP1_VALID)) {
>> -               dev_err(&pdev->dev, "axp288 not configured by firmware\n");
>> -               ret = -ENODEV;
>> +       ret = fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG);
>> +       if (ret < 0) {
>> +               if (ret == -ENXIO) {
>> +                       dev_err(&pdev->dev, "axp288 not configured by firmware\n");
>> +                       ret = -ENODEV;
>> +               }
>>                  goto out_free_iio_chan;
>>          }
>> +       info->charge_full_raw = ret;
>>
>>          ret = fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1);
>>          if (ret < 0)
>> --
>> 2.14.3
>>
