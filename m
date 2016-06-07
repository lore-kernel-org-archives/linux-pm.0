From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 02/15] thermal: sysfs: lock tz while on access to mode
 properties
Date: Tue, 7 Jun 2016 14:52:07 +0530
Message-ID: <5756923F.6010007@ti.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
 <1464676296-5610-3-git-send-email-edubezval@gmail.com>
 <57568F08.2070307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57568F08.2070307@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "R, Vignesh" <vigneshr@ti.com>
List-Id: linux-pm@vger.kernel.org



On Tuesday 07 June 2016 02:38 PM, Keerthy wrote:
> Hi Eduardo,
>
> On Tuesday 31 May 2016 12:01 PM, Eduardo Valentin wrote:
>> Serialized calls to tz.ops in user facing
>> sysfs handler mode_show()  and mode_store().
>
> This seems to be causing a deadlock at boot time during the ending
> stages of boot:
>
> http://pastebin.ubuntu.com/17085291/
>
> It took a while to git bisect on linux-next.
>
> Seems like you introduced new locking at the sysfs layer which causes
> this deadlock as the underlying code again tries to acquire the same
> tz->lock.

I confirm reverting this patch helps me boot on linux-next. This patch 
can be dropped as the lower layer functions are already acquiring tz->lock.

Thanks Vignesh for reporting the deadlock.

Regards,
Keerthy

>
> Regards,
> Keerthy
>
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
>> ---
>>   drivers/thermal/thermal_sysfs.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_sysfs.c
>> b/drivers/thermal/thermal_sysfs.c
>> index ee983ca..1db2406 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -62,7 +62,9 @@ mode_show(struct device *dev, struct
>> device_attribute *attr, char *buf)
>>       if (!tz->ops->get_mode)
>>           return -EPERM;
>>
>> +    mutex_lock(&tz->lock);
>>       result = tz->ops->get_mode(tz, &mode);
>> +    mutex_unlock(&tz->lock);
>>       if (result)
>>           return result;
>>
>> @@ -75,17 +77,22 @@ mode_store(struct device *dev, struct
>> device_attribute *attr,
>>          const char *buf, size_t count)
>>   {
>>       struct thermal_zone_device *tz = to_thermal_zone(dev);
>> +    enum thermal_device_mode mode = THERMAL_DEVICE_DISABLED;
>>       int result;
>>
>>       if (!tz->ops->set_mode)
>>           return -EPERM;
>>
>>       if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
>> -        result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
>> +        mode = THERMAL_DEVICE_ENABLED;
>>       else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
>> -        result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
>> +        mode = THERMAL_DEVICE_DISABLED;
>>       else
>> -        result = -EINVAL;
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&tz->lock);
>> +    result = tz->ops->set_mode(tz, mode);
>> +    mutex_unlock(&tz->lock);
>>
>>       if (result)
>>           return result;
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
