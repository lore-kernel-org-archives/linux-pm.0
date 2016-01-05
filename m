From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2] thermal: re-calculate k_po/k_pu when update
 sustainable power
Date: Tue, 5 Jan 2016 18:02:57 +0000
Message-ID: <568C0551.6040308@linaro.org>
References: <1451471920-2148-1-git-send-email-leo.yan@linaro.org>
 <20151231172125.GA11863@localhost.localdomain>
 <20160101000347.GA2572@leoy-linaro> <568A55F2.10800@linaro.org>
 <20160105163328.GB3163@e104805> <568BF461.9090405@linaro.org>
 <87si2c2adq.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35633 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbcAESDA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2016 13:03:00 -0500
Received: by mail-wm0-f52.google.com with SMTP id f206so32589031wmf.0
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2016 10:03:00 -0800 (PST)
In-Reply-To: <87si2c2adq.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Javi Merino <javi.merino@arm.com>, Leo Yan <leo.yan@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/01/16 17:40, Punit Agrawal wrote:
> Daniel Thompson <daniel.thompson@linaro.org> writes:
>
>> On 05/01/16 16:33, Javi Merino wrote:
>>> On Mon, Jan 04, 2016 at 11:22:26AM +0000, Daniel Thompson wrote:
>>>> On 01/01/16 00:03, Leo Yan wrote:
>>>>> Hi Eduardo,
>>>>>
>>>>> Thanks for review.
>>>>>
>>>>> On Thu, Dec 31, 2015 at 09:21:26AM -0800, Eduardo Valentin wrote:
>>>>>> On Wed, Dec 30, 2015 at 06:38:40PM +0800, Leo Yan wrote:
>>>>>>> k_po/k_pu are in essence ratio values compared with sustainable power.
>>>>>>> So when update sustainable power, we can recalculate k_po/k_pu simply
>>>>>>> with below formula:
>>>>>>>
>>>>>>>                  sustainable_power(new)
>>>>>>>       k_p(new) = ---------------------- * k_p(old)
>>>>>>>                  sustainable_power(old)
>>>>>>>
>>>>>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>>>>>> ---
>>>>>>>    drivers/thermal/thermal_core.c | 6 +++++-
>>>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>>>>> index d9e525c..223f8df 100644
>>>>>>> --- a/drivers/thermal/thermal_core.c
>>>>>>> +++ b/drivers/thermal/thermal_core.c
>>>>>>> @@ -908,7 +908,7 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
>>>>>>>    			const char *buf, size_t count)
>>>>>>>    {
>>>>>>>    	struct thermal_zone_device *tz = to_thermal_zone(dev);
>>>>>>> -	u32 sustainable_power;
>>>>>>> +	u32 sustainable_power, old_val;
>>>>>>>
>>>>>>>    	if (!tz->tzp)
>>>>>>>    		return -EIO;
>>>>>>> @@ -916,8 +916,12 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
>>>>>>>    	if (kstrtou32(buf, 10, &sustainable_power))
>>>>>>>    		return -EINVAL;
>>>>>>>
>>>>>>> +	old_val = tz->tzp->sustainable_power;
>>>>>>> +
>>>>>>>    	tz->tzp->sustainable_power = sustainable_power;
>>>>>>>
>>>>>>> +	tz->tzp->k_po = (tz->tzp->k_po * sustainable_power) / old_val;
>>>>>>> +	tz->tzp->k_pu = (tz->tzp->k_pu * sustainable_power) / old_val;
>>>>>>
>>>>>> I believe this has to be done by the governor. These properties are
>>>>>> power_allocator specific. thermal_core should not really care about
>>>>>> them.
>>>>>
>>>>> Okay, I will try to update these properties in power_allocator.c.
>>>>> Javi, do you think this is fine for you?
>>>>
>>>> If sustainable power were to change frequently (perhaps on
>>>> entry/exit of a fan inhibitor mode?) then we would accumulate
>>>> rounding errors here...
>>>
>>> Can you elaborate on the use case?  What is this fan inhibitor mode?
>>
>> It's made up.
>>
>> I was trying to think of use cases which might result in the userspace
>> wishing to make frequent changes the maximum sustainable power. For
>> designs where the system remains thermally overcommited even with the
>> fan running then having a mode where the fan must not spin up would
>> require such a change.
>
> If there isn't an immediate use case, we should hold off making any
> changes until they're really needed.

Fair point but do note that the fan inhibition comments were used to 
illustrate a bug in the patch. They were not an argument for (or 
against) the value of patch itself.


Daniel.
