From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] PM / Qos: Ensure device not in PRM_SUSPENDED when pm
 qos flags request functions are invoked in the pm core.
Date: Sat, 03 Nov 2012 00:16:51 +0800
Message-ID: <5093F1F3.5020004@intel.com>
References: <1351843430-8023-1-git-send-email-tianyu.lan@intel.com> <1888394.d23n1PsP9K@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45355 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab2KBQQy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Nov 2012 12:16:54 -0400
In-Reply-To: <1888394.d23n1PsP9K@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On 2012/11/2 19:17, Rafael J. Wysocki wrote:
> On Friday, November 02, 2012 04:03:50 PM Lan Tianyu wrote:
>> Since dev_pm_qos_add_request(), dev_pm_qos_update_request() and
>> dev_pm_qos_remove_request() for pm qos flags should not be invoked
>> when device in RPM_SUSPENDED. Add pm_runtime_get_sync() and pm_runtime_put()
>> around these functions in the pm core to ensure device not in RPM_SUSPENDED.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>   drivers/base/power/qos.c   |   10 ++++++++--
>>   drivers/base/power/sysfs.c |    4 ++++
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
>> index 31d3f48..b50ba72 100644
>> --- a/drivers/base/power/qos.c
>> +++ b/drivers/base/power/qos.c
>> @@ -624,15 +624,19 @@ int dev_pm_qos_expose_flags(struct device *dev, s32 val)
>>   	if (!req)
>>   		return -ENOMEM;
>>
>> +	pm_runtime_get_sync(dev);
>>   	ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_FLAGS, val);
>> +	pm_runtime_put(dev);
>
> I would drop this one ...
>
>>   	if (ret < 0)
>>   		return ret;
>>
>>   	dev->power.qos->flags_req = req;
>>   	ret = pm_qos_sysfs_add_flags(dev);
>> -	if (ret)
>> +	if (ret) {
>> +		pm_runtime_get_sync(dev);
>>   		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
>> -
>> +		pm_runtime_put(dev);
>
> ... and move this one before the return statement (plus a label for
> goto from the ret < 0 check after adding the request).
>
What you mean likes following?

+       pm_runtime_get_sync(dev);
         ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_FLAGS, val);
         if (ret < 0)
-               return ret;
+               goto fail;

         dev->power.qos->flags_req = req;
         ret = pm_qos_sysfs_add_flags(dev);
         if (ret)
                 __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);

+fail:
+       pm_runtime_put(dev);
         return ret;
  }

>> +	}
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_qos_expose_flags);
>> @@ -645,7 +649,9 @@ void dev_pm_qos_hide_flags(struct device *dev)
>>   {
>>   	if (dev->power.qos && dev->power.qos->flags_req) {
>>   		pm_qos_sysfs_remove_flags(dev);
>> +		pm_runtime_get_sync(dev);
>>   		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
>> +		pm_runtime_put(dev);
>
> I'm not sure if these two are necessary.  If we remove a request,
> then what happens worst case is that some flags will be cleared
> effectively which means fewer restrictions on the next sleep state.
> Then, it shouldn't hurt that the current sleep state is more
> restricted.

But this mean the device can be put into lower power state(power off).
So why not do that? that can save more power, right?
>
> Hmm.  Perhaps a comment would suffice?
>
>>   	}
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_qos_hide_flags);
>> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
>> index 50d16e3..240bfaa 100644
>> --- a/drivers/base/power/sysfs.c
>> +++ b/drivers/base/power/sysfs.c
>> @@ -264,7 +264,9 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
>>   	if (ret != 0 && ret != 1)
>>   		return -EINVAL;
>>
>> +	pm_runtime_get_sync(dev);
>>   	ret = dev_pm_qos_update_flags(dev, PM_QOS_FLAG_NO_POWER_OFF, ret);
>> +	pm_runtime_put(dev);
>>   	return ret < 0 ? ret : n;
>>   }
>
> Well, you haven't noticed that dev_pm_qos_update_flags() already does
> pm_runtime_get_sync()/pm_runtime_put(). :-)
Oh. Yeah. I ignore it. :)
>
>> @@ -291,7 +293,9 @@ static ssize_t pm_qos_remote_wakeup_store(struct device *dev,
>>   	if (ret != 0 && ret != 1)
>>   		return -EINVAL;
>>
>> +	pm_runtime_get_sync(dev);
>>   	ret = dev_pm_qos_update_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP, ret);
>> +	pm_runtime_put(dev);
>>   	return ret < 0 ? ret : n;
>>   }
>
> Thanks,
> Rafael
>
>


-- 
Best Regards
Tianyu Lan
linux kernel enabling team
