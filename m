From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH] drivers: thermal: do not clobber cooling dev state from
 userspace
Date: Tue, 14 Aug 2018 12:04:47 -0600
Message-ID: <20180814180447.GJ5081@codeaurora.org>
References: <20180507175505.2389-1-ilina@codeaurora.org>
 <1532595308.2358.45.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532595308.2358.45.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, rkumbako@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Adding Ram, so he can respond.
-- Lina

On Thu, Jul 26 2018 at 02:55 -0600, Zhang Rui wrote:
>On 一, 2018-05-07 at 11:55 -0600, Lina Iyer wrote:
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> Let userspace be another voter for cooling device state instead of
>> the
>> overriding authority. It is possible that the thermal governor may
>> find
>> a higher cooling state desirable than what is recommended by the
>> userspace. Separate out the current cooling device state from the
>> userspace request and aggregate the userspace request with the
>> governors' recommendation.
>>
>
>hmmm, I don't understand this.
>If the governor does not work well, we should either improve the
>governor or use userspace governor instead.
>do you have any examples that the kernel governor chooses improper
>cooling state?
>
>thanks,
>rui
>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/thermal/thermal_core.c    | 1 +
>>  drivers/thermal/thermal_helpers.c | 2 +-
>>  drivers/thermal/thermal_sysfs.c   | 8 +++++++-
>>  include/linux/thermal.h           | 1 +
>>  4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index 589925ac0994..c2e13e122934 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -970,6 +970,7 @@ __thermal_cooling_device_register(struct
>> device_node *np,
>>  	cdev->updated = false;
>>  	cdev->device.class = &thermal_class;
>>  	cdev->devdata = devdata;
>> +	cdev->sysfs_req = 0;
>>  	thermal_cooling_device_setup_sysfs(cdev);
>>  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>>  	result = device_register(&cdev->device);
>> diff --git a/drivers/thermal/thermal_helpers.c
>> b/drivers/thermal/thermal_helpers.c
>> index 2ba756af76b7..f550fdee0f9b 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -166,7 +166,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
>>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>>  {
>>  	struct thermal_instance *instance;
>> -	unsigned long target = 0;
>> +	unsigned long target = cdev->sysfs_req;
>>  
>>  	mutex_lock(&cdev->lock);
>>  	/* cooling device is updated*/
>> diff --git a/drivers/thermal/thermal_sysfs.c
>> b/drivers/thermal/thermal_sysfs.c
>> index 275ffee292bf..eddada715ad2 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -719,7 +719,13 @@ thermal_cooling_device_cur_state_store(struct
>> device *dev,
>>  	result = cdev->ops->set_cur_state(cdev, state);
>>  	if (result)
>>  		return result;
>> -	thermal_cooling_device_stats_update(cdev, state);
>> +
>> +	cdev->sysfs_req = state;
>> +	mutex_lock(&cdev->lock);
>> +	cdev->updated = false;
>> +	mutex_unlock(&cdev->lock);
>> +	thermal_cdev_update(cdev);
>> +
>>  	return count;
>>  }
>>  
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 5f4705f46c2f..7a133bd6ff86 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -139,6 +139,7 @@ struct thermal_cooling_device {
>>  	struct mutex lock; /* protect thermal_instances list */
>>  	struct list_head thermal_instances;
>>  	struct list_head node;
>> +	unsigned long sysfs_req;
>>  };
>>  
>>  struct thermal_attr {
