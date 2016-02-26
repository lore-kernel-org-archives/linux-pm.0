From: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC][PATCH] thermal: add sysfs_notify on some attributes
Date: Thu, 25 Feb 2016 16:24:45 -0800
Message-ID: <56CF9B4D.4020704@nvidia.com>
References: <1456287118-32510-1-git-send-email-srikars@nvidia.com>
 <1456345360.3860.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456345360.3860.9.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 02/24/2016 12:24 PM, Pandruvada, Srinivas wrote:
> On Tue, 2016-02-23 at 20:11 -0800, Srikar Srimath Tirumala wrote:
>> Add a sysfs_notify on thermal_zone*/temp and cooling_device*/
>> cur_state whenever a passive or critical trip is triggered.
>>
>> This change allows usermode apps to register itself to get notified,
>> when certain thermal conditions occur and reduce their workload.
>> This workload throttling can reduce\prevent throttling of hardware
>> clocks while allowing some other critical apps to run longer
>> reliably.
>> Signed-off-by: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/thermal/thermal_core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index a0a8fd1..d8d257d 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -567,6 +567,8 @@ void thermal_zone_device_update(struct
>> thermal_zone_device *tz)
>>
>>   	for (count = 0; count < tz->trips; count++)
>>   		handle_thermal_trip(tz, count);
>> +
>> +	sysfs_notify(&tz->device.kobj, NULL, "temp");
> When user space governor is used this will result in two notifications
> to user space.
Agreed, when the first trip point is violated it would result in two
notifications. But this change was also supposed to address the cooling
cur state change that results from governor throttling after a trip
point is violated. I realize this intent was not communicated well in
the commit message, Patch V2 will fix it.
> Also you want when a trip is violated. For some driver there will be
> too many calls from irq thread, so you may want in handle_thermal_trip
> when a trip is violated.
Agreed, Patch V2 will do the notify only once per thermal zone and only
when there is a trip violation.
>
> Thanks,
> Srinivas
>>   }
>>   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>>
>> @@ -1638,6 +1640,7 @@ void thermal_cdev_update(struct
>> thermal_cooling_device *cdev)
>>   	cdev->updated = true;
>>   	trace_cdev_update(cdev, target);
>>   	dev_dbg(&cdev->device, "set to state %lu\n", target);
>> +	sysfs_notify(&cdev->device.kobj, NULL, "cur_state");
>>   }
>>   EXPORT_SYMBOL(thermal_cdev_update);
>>
Thanks for your inputs Srinivas, please take a look at Patch V2 that
addresses your comments.
Best Regards
Srikar
