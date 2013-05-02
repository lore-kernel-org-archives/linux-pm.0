From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] thermal: Can't set policy
Date: Wed, 01 May 2013 21:50:43 -0700
Message-ID: <5181F0A3.90005@linux.intel.com>
References: <1367008557-12443-1-git-send-email-srinivas.pandruvada@linux.intel.com> <517AEFC0.2010301@ti.com> <517B0E9D.6000904@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28797 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab3EBEpq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 May 2013 00:45:46 -0400
In-Reply-To: <517B0E9D.6000904@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org

Hi Valentin,

Any further thoughts?

Thanks,
Srinivas

On 04/26/2013 04:32 PM, Srinivas Pandruvada wrote:
> Hi Valentin,
>
> I planned to use that before , but it will change the semantics here.
>
> - Here comparison is using a case in-sensitive version, sysfs_streq is 
> case sensitive.
> - I am not sure if there is any protection for length. If we pass a 
> more than THERM_NAME_LENGTH string, then whether sysfs_streq can 
> handle. so we need to pre-check for length.
> - some stupid echo command with CRLF, will still fail
> I see that some other syfs string write (eg. cpufreq.c) decided not to 
> use sysfs_streq, may be historical.
>
> Thanks,
> Srinivas
>
>
> On 04/26/2013 02:21 PM, Eduardo Valentin wrote:
>> Hello Srinivas,
>>
>> On 26-04-2013 16:35, Srinivas Pandruvada wrote:
>>> Setting policy results in invalid value error.
>>>     >echo "step_wise" > policy
>>>     >echo: write error: Invalid argument
>>>
>>> Need clean up of the buffer which "echo" may add based on the
>>> arguments, before comparing aganist list of governor names.
>>>
>>> Signed-off-by: Srinivas Pandruvada 
>>> <srinivas.pandruvada@linux.intel.com>
>>> ---
>>>   drivers/thermal/thermal_core.c | 19 +++++++++++++++----
>>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c 
>>> b/drivers/thermal/thermal_core.c
>>> index 4cdc3e3..ed6904f 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -696,16 +696,27 @@ static ssize_t
>>>   policy_store(struct device *dev, struct device_attribute *attr,
>>>               const char *buf, size_t count)
>>>   {
>>> -    int ret = -EINVAL;
>>> +    int ret;
>>>       struct thermal_zone_device *tz = to_thermal_zone(dev);
>>>       struct thermal_governor *gov;
>>> +    char str_gov[THERMAL_NAME_LENGTH];
>>> +    char format[6]; /* enough for 3 digit format width */
>>> +
>>> +    ret = snprintf(format, sizeof(format), "%%%ds",
>>> +                    THERMAL_NAME_LENGTH - 1);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +    ret = sscanf(buf, format, str_gov);
>>> +    if (ret <= 0)
>>> +        return -EINVAL;
>>
>>
>> Is this due to trainling \n? Why not using sysfs_streq()? I believe 
>> it is better approach. Can you please check if the following solves 
>> the issue?
>>
>> https://gitorious.org/thermal-framework/thermal-framework/commit/810a33a629b40adfa92a164883281bbdfad80516 
>>
>>
>> commit 810a33a629b40adfa92a164883281bbdfad80516
>> Author: Eduardo Valentin <eduardo.valentin@ti.com>
>> Date:   Fri Apr 26 17:12:30 2013 -0400
>>
>>     thermal: better string treatment while finding governors
>>
>>     To avoid returning error value just because of trailing
>>     \n, this patch changes the function to find governors
>>     by name to use sysfs_streq().
>>
>>     Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>
>> diff --git a/drivers/thermal/thermal_core.c 
>> b/drivers/thermal/thermal_core.c
>> index f36cd44..08ea62c 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -58,7 +58,7 @@ static struct thermal_governor 
>> *__find_governor(const char *name)
>>         struct thermal_governor *pos;
>>
>>         list_for_each_entry(pos, &thermal_governor_list, governor_list)
>> -               if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
>> +               if (sysfs_streq(name, pos->name))
>>                         return pos;
>>
>>         return NULL;
>>
>>>
>>>       mutex_lock(&thermal_governor_lock);
>>>
>>> -    gov = __find_governor(buf);
>>> -    if (!gov)
>>> +    gov = __find_governor(str_gov);
>>> +    if (!gov) {
>>> +        ret = -EINVAL;
>>>           goto exit;
>>> -
>>> +    }
>>>       tz->governor = gov;
>>>       ret = count;
>>>
>>>
>>
>>
>
>

