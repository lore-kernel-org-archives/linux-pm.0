From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/13] power: max17047_battery: The temp alert values are
 8-bit 2's complement
Date: Fri, 14 Apr 2017 17:16:32 +0200
Message-ID: <cd0d961a-6ad0-6298-5319-d8dc96da7059@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-3-hdegoede@redhat.com>
 <20170414150927.eo5n2derv26dskcd@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbdDNPQf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 11:16:35 -0400
In-Reply-To: <20170414150927.eo5n2derv26dskcd@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

Hi,

On 14-04-17 17:09, Krzysztof Kozlowski wrote:
> On Fri, Apr 14, 2017 at 02:59:09PM +0200, Hans de Goede wrote:
>> The temp alert values are 8-bit 2's complement, so sign-extend them
>> before reporting them back to the caller.
>
> Are you sure that these are reported with sign bit? I couldn't find
> confirmation of this in datasheet.

From: MAX17047-MAX17050.pdf

"T ALRT Threshold Register (02h)
The T ALRT Threshold register sets upper and lower limits
that generate an ALRT pin interrupt if exceeded by the
Temperature register value. The upper 8 bits set the maxi-
mum value and the lower 8 bits set the minimum value.
Interrupt threshold limits are stored in two’s-complement
format"

And the reset default of 7F80h also hints at this,
as it is +127 for max -128 for min (aka temp based
alerts disabled).

Regards,

Hans


>
> Best regards,
> Krzysztof
>
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/max17042_battery.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
>> index 790dfa9..a51b296 100644
>> --- a/drivers/power/supply/max17042_battery.c
>> +++ b/drivers/power/supply/max17042_battery.c
>> @@ -270,14 +270,14 @@ static int max17042_get_property(struct power_supply *psy,
>>  		if (ret < 0)
>>  			return ret;
>>  		/* LSB is Alert Minimum. In deci-centigrade */
>> -		val->intval = (data & 0xff) * 10;
>> +		val->intval = sign_extend32(data & 0xff, 7) * 10;
>>  		break;
>>  	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>>  		ret = regmap_read(map, MAX17042_TALRT_Th, &data);
>>  		if (ret < 0)
>>  			return ret;
>>  		/* MSB is Alert Maximum. In deci-centigrade */
>> -		val->intval = (data >> 8) * 10;
>> +		val->intval = sign_extend32(data >> 8, 7) * 10;
>>  		break;
>>  	case POWER_SUPPLY_PROP_TEMP_MIN:
>>  		val->intval = chip->pdata->temp_min;
>> --
>> 2.9.3
>>
