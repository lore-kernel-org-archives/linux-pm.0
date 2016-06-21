From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH v2] power_supply: fix return value of get_property
Date: Tue, 21 Jun 2016 14:08:05 -0400
Message-ID: <2d2e4c90-472d-fa1a-6fbc-dfb99e80069d@nvidia.com>
References: <1466028784-24459-1-git-send-email-rklein@nvidia.com>
 <576266A9.9030906@samsung.com>
 <04e70c84-f34d-2c61-0d8b-80cbeaac356e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5394 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcFUSIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 14:08:55 -0400
In-Reply-To: <04e70c84-f34d-2c61-0d8b-80cbeaac356e@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/16/2016 11:40 AM, Rhyland Klein wrote:
> On 6/16/2016 4:43 AM, Krzysztof Kozlowski wrote:
>> On 06/16/2016 12:13 AM, Rhyland Klein wrote:
>>> power_supply_get_property() should ideally return -EAGAIN if it is
>>> called while the power_supply is being registered. There was no way
>>> previously to determine if use_cnt == 0 meant that the power_supply
>>> wasn't fully registered yet, or if it had already been unregistered.
>>>
>>> Add a new boolean to the power_supply struct to simply show if
>>> registration is completed. Lastly, modify the check in
>>> power_supply_show_property() to also ignore -EAGAIN when so it
>>> doesn't complain about not returning the property.
>>>
>>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
>>> ---
>>> v2:
>>>  - Modify power_supply_show_property() to not complain if it
>>>    sees a return value of -EAGAIN after calling
>>>    power_supply_get_property().
>>>
>>>  drivers/power/power_supply_core.c  | 6 +++++-
>>>  drivers/power/power_supply_sysfs.c | 2 +-
>>>  include/linux/power_supply.h       | 1 +
>>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> I don't like it for two reasons:
>> 1. There is still a short window when the information will be
>> inaccurate. See comment below.
>>
>> 2. Although the code is not very complicated but it adds another field
>> and some checks just for differentiating EAGAIN/ENODEV. It is
>> unnecessary complexity.
>>
>>>
>>> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
>>> index b13cd074c52a..a39a47672979 100644
>>> --- a/drivers/power/power_supply_core.c
>>> +++ b/drivers/power/power_supply_core.c
>>> @@ -491,8 +491,11 @@ int power_supply_get_property(struct power_supply *psy,
>>>  			    enum power_supply_property psp,
>>>  			    union power_supply_propval *val)
>>>  {
>>> -	if (atomic_read(&psy->use_cnt) <= 0)
>>> +	if (atomic_read(&psy->use_cnt) <= 0) {
>>> +		if (!psy->initialized)
>>> +			return -EAGAIN;
>>>  		return -ENODEV;
>>> +	}
>>>  
>>>  	return psy->desc->get_property(psy, psp, val);
>>>  }
>>> @@ -775,6 +778,7 @@ __power_supply_register(struct device *parent,
>>>  	if (rc)
>>>  		goto create_triggers_failed;
>>>  
>>> +	psy->initialized = true;
>>
>> If someone calls power_supply_get_property() here, then ENODEV will be
>> returned which is wrong.
>>
>> The problem is not solved entirely... I am not convinced that introduced
>> complexity is worth fixing it.
>>
> 
> Right now, without this patch, this causes the thermal function
> "update_temperature" in:
> 
> thermal_zone_device_register->
>   thermal_zone_device_update->
>     update_temperature
>       (->thermal_zone_get_temp() from the original stack)
> 
> to print a warning as it sees ret != -EAGAIN. This causes a warning
> "failed to read out thermal zone". I think the idea there is if anything
> other than "try again" it complains. While this doesn't cause functional
> problems, I do think avoid the warning is worth while.
> 
> I think that there is an onus on the power_supply code to be accurate in
> its return codes, and EAGAIN is the correct one we should be returning.
> I don't see how someone would call power_supply_get_property, but I
> agree there is the possibility that if someone did call there, that it
> could return the wrong value.
> 
> We could wrap the setting of initialized and use_cnt inside a mutex,
> which should prevent anyone calling anything in between if we wanted to
> completely plug that hole. I am not fond of the idea of adding a struct
> member for such a small, specific case, but as we found before, I don't
> think there is another way to differentiate otherwise.
> 

Sebastian, do you have an opinion on this?

-rhyland


-- 
nvpublic
