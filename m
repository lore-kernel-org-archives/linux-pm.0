From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 02/13] power: bq24257: Add dead battery reporting
Date: Tue, 1 Sep 2015 16:16:26 -0500
Message-ID: <55E615AA.8080807@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-3-git-send-email-dannenberg@ti.com> <55E5FD77.10100@ti.com>
 <20150901210446.GB17234@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45210 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbbIAVQy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Sep 2015 17:16:54 -0400
In-Reply-To: <20150901210446.GB17234@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org



On 09/01/2015 04:04 PM, Andreas Dannenberg wrote:
> Andrew- thanks for your feeback. Answers below...
>
> On Tue, Sep 01, 2015 at 02:33:11PM -0500, Andrew F. Davis wrote:
>> On 08/31/2015 09:10 PM, Andreas Dannenberg wrote:
>>> A missing/disconnected battery is now reported as dead rather than an
>>> unspecified failure via the charger's sysfs health property.
>>>
>>> $ cat health
>>> Dead
>>
>> Poor cat :(
>>
>
> I had to laugh pretty hard when I saw that getting printed onto the
> console for the first time so I had to include it here.
>
>>>
>>> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
>>> ---
>>>   drivers/power/bq24257_charger.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
>>> index db81356..0b34528 100644
>>> --- a/drivers/power/bq24257_charger.c
>>> +++ b/drivers/power/bq24257_charger.c
>>> @@ -274,6 +274,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
>>>   			val->intval = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
>>>   			break;
>>>
>>> +		case FAULT_NO_BAT:
>>> +			val->intval = POWER_SUPPLY_HEALTH_DEAD;
>>> +			break;
>>> +
>>
>> I think the best thing to do would be to return -ENODEV as suggested by
>> power_supply_sysfs.c:305. Also you should probably add the POWER_SUPPLY_PROP_PRESENT
>> property check and set intval to 0 when there is no battery.
>
> Good find with -ENODEV. However in this case here the power supply is
> really a combination of a charger and a battery (which could be split
> out accordingly but that's a different story). If I were to report
> -ENODEV I would basically say the entire power supply is gone which is
> not correct IMHO. Even with a missing battery a system is typically
> functional as it gets powered through USB and the charger IC is still
> there and functioning. So I think I would either leave the reporting
> as *_DEAD or skip the patch. I'm curious if there are additional
> opinions.
>

It looks like returning -ENODEV for one property would not mark the whole
device gone, just POWER_SUPPLY_PROP_HEALTH, but I guess that depends on
what user-space does with the info. I would think that this is what
POWER_SUPPLY_PROP_PRESENT is for but different drivers seem to use it for
different things. Anyway, reporting DEAD for a missing battery is probably
not the most correct option, maybe drop the patch ( for the cat's sake :) ).

-- 
Andrew F. Davis

> --
> Andreas Dannenberg
> Texas Instruments Inc
>
>>
>> Regards,
>> Andrew
>>
>>>   		default:
>>>   			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>>>   			break;
>>>
