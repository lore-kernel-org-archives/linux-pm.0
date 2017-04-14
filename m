From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/13] power: Make power_supply_am_i_supplied return
 -ENODEV if there are no suppliers
Date: Fri, 14 Apr 2017 16:07:22 +0200
Message-ID: <67216acf-89da-033c-8214-7166e858a306@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414135638.pbcjxvvf6a7gfizw@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbdDNOHZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 10:07:25 -0400
In-Reply-To: <20170414135638.pbcjxvvf6a7gfizw@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

Hi,

On 14-04-17 15:56, Krzysztof Kozlowski wrote:
> On Fri, Apr 14, 2017 at 02:59:07PM +0200, Hans de Goede wrote:
>> Allow a caller of power_supply_am_i_supplied to differentiate between
>> there not being any suppliers, vs no suppliers being online by returning
>> -ENODEV if there are no suppliers matching supplied_to / supplied_from.
>>
>
> This is missing important piece of information - why you need to
> differentiate that? What is the difference for you between no supplies
> at all and not-being-supplied?

Thank you for the quick response.

I think it is sensible to assume that the hardware actually always has a
way of charging the battery so where you say "no supplies at all" in
reality what would be the case is : "no power_supply-drivers
registered / bound for any supplies at all". At which point we can not
determine in many fuel-gauge drivers (which are the only user of
power_supply_am_i_supplied) if we're charging or discharging.

Here is the code for the STATUS property I'm adding to the max17042
driver in a later commit in the set:

static int max17042_get_status(struct max17042_chip *chip, int *status)
{
         int ret, charge_full, charge_now;

         ret = power_supply_am_i_supplied(chip->battery);
         if (ret < 0) {
                 *status = POWER_SUPPLY_STATUS_UNKNOWN;
                 return 0;
         }
         if (ret == 0) {
                 *status = POWER_SUPPLY_STATUS_DISCHARGING;
                 return 0;
         }

	...
}

This is where the -ENODEV comes in to make it properly return
POWER_SUPPLY_STATUS_UNKNOWN instead of always returning
POWER_SUPPLY_STATUS_DISCHARGING even if that may be untrue.

Note that I've since found out that the only in tree user of the
max17042 driver is arch/arm/boot/dts/exynos4412-trats2.dts and
the last patch in my makes the max77693 charger driver properly
set supplied_to so that power_supply_am_i_supplied() will work
correctly for the max17047 / max77693 combo on that board, which
sort of renders this patch unnecessary. I still think this patch
is a good idea, but it can be dropped if other people disagree.

Regards,

Hans




>
>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/power_supply_core.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 1e0960b..13a39da 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -280,13 +280,19 @@ static inline int power_supply_check_supplies(struct power_supply *psy)
>>  }
>>  #endif
>>
>> -static int __power_supply_am_i_supplied(struct device *dev, void *data)
>> +struct am_i_supplied_data {
>
> How about a prefix, e.g.: "psy_am_i_supplied_data"?
>
> Best regards,
> Krzysztof
>
