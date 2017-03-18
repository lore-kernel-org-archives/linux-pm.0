From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [05/15] power: supply: bq24190_charger: Limit charging voltage to
 4.3V
Date: Sat, 18 Mar 2017 15:24:02 +0100
Message-ID: <e2d21bb8-4165-ed3f-a290-05e7c274429c@redhat.com>
References: <20170318071019.4561-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbdCROcM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Mar 2017 10:32:12 -0400
In-Reply-To: <20170318071019.4561-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi,

On 18-03-17 08:10, Liam Breck wrote:
> On Fri, 17 Mar 2017 10:55:17 +0100, Hans de Goede wrote:
>
>> When the platform data asks us to not reset the charger to its default
>> values and instead trust the firmware set values check the charging
>> voltage and clamp it to 4.304V.
>>
>> Some firmwares set really too high voltages, e.g. the GPD-win I've been
>> working on uses 4.384V. New LiHV (High Voltage) batteries may be charged
>> upto 4.35V but that significantly impacts their lifetime, limit charging
>> to 4.304V for safety and lifetime reasons.
>
> See comments on patch 04; pls specify the offending firmwares and exactly how they
> misconfigure the charger. Include URLs to datasheets, etc.

As mentioned this is a x86 machine, without any datasheets. I can add an URL to
the page describing the device. Also misconfiguring may be a bit of a strong
word, this is a LiHV battery so 4.384V is mostly fine, I would just rather
use a max charge voltage with slightly more margin.

>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 27 ++++++++++++++++++++++++---
>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index c92a40e4..7bca8d0 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -504,11 +504,32 @@ static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
>>
>>  static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>>  {
>> -	int ret, limit = 100;
>> +	int ret, voltage, limit = 100;
>>  	u8 v;
>>
>> -	if (bdi->pdata && bdi->pdata->no_register_reset)
>> -		return 0;
>> +	if (bdi->pdata && bdi->pdata->no_register_reset) {
>
> See comments on patch 04. Invoke this in set_mode_host() using value from settings config.

Again, this is x86, there is no settings config (or one that we can get too)
other then the one stored in the registers of the IC.

>
>> +		/*
>> +		 * We've been asked to keep the firmware settings as is, but
>> +		 * some firmwares set really too high voltages (e.g. 4.384V).
>> +		 * New LiHV (High Voltage) batteries may be charged upto 4.35V
>> +		 * but that significantly impacts their lifetime, limit
>> +		 * charging to 4.304V for safety and lifetime reasons.
>> +		 */
>
> Docs which belong in external config.

Again there is NO external config. The i2c-adapter driver which registers
the client (and passed in any config) is a generic driver for any board
using a Cherrytrail Whiskey Cove PMIC. All that the ACPI tables tell us
is that there is a Cherrytrail Whiskey Cove PMIC and matching fuel-gauge,
for anything else we are on our own.


>
>> +		ret = bq24190_get_field_val(bdi, BQ24190_REG_CVC,
>> +			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
>> +			bq24190_cvc_vreg_values,
>> +			ARRAY_SIZE(bq24190_cvc_vreg_values), &voltage);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (voltage <= 4304000)
>> +			return 0;
>
> The limit value should come from settings config.

See above.

>
>> +		return bq24190_set_field_val(bdi, BQ24190_REG_CVC,
>> +			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
>> +			bq24190_cvc_vreg_values,
>> +			ARRAY_SIZE(bq24190_cvc_vreg_values), 4304000);
>> +	}
>>
>>  	/* Reset the registers */
>>  	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>

Regards,

Hans
