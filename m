From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] thermal: add interface to support tune governor in run-time
Date: Thu, 9 Jan 2014 16:11:49 +0800
Message-ID: <52CE59C5.3040708@nvidia.com>
References: <1389172052-1484-1-git-send-email-wni@nvidia.com> <52CD48D6.2000906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52CD48D6.2000906-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/08/2014 08:47 PM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
> 
> On 08-01-2014 05:07, Wei Ni wrote:
>> The governers are not static, so added a new function
>> thermal_update_governor() to update a new one and throw away
>> old ones in run-time. And added start/stop callback to tuning governor
>> parameters at any time.
> 
> Please provide better explanation of why you need this. Providing use
> cases is good start.

Ok I can add explanation in my next patch version.

In the of-thermal driver, it register a thermal zone device without
governor, since the governers are not static, we should update a new one
in run-time, so I add a new fucntion thermal_update_governor().

> 
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/thermal/thermal_core.c |  103 ++++++++++++++++++++++++++++++++++++----
>>  drivers/thermal/thermal_core.h |    1 +
>>  include/linux/thermal.h        |   11 +++++
>>  3 files changed, 106 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 89e0637..be93f43 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -93,10 +93,17 @@ int thermal_register_governor(struct thermal_governor *governor)
>>                       name = pos->tzp->governor_name;
>>               else
>>                       name = DEFAULT_THERMAL_GOVERNOR;
>> -             if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
>> +             if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
>> +                     if (governor->start) {
>> +                             err = governor->start(pos);
>> +                             if (err < 0)
>> +                                     goto exit;
>> +                     }
>>                       pos->governor = governor;
>> +             }
>>       }
>>
>> +exit:
>>       mutex_unlock(&thermal_list_lock);
>>       mutex_unlock(&thermal_governor_lock);
>>
>> @@ -119,8 +126,11 @@ void thermal_unregister_governor(struct thermal_governor *governor)
>>
>>       list_for_each_entry(pos, &thermal_tz_list, node) {
>>               if (!strnicmp(pos->governor->name, governor->name,
>> -                                             THERMAL_NAME_LENGTH))
>> +                                             THERMAL_NAME_LENGTH)) {
>> +                     if (pos->governor->stop)
>> +                             pos->governor->stop(pos);
>>                       pos->governor = NULL;
>> +             }
>>       }
>>
>>       mutex_unlock(&thermal_list_lock);
>> @@ -130,6 +140,49 @@ exit:
>>       return;
>>  }
>>
>> +/**
>> + * thermal_update_governor() - update the thermal zone device's governor
>> + * to a new one.
>> + * @tzd: pointer of thermal zone device, which need to update governor.
>> + * @name: thermal zone name to fetch the temperature
>> + *
>> + * Return: On success returns 0, an error code otherwise
>> + */
>> +int thermal_update_governor(struct thermal_zone_device *tzd,
>> +                         const char *name)
>> +{
>> +     struct thermal_governor *old_gov, *new_gov;
>> +     int ret = 0;
>> +
>> +     mutex_lock(&thermal_governor_lock);
>> +
>> +     new_gov = __find_governor(name);
>> +     if (!new_gov) {
>> +             ret = -EINVAL;
>> +             goto exit;
>> +     }
>> +
>> +     old_gov = tzd->governor;
>> +
>> +     if (old_gov && old_gov->stop)
>> +             old_gov->stop(tzd);
>> +
>> +     if (new_gov->start) {
>> +             ret = new_gov->start(tzd);
>> +             if (ret < 0) {
>> +                     if (old_gov && old_gov->start)
>> +                             old_gov->start(tzd);
>> +                     goto exit;
>> +             }
>> +     }
>> +
>> +     tzd->governor = new_gov;
>> +
>> +exit:
>> +     mutex_unlock(&thermal_governor_lock);
>> +     return ret;
>> +}
>> +
>>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>>  {
>>       int ret;
>> @@ -734,22 +787,17 @@ policy_store(struct device *dev, struct device_attribute *attr,
>>  {
>>       int ret = -EINVAL;
>>       struct thermal_zone_device *tz = to_thermal_zone(dev);
>> -     struct thermal_governor *gov;
>>       char name[THERMAL_NAME_LENGTH];
>>
>>       snprintf(name, sizeof(name), "%s", buf);
>>
>> -     mutex_lock(&thermal_governor_lock);
>> -
>> -     gov = __find_governor(strim(name));
>> -     if (!gov)
>> +     ret = thermal_update_governor(tz, strim(name));
>> +     if (ret < 0)
>>               goto exit;
>>
>> -     tz->governor = gov;
>>       ret = count;
>>
>>  exit:
>> -     mutex_unlock(&thermal_governor_lock);
>>       return ret;
>>  }
>>
>> @@ -761,6 +809,24 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
>>       return sprintf(buf, "%s\n", tz->governor->name);
>>  }
>>
>> +static ssize_t
>> +available_policies_show(struct device *dev, struct device_attribute *devattr,
>> +                     char *buf)
>> +{
>> +     struct thermal_governor *pos;
>> +     ssize_t count = 0;
>> +
>> +     mutex_lock(&thermal_governor_lock);
>> +
>> +     list_for_each_entry(pos, &thermal_governor_list, governor_list)
>> +             count += sprintf(buf + count, "%s ", pos->name);
>> +     count += sprintf(buf + count, "\n");
>> +
>> +     mutex_unlock(&thermal_governor_lock);
>> +
>> +     return count;
>> +}
>> +
> 
> Adding an ABI requires documenting it under Documentation/
> 
> Besides, I believe this is a matter for a different patch than this one.

Oh yes, I will do it.

> 
>>  #ifdef CONFIG_THERMAL_EMULATION
>>  static ssize_t
>>  emul_temp_store(struct device *dev, struct device_attribute *attr,
>> @@ -794,6 +860,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
>>  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
>> +static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
>>
>>  /* sys I/F for cooling device */
>>  #define to_cooling_device(_dev)      \
>> @@ -1527,6 +1594,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>>       if (result)
>>               goto unregister;
>>
>> +     /* Create available_policies attribute */
>> +     result = device_create_file(&tz->device, &dev_attr_available_policies);
>> +     if (result)
>> +             goto unregister;
>> +
>>       /* Update 'this' zone's governor information */
>>       mutex_lock(&thermal_governor_lock);
>>
>> @@ -1535,6 +1607,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>>       else
>>               tz->governor = __find_governor(DEFAULT_THERMAL_GOVERNOR);
>>
>> +     if (tz->governor->start) {
>> +             result = tz->governor->start(tz);
>> +             if (result < 0)
>> +                     tz->governor = NULL;
>> +     }
>> +
>>       mutex_unlock(&thermal_governor_lock);
>>
>>       if (!tz->tzp || !tz->tzp->no_hwmon) {
>> @@ -1561,6 +1639,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>>               return tz;
>>
>>  unregister:
>> +     if (tz->governor && tz->governor->stop)
>> +             tz->governor->stop(tz);
>> +     tz->governor = NULL;
>>       release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>>       device_unregister(&tz->device);
>>       return ERR_PTR(result);
>> @@ -1622,7 +1703,11 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>>       if (tz->ops->get_mode)
>>               device_remove_file(&tz->device, &dev_attr_mode);
>>       device_remove_file(&tz->device, &dev_attr_policy);
>> +     device_remove_file(&tz->device, &dev_attr_available_policies);
>>       remove_trip_attrs(tz);
>> +
>> +     if (tz->governor && tz->governor->stop)
>> +             tz->governor->stop(tz);
>>       tz->governor = NULL;
>>
>>       thermal_remove_hwmon_sysfs(tz);
>> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
>> index 3db339f..89bcfe7 100644
>> --- a/drivers/thermal/thermal_core.h
>> +++ b/drivers/thermal/thermal_core.h
>> @@ -52,6 +52,7 @@ struct thermal_instance {
>>
>>  int thermal_register_governor(struct thermal_governor *);
>>  void thermal_unregister_governor(struct thermal_governor *);
>> +int thermal_update_governor(struct thermal_zone_device *, const char *);
>>
>>  #ifdef CONFIG_THERMAL_GOV_STEP_WISE
>>  int thermal_gov_step_wise_register(void);
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 37e4e03..ad9ab14 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -178,6 +178,7 @@ struct thermal_zone_device {
>>       struct thermal_zone_device_ops *ops;
>>       const struct thermal_zone_params *tzp;
>>       struct thermal_governor *governor;
>> +     void *governor_data;
>>       struct list_head thermal_instances;
>>       struct idr idr;
>>       struct mutex lock; /* protect thermal_instances list */
>> @@ -188,6 +189,15 @@ struct thermal_zone_device {
>>  /* Structure that holds thermal governor information */
>>  struct thermal_governor {
>>       char name[THERMAL_NAME_LENGTH];
>> +
>> +     /*
>> +      * The start and stop operations will be called when thermal zone is
>> +      * registered and when change governor via sysfs or driver in running
>> +      * time.
>> +      */
>> +     int (*start)(struct thermal_zone_device *tz);
>> +     void (*stop)(struct thermal_zone_device *tz);
>> +
> 
> But no explanation why a governor would need it is provided..

I think in the future, the governor will be more complex, it may want to
tune governor-specific parameters/configuration for different thermal
zone at different run-time, so I add start/stop for the governor and add
governor_data, so that the thermal driver can tune the governor
parameters in run-time.

> 
> 
>>       int (*throttle)(struct thermal_zone_device *tz, int trip);
>>       struct list_head        governor_list;
>>  };
>> @@ -235,6 +245,7 @@ struct thermal_zone_params {
>>        */
>>       bool no_hwmon;
>>
>> +     void *governor_params;
>>       int num_tbps;   /* Number of tbp entries */
>>       struct thermal_bind_params *tbp;
>>  };
>>
> 
> 
> --
> You have got to be excited about what you are doing. (L. Lamport)
> 
> Eduardo Valentin
> 
> 
> * Unknown Key
> * 0x75D0BCFD
> 
