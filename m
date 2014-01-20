From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2 2/2] thermal: add interface to support tune governor
 in run-time
Date: Mon, 20 Jan 2014 16:47:15 +0800
Message-ID: <52DCE293.20704@nvidia.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com>	 <1389611863-7812-3-git-send-email-wni@nvidia.com>	 <1389946970.5918.46.camel@rzhang1-mobl4> <52D8F8BD.1080700@nvidia.com> <1390182093.9611.6.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19109 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaATIrT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2014 03:47:19 -0500
In-Reply-To: <1390182093.9611.6.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 01/20/2014 09:41 AM, Zhang Rui wrote:
> On Fri, 2014-01-17 at 17:32 +0800, Wei Ni wrote:
>> On 01/17/2014 04:22 PM, Zhang Rui wrote:
>>> On Mon, 2014-01-13 at 19:17 +0800, Wei Ni wrote:
>>>> In the of-thermal driver, it register a thermal zone device
>>>> without governor, since the governers are not static, we
>>>> should be able to update to a new one in run-time, so I add
>>>> a new fucntion thermal_update_governor() to do it.
>>>>
>>>> In the future, the governor will be more complex, it may want
>>>> to tune governor-specific parameters/configuration for
>>>> different thermal zone at different run-time, so I add
>>>> start/stop for the governor and add governor_data as governor's
>>>> parameters, so that the thermal platform driver can change
>>>> the governor with start/stop, and tune the governor parameters
>>>> in run-time.
>>>
>>> are you going to introduce a new governor with .start/.stop implemented
>>> or are you going to introduce .start/.stop callbacks for the current
>>> governors?
>>
>> We developed a new governor, based on PID logic. It will need some
>> parameters, such as proportional, integral and derivative. These values
>> will be initialized in different values for different thermal zone.
>> When the thermal driver use the pid governor, the thermal framework will
>> call the pid governor's .start(thz), and in the .start(), it will
>> allocate structures for those parameters, which are in the thermal zone,
>> something like:
>> int pid_thermal_gov_start(struct thermal_zone_device *tz)
>> {
>> ...
>> gov = kzalloc(sizeof(struct pid_thermal_governor), GFP_KERNEL);
>> gov->parameter_1 = tz->governor_params->parameter_1;
>> gov->parameter_2 = tz->governor_params->parameter_2;
>> ...
>> tz->governor_data = gov;
>>
>> /* and also will create ABI for the pid governor in this thermal zone */
>> }
>> So when run .throttle(), it can get those parameters from the
>> tz->governor_data to run.
>> And in the .stop, it will free those structures.
>>
>> I'm preparing the patches for the pid governor, and need to be reviewed
>> internal first, and then I will try to upstream them :)
>>
> sounds interesting.
> 
> but the problem is still that you're doing two things in this patch,
> one is to introduce runtime-governor tuning support,
> another is to introduce two new callbacks for thermal governor.
> 
> For me, I'd like to take a patch that does the first thing ONLY, right
> now, and I'd also like to see a patch that does the second thing,
> together with the new governor patches.

Ok, I will send the patch just for the thermal_update_governor() first.

Thanks.
Wei.

> 
> thanks,
> rui
>>>
>>> I'd like to see if there is any real request for this.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>> ---
>>>>  Documentation/thermal/sysfs-api.txt |    5 +++
>>>>  drivers/thermal/thermal_core.c      |   80 +++++++++++++++++++++++++++++++----
>>>>  include/linux/thermal.h             |   12 ++++++
>>>>  3 files changed, 88 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
>>>> index 6a70b55c..7efd8e6 100644
>>>> --- a/Documentation/thermal/sysfs-api.txt
>>>> +++ b/Documentation/thermal/sysfs-api.txt
>>>> @@ -405,3 +405,8 @@ platform data is provided, this uses the step_wise throttling policy.
>>>>  This function serves as an arbitrator to set the state of a cooling
>>>>  device. It sets the cooling device to the deepest cooling state if
>>>>  possible.
>>>> +
>>>> +5.5:thermal_update_governor:
>>>> +This function update the thermal zone's governor to a new one and update
>>>> +the governor data of the new governor for that thermal zone. Returns 0 if
>>>> +success, an erro code otherwise.
>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>> index aab1df8..d922baf 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -93,10 +93,17 @@ int thermal_register_governor(struct thermal_governor *governor)
>>>>                    name = pos->tzp->governor_name;
>>>>            else
>>>>                    name = DEFAULT_THERMAL_GOVERNOR;
>>>> -          if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
>>>> +          if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
>>>> +                  if (governor->start) {
>>>> +                          err = governor->start(pos);
>>>> +                          if (err < 0)
>>>> +                                  goto exit;
>>>> +                  }
>>>>                    pos->governor = governor;
>>>> +          }
>>>>    }
>>>>
>>>> +exit:
>>>>    mutex_unlock(&thermal_list_lock);
>>>>    mutex_unlock(&thermal_governor_lock);
>>>>
>>>> @@ -119,8 +126,11 @@ void thermal_unregister_governor(struct thermal_governor *governor)
>>>>
>>>>    list_for_each_entry(pos, &thermal_tz_list, node) {
>>>>            if (!strnicmp(pos->governor->name, governor->name,
>>>> -                                          THERMAL_NAME_LENGTH))
>>>> +                                          THERMAL_NAME_LENGTH)) {
>>>> +                  if (pos->governor->stop)
>>>> +                          pos->governor->stop(pos);
>>>>                    pos->governor = NULL;
>>>> +          }
>>>>    }
>>>>
>>>>    mutex_unlock(&thermal_list_lock);
>>>> @@ -130,6 +140,51 @@ exit:
>>>>    return;
>>>>  }
>>>>
>>>> +/**
>>>> + * thermal_update_governor() - update the thermal zone device's governor
>>>> + * to a new one.
>>>> + * @tzd: pointer of thermal zone device, which need to update governor.
>>>> + * @name: new governor name.
>>>> + * @gov_data: governor data for the new governor if needed.
>>>> + *
>>>> + * Return: On success returns 0, an error code otherwise
>>>> + */
>>>> +int thermal_update_governor(struct thermal_zone_device *tzd,
>>>> +                      const char *name, void *gov_data)
>>>> +{
>>>> +  struct thermal_governor *old_gov, *new_gov;
>>>> +  int ret = 0;
>>>> +
>>>> +  mutex_lock(&thermal_governor_lock);
>>>> +
>>>> +  new_gov = __find_governor(name);
>>>> +  if (!new_gov) {
>>>> +          ret = -EINVAL;
>>>> +          goto exit;
>>>> +  }
>>>> +
>>>> +  old_gov = tzd->governor;
>>>> +
>>>> +  if (old_gov && old_gov->stop)
>>>> +          old_gov->stop(tzd);
>>>> +
>>>> +  if (new_gov->start) {
>>>> +          ret = new_gov->start(tzd);
>>>> +          if (ret < 0) {
>>>> +                  if (old_gov && old_gov->start)
>>>> +                          old_gov->start(tzd);
>>>> +                  goto exit;
>>>> +          }
>>>> +  }
>>>> +
>>>> +  tzd->governor = new_gov;
>>>> +  tzd->governor_data = gov_data;
>>>> +
>>>> +exit:
>>>> +  mutex_unlock(&thermal_governor_lock);
>>>> +  return ret;
>>>> +}
>>>> +
>>>>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>>>>  {
>>>>    int ret;
>>>> @@ -734,22 +789,17 @@ policy_store(struct device *dev, struct device_attribute *attr,
>>>>  {
>>>>    int ret = -EINVAL;
>>>>    struct thermal_zone_device *tz = to_thermal_zone(dev);
>>>> -  struct thermal_governor *gov;
>>>>    char name[THERMAL_NAME_LENGTH];
>>>>
>>>>    snprintf(name, sizeof(name), "%s", buf);
>>>>
>>>> -  mutex_lock(&thermal_governor_lock);
>>>> -
>>>> -  gov = __find_governor(strim(name));
>>>> -  if (!gov)
>>>> +  ret = thermal_update_governor(tz, strim(name), NULL);
>>>> +  if (ret < 0)
>>>>            goto exit;
>>>>
>>>> -  tz->governor = gov;
>>>>    ret = count;
>>>>
>>>>  exit:
>>>> -  mutex_unlock(&thermal_governor_lock);
>>>>    return ret;
>>>>  }
>>>>
>>>> @@ -1559,6 +1609,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>>>>    else
>>>>            tz->governor = __find_governor(DEFAULT_THERMAL_GOVERNOR);
>>>>
>>>> +  if (tz->governor->start) {
>>>
>>> Note that tz->governor may be NULL at this time.
>>> although this seems like a bug to me.
>>
>> Yes, I have noticed this bug.
>> BTW, Eduardo have submitted a new patch to set the governor to default
>> governor [PATCH 1/1] thermal: fix default governor assignment .
>>
>> Anyway, in here, I should fix it as:
>> if (tz->governor && tz->governor->start)
>>
>>
>> Thanks.
>> Wei.
>>
>>>
>>>> +          result = tz->governor->start(tz);
>>>> +          if (result < 0)
>>>> +                  tz->governor = NULL;
>>>> +  }
>>>> +
>>> why not invoke thermal_update_governor() directly here?
>>
>> Oh, yes, we can invoke it here.
>>
>>>
>>> thanks,
>>> rui
>>>>    mutex_unlock(&thermal_governor_lock);
>>>>
>>>>    if (!tz->tzp || !tz->tzp->no_hwmon) {
>>>> @@ -1585,6 +1641,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>>>>            return tz;
>>>>
>>>>  unregister:
>>>> +  if (tz->governor && tz->governor->stop)
>>>> +          tz->governor->stop(tz);
>>>> +  tz->governor = NULL;
>>>>    release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>>>>    device_unregister(&tz->device);
>>>>    return ERR_PTR(result);
>>>> @@ -1648,6 +1707,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>>>>    device_remove_file(&tz->device, &dev_attr_policy);
>>>>    device_remove_file(&tz->device, &dev_attr_available_policies);
>>>>    remove_trip_attrs(tz);
>>>> +
>>>> +  if (tz->governor && tz->governor->stop)
>>>> +          tz->governor->stop(tz);
>>>>    tz->governor = NULL;
>>>>
>>>
>>>>    thermal_remove_hwmon_sysfs(tz);
>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>> index f7e11c7..a473736 100644
>>>> --- a/include/linux/thermal.h
>>>> +++ b/include/linux/thermal.h
>>>> @@ -177,6 +177,7 @@ struct thermal_zone_device {
>>>>    struct thermal_zone_device_ops *ops;
>>>>    const struct thermal_zone_params *tzp;
>>>>    struct thermal_governor *governor;
>>>> +  void *governor_data;
>>>>    struct list_head thermal_instances;
>>>>    struct idr idr;
>>>>    struct mutex lock; /* protect thermal_instances list */
>>>> @@ -187,6 +188,15 @@ struct thermal_zone_device {
>>>>  /* Structure that holds thermal governor information */
>>>>  struct thermal_governor {
>>>>    char name[THERMAL_NAME_LENGTH];
>>>> +
>>>> +  /*
>>>> +   * The start and stop operations will be called when thermal zone is
>>>> +   * registered and when change governor via sysfs or driver in running
>>>> +   * time.
>>>> +   */
>>>> +  int (*start)(struct thermal_zone_device *tz);
>>>> +  void (*stop)(struct thermal_zone_device *tz);
>>>> +
>>>>    int (*throttle)(struct thermal_zone_device *tz, int trip);
>>>>    struct list_head        governor_list;
>>>>  };
>>>> @@ -293,6 +303,8 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
>>>>            struct thermal_cooling_device *, int);
>>>>  void thermal_cdev_update(struct thermal_cooling_device *);
>>>>  void thermal_notify_framework(struct thermal_zone_device *, int);
>>>> +int thermal_update_governor(struct thermal_zone_device *, const char *,
>>>> +                      void *);
>>>>
>>>>  #ifdef CONFIG_NET
>>>>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>>>
>>>
>>
> 
> 


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
