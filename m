From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 15/16] power: supply: axp288_fuel_gauge: Fix FULL status
 reporting
Date: Tue, 26 Dec 2017 10:22:55 +0100
Message-ID: <c83d159e-7bbb-71f3-35fc-3c0aa35e2130@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
 <20171222123754.9622-15-hdegoede@redhat.com>
 <CAGb2v65gGgQoqckyR_1TZn4-K4xhbNWx9FYFO1iuCcfCJacy4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:43498 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZJW6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 04:22:58 -0500
Received: by mail-wm0-f48.google.com with SMTP id n138so34232630wmg.2
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2017 01:22:58 -0800 (PST)
In-Reply-To: <CAGb2v65gGgQoqckyR_1TZn4-K4xhbNWx9FYFO1iuCcfCJacy4g@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Sebastian Reichel <sre@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

Hi,

On 26-12-17 08:26, Chen-Yu Tsai wrote:
> On Fri, Dec 22, 2017 at 8:37 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Relying on the (dis)charge current reporting for reporting FULL back to
>> userspace does not work really well and often leads to the reported status
>> getting stuck at e.g. 98/99% (the fuelgauge is not perfect) for hours.
>>
>> What happens is that when the battery is full the axp288 keeps charging it
>> with a very low current. Until it is really really full and once really
>> really full, some inaccuracies in the adc lead to it then sometimes
>> reporting a small discharging rate, even though an external pwr source is
>> used. So we end up with a status of "charging" for hours after the battery
>> is actually already full and sometimes this then flip-flops to discharging.
>>
>> This commit fixes this by using the fuel-gauge to check if the battery is
>> approximately full and if it is then discount a (dis)charge current smaller
>> then 64mA.
>>
>> If we encounter a 0 (dis)charge current when not full, then report this
>> as "not charging".
> 
> The trickle charge mode is called "safe mode" in the manual, which charges
> the battery at 5mA until the battery is within 0.1V of the target voltage.
> This mode can be checked by looking at REG 01h bit 3. See section 9.4.3
> on page 50 for more information.

No safe mode is some something different, there is a timer for determining
the max fast charging time and if that expires then safe mode is entered.

Section 9.4.3 also says: "When the actual charge current is less than 20%
of the ICHRG, the timer will automatically hold." IOW during a normal
charge cycle the (actual charge-current) will drop to below 20% of the max
charge current before the safety timer expires and then the safety timer
stops running, so it will never expire.

Note that the "fast charge max time" is between 6 and 12 hours, so quite
long, so we should really never see the device entering safemode.

Reg 1 also has a "Charging Indication" bit but that is not really helpful
either, it turns off at around 90% or so and even then it just not turns
off, it bounces for a bit while it is around the threshold it uses.

> This might be better than the heuristic you're using. Also

See above, I'm afraid we really need to do our own heuristic, the reg
01 status bits are not usable.

>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/power/supply/axp288_fuel_gauge.c | 33 ++++++++++++++++++++++++++++----
>>   1 file changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
>> index 2fc144b1ec0a..5750b6caecd4 100644
>> --- a/drivers/power/supply/axp288_fuel_gauge.c
>> +++ b/drivers/power/supply/axp288_fuel_gauge.c
>> @@ -337,7 +337,8 @@ static inline void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
>>
>>   static void fuel_gauge_get_status(struct axp288_fg_info *info)
>>   {
>> -       int ret, charge, discharge;
>> +       int ret, charge, discharge, charge_now_raw, threshold;
>> +       bool full;
>>
>>          ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &charge);
>>          if (ret < 0) {
>> @@ -352,12 +353,36 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
>>                  return;
>>          }
>>
>> -       if (charge > 0)
>> +       ret = fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG);
>> +       if (ret < 0) {
>> +               dev_err(&info->pdev->dev,
>> +                       "ADC charge current read failed:%d\n", ret);
>> +               return;
>> +       }
>> +       charge_now_raw = ret;
>> +
>> +       /*
>> +        * When the battery is full the axp288 keeps charging it with a
>> +        * very low current. Until it is really really full and once really
>> +        * really full, some inaccuracies in the adc lead to it then sometimes
>> +        * reporting a small discharging rate, even though an external pwr
>> +        * source is used.
>> +        *
>> +        * So when we the battery is (nearly) full we treat low (dis)charge
>> +        * currents as 0.
>> +        */
>> +
>> +       full = DIV_ROUND_UP(charge_now_raw * 100, info->charge_full_raw) >= 98;
> 
> The contents of REG E5h contains what you are calculating here (charge
> percentage).
> You could just use that. I'm not sure what the relationship between REG B9h, E4H
> and E5h is. B9h (overall capacity percentage) is another choice.

Interesting I will run some tests with these, from the datasheet it seems that
E5 is just the coulumbmeter percentage, without the usual correction for the
OCV of the cell, so this will drift over time, I think B9"Battery capacity percentage for indication" is the one which we want as that
seems to be the final estimated charge percentage value.

Anyways thank you for the feedback, using one of the percentage registers
seems like a good idea. I will run some tests with this and then post a new
version.

Regards,

Hans



> ChenYu
> 
>> +       threshold = full ? 64 : 0; /* mA */
>> +
>> +       if (charge > threshold)
>>                  info->status = POWER_SUPPLY_STATUS_CHARGING;
>> -       else if (discharge > 0)
>> +       else if (discharge > threshold)
>>                  info->status = POWER_SUPPLY_STATUS_DISCHARGING;
>> -       else
>> +       else if (full)
>>                  info->status = POWER_SUPPLY_STATUS_FULL;
>> +       else
>> +               info->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>   }
>>
>>   static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)
>> --
>> 2.14.3
>>
