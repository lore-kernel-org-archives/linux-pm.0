From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: Re: Fix: Bind Cooling Device Weight
Date: Mon, 22 Dec 2014 16:36:26 +0000
Message-ID: <5498488A.6080209@arm.com>
References: <5492C634.5030604@arm.com> <20141218134334.GA6276@developer>	 <54930473.2060901@arm.com> <1419218610.19619.10.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48048 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbaLVQga convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Dec 2014 11:36:30 -0500
In-Reply-To: <1419218610.19619.10.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>

Many thanks for looking through this! Had a few observations regarding
the same:
On 22/12/14 03:23, Zhang Rui wrote:
> On Thu, 2014-12-18 at 16:44 +0000, Kapileshwar Singh wrote:
>> Thanks for Reviewing this!
>>
>> On 18/12/14 13:43, Eduardo Valentin wrote:
>>> On Thu, Dec 18, 2014 at 12:19:00PM +0000, Kapileshwar Singh wrote:
>>>> The Problem:
>>>>
>>>> In the current code, the weight of the cooling device, which is read as
>>>> contribution from the device tree in of-thermal.c as:
>>>>
>>>>
>>>>         ret = of_property_read_u32(np, "contribution", &prop);
>>>>         if (ret == 0)
>>>>                 __tbp->usage = prop;
>>>>
>>>> This is only stored in the private devicedata as:
>>>>
>>>>         ((__thernal_zone *)cdev->devdata)->__tbp->usage
>>>>
>>>> As of-thermal.c specifies its "bind" operation and does not populate
>>>> tzd->tzp->tbp, this causes an erroneous access in the fair-share
>>>> governor when it tries to access the weight:
>>>>
>>>> instance->target = get_target_state(tz, cdev,
>>>>                                         tzp->tbp[i].weight,
>>>> cur_trip_level);
>>>>
>>>>
>>>> The Proposed solution:
>>>>
>>>> The proposed solution has the following changes:
>>>>
>>>>  1. Passing the weight as an argument to thermal_zone_bind_cooling_device
>>>>
>>>>  2. Storing the weight in the thermal_instance data structure created in
>>>> the thermal_zone_bind_cooling_device function
>>>>
>>>>  3. Changing the accesses in the governor accordingly.
>>> Shouldn't we simply:
>>> 1. In of-thermal, populate tzd->tzp->tbp by passing a tbp with correct
>>> tbp's in the registration call:
>>>     zone = thermal_zone_device_register(child->name, tz->ntrips,
>>>                                             0,
>>>                                             tz,
>>>                                             ops,
>>> /* This guy needs to be filled properly */  tzp,
>>>                                             tz->passive_delay,
>>>                                             tz->polling_delay);
>> The reason why I think this might not work is because we do not have the cooling device information (pointer) when we register the thermal zone device.
>>
> and I think that is why .match() callback in struct thermal_bind_params
> is introduced.
of-thermal defines a bind function and stores the binding information in
a private data structure.

Looking at the code where a cooling device is bound
there seem to be two options:

1. There is a bind operation defined that figures out a set of bind
parameters and the cooling device associated with them (ops->bind)
   and calls back into thermal_zone_bind_cooling_device.

2. Or there can be bind parameters (tbp) defined that specify a match
operation to match the cooling device to the thermal zone device.

1 and 2 being mutually exclusive as follows (in thermal-core.c: bind_tz
and bind_cdev:

                if (pos->ops->bind) {
                        ret = pos->ops->bind(pos, cdev);
                        if (ret)
                                print_bind_err_msg(pos, cdev, ret);
                        continue;
                }

                tzp = pos->tzp;
                if (!tzp || !tzp->tbp)
                        continue;

                for (i = 0; i < tzp->num_tbps; i++) {
                        if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
                                continue;
                        if (tzp->tbp[i].match(pos, cdev))
                                continue;
                        tzp->tbp[i].cdev = cdev;
                        __bind(pos, tzp->tbp[i].trip_mask, cdev,
                               tzp->tbp[i].binding_limits);
                }

the match function wont be called if a tz->ops->bind is defined.

The fix suggested above would involve the removal of the
__thermal_zone and __thermal_bind_params private data structures and
also removing the bind operation from of-thermal.c.
Would that be a direction we would like to proceed in?

I also think since thermal_instance is populated by
thermal_zone_bind_cooling_device and represents a "bound" configuration
for both the branches (ops->bind and .match()) it could make sense to
add weight as a part of the thermal_instance as something
that is a part of the "bound" configuration.

I do realize that I could be completely wrong here and would appreciate
if you can point me towards the right direction.

Regards,
KP


thanks, rui
>>> 2. Add a proper check in the governor to avoid accessing thermal zones
>>> with missing data.
>>>
>>> I know there is a check in place:
>>>         if (!tz->tzp || !tz->tzp->tbp)
>>>               return -EINVAL;
>>>
>>> which based in your description seams to be failing. Here, I need more
>>> info from your side describing what exactly you are seeing. Can you
>>> please post the kernel log when the failure happens? Does it output a
>>> kernel segfault or is the governor simply not working?
>> There is no crash as such, it is more of a semantic failure where the weight being read from the device tree is not passed to the bind parameters.
>>
>> Cheers!
>> KP
>>
>>
>>> I would expect, with the current code, the governor be silent and
>>> non-functional, which needs to be fixed too.
>>>>  I am not sure of what default value should be assigned to the weight
>>>> member in the instance data structure and would like to leave this open
>>>> to discussion.
>>>>
>>>> Suggested Patch (Not Signed off):
>>>>
>>>> diff --git a/drivers/thermal/db8500_thermal.c
>>>> b/drivers/thermal/db8500_thermal.c
>>>> index 1e3b3bf9f993..e3ccc2218eb3 100644
>>>> --- a/drivers/thermal/db8500_thermal.c
>>>> +++ b/drivers/thermal/db8500_thermal.c
>>>> @@ -76,7 +76,7 @@ static int db8500_cdev_bind(struct thermal_zone_device
>>>> *thermal,
>>>>          upper = lower = i > max_state ? max_state : i;
>>>>
>>>>          ret = thermal_zone_bind_cooling_device(thermal, i, cdev,
>>>> -            upper, lower);
>>>> +            upper, lower, THERMAL_WEIGHT_DEFAULT);
>>>>
>>> I think spreading such parameter, which is known to be part of tbp, is
>>> not a good thing to do. Can we avoid that?
>>>
>>>
>>> Cheers, Eduardo
>>>>          dev_info(&cdev->device, "%s bind to %d: %d-%s\n", cdev->type,
>>>>              i, ret, ret ? "fail" : "succeed");
>>>> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
>>>> index 6e0a3fbfae86..c3b25187b467 100644
>>>> --- a/drivers/thermal/fair_share.c
>>>> +++ b/drivers/thermal/fair_share.c
>>>> @@ -109,7 +109,7 @@ static int fair_share_throttle(struct
>>>> thermal_zone_device *tz, int trip)
>>>>              continue;
>>>>
>>>>          instance->target = get_target_state(tz, cdev,
>>>> -                    tzp->tbp[i].weight, cur_trip_level);
>>>> +                    instance->weight, cur_trip_level);
>>>>
>>>>          instance->cdev->updated = false;
>>>>          thermal_cdev_update(cdev);
>>>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
>>>> index 5a1f1070b702..74d0c9951eef 100644
>>>> --- a/drivers/thermal/imx_thermal.c
>>>> +++ b/drivers/thermal/imx_thermal.c
>>>> @@ -307,7 +307,8 @@ static int imx_bind(struct thermal_zone_device *tz,
>>>>
>>>>      ret = thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
>>>>                             THERMAL_NO_LIMIT,
>>>> -                           THERMAL_NO_LIMIT);
>>>> +                           THERMAL_NO_LIMIT
>>>> +                           THERMAL_WEIGHT_DEFAULT);
>>>>      if (ret) {
>>>>          dev_err(&tz->device,
>>>>              "binding zone %s with cdev %s failed:%d\n",
>>>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>>>> index e032b9bf4085..cf4036cbb671 100644
>>>> --- a/drivers/thermal/of-thermal.c
>>>> +++ b/drivers/thermal/of-thermal.c
>>>> @@ -157,7 +157,8 @@ static int of_thermal_bind(struct
>>>> thermal_zone_device *thermal,
>>>>              ret = thermal_zone_bind_cooling_device(thermal,
>>>>                          tbp->trip_id, cdev,
>>>>                          tbp->max,
>>>> -                        tbp->min);
>>>> +                        tbp->min,
>>>> +                        tbp->usage);
>>>>              if (ret)
>>>>                  return ret;
>>>>          }
>>>> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c
>>>> b/drivers/thermal/samsung/exynos_thermal_common.c
>>>> index b6be572704a4..d653798b519f 100644
>>>> --- a/drivers/thermal/samsung/exynos_thermal_common.c
>>>> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
>>>> @@ -163,7 +163,7 @@ static int exynos_bind(struct thermal_zone_device
>>>> *thermal,
>>>>          case MONITOR_ZONE:
>>>>          case WARN_ZONE:
>>>>              if (thermal_zone_bind_cooling_device(thermal, i, cdev,
>>>> -                                level, 0)) {
>>>> +                                level, 0, THERMAL_WEIGHT_DEFAULT)) {
>>>>                  dev_err(data->dev,
>>>>                      "error unbinding cdev inst=%d\n", i);
>>>>                  ret = -EINVAL;
>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>> index 4921e084c20b..199866864ef1 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -277,7 +277,8 @@ static void print_bind_err_msg(struct
>>>> thermal_zone_device *tz,
>>>>
>>>>  static void __bind(struct thermal_zone_device *tz, int mask,
>>>>              struct thermal_cooling_device *cdev,
>>>> -            unsigned long *limits)
>>>> +            unsigned long *limits,
>>>> +            unsigned int weight)
>>>>  {
>>>>      int i, ret;
>>>>
>>>> @@ -292,7 +293,8 @@ static void __bind(struct thermal_zone_device *tz,
>>>> int mask,
>>>>                  upper = limits[i * 2 + 1];
>>>>              }
>>>>              ret = thermal_zone_bind_cooling_device(tz, i, cdev,
>>>> -                                   upper, lower);
>>>> +                                   upper, lower,
>>>> +                                   weight);
>>>>              if (ret)
>>>>                  print_bind_err_msg(tz, cdev, ret);
>>>>          }
>>>> @@ -339,7 +341,8 @@ static void bind_cdev(struct thermal_cooling_device
>>>> *cdev)
>>>>                  continue;
>>>>              tzp->tbp[i].cdev = cdev;
>>>>              __bind(pos, tzp->tbp[i].trip_mask, cdev,
>>>> -                   tzp->tbp[i].binding_limits);
>>>> +                   tzp->tbp[i].binding_limits,
>>>> +                   tzp->tbp[i].weight);
>>>>          }
>>>>      }
>>>>
>>>> @@ -378,7 +381,8 @@ static void bind_tz(struct thermal_zone_device *tz)
>>>>                  continue;
>>>>              tzp->tbp[i].cdev = pos;
>>>>              __bind(tz, tzp->tbp[i].trip_mask, pos,
>>>> -                   tzp->tbp[i].binding_limits);
>>>> +                   tzp->tbp[i].binding_limits,
>>>> +                   tzp->tbp[i].weight);
>>>>          }
>>>>      }
>>>>  exit:
>>>> @@ -770,7 +774,8 @@ passive_store(struct device *dev, struct
>>>> device_attribute *attr,
>>>>                  thermal_zone_bind_cooling_device(tz,
>>>>                          THERMAL_TRIPS_NONE, cdev,
>>>>                          THERMAL_NO_LIMIT,
>>>> -                        THERMAL_NO_LIMIT);
>>>> +                        THERMAL_NO_LIMIT,
>>>> +                        THERMAL_WEIGHT_DEFAULT);
>>>>          }
>>>>          mutex_unlock(&thermal_list_lock);
>>>>          if (!tz->passive_delay)
>>>> @@ -1009,7 +1014,9 @@ thermal_cooling_device_trip_point_show(struct
>>>> device *dev,
>>>>   * @lower:    the Minimum cooling state can be used for this trip point.
>>>>   *        THERMAL_NO_LIMIT means no lower limit,
>>>>   *        and the cooling device can be in cooling state 0.
>>>> - *
>>>> + * @weight:    The weight of the cooling device to be bound to the
>>>> +        thermal zone. THERMAL_WEIGHT_DEFAULT for default value
>>>> +
>>>>   * This interface function bind a thermal cooling device to the certain
>>>> trip
>>>>   * point of a thermal zone device.
>>>>   * This function is usually called in the thermal zone device .bind
>>>> callback.
>>>> @@ -1019,7 +1026,8 @@ thermal_cooling_device_trip_point_show(struct
>>>> device *dev,
>>>>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>>>>                       int trip,
>>>>                       struct thermal_cooling_device *cdev,
>>>> -                     unsigned long upper, unsigned long lower)
>>>> +                     unsigned long upper, unsigned long lower,
>>>> +                     unsigned int weight)
>>>>  {
>>>>      struct thermal_instance *dev;
>>>>      struct thermal_instance *pos;
>>>> @@ -1062,6 +1070,7 @@ int thermal_zone_bind_cooling_device(struct
>>>> thermal_zone_device *tz,
>>>>      dev->upper = upper;
>>>>      dev->lower = lower;
>>>>      dev->target = THERMAL_NO_TARGET;
>>>> +    dev->weight = weight;
>>>>
>>>>      result = get_idr(&tz->idr, &tz->lock, &dev->id);
>>>>      if (result)
>>>> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
>>>> index b907be823527..1c61abe7801f 100644
>>>> --- a/drivers/thermal/thermal_core.h
>>>> +++ b/drivers/thermal/thermal_core.h
>>>> @@ -48,6 +48,7 @@ struct thermal_instance {
>>>>      struct device_attribute attr;
>>>>      struct list_head tz_node; /* node in tz->thermal_instances */
>>>>      struct list_head cdev_node; /* node in cdev->thermal_instances */
>>>> +    unsigned int weight; /* The weight of the cooling device */
>>>>  };
>>>>
>>>>  int thermal_register_governor(struct thermal_governor *);
>>>> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>>>> b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>>>> index 9eec26dc0448..772549ec9bd8 100644
>>>> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>>>> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>>>> @@ -147,7 +147,8 @@ static int ti_thermal_bind(struct
>>>> thermal_zone_device *thermal,
>>>>      return thermal_zone_bind_cooling_device(thermal, 0, cdev,
>>>>      /* bind with min and max states defined by cpu_cooling */
>>>>                          THERMAL_NO_LIMIT,
>>>> -                        THERMAL_NO_LIMIT);
>>>> +                        THERMAL_NO_LIMIT,
>>>> +                        THERMAL_WEIGHT_DEFAULT);
>>>>  }
>>>>
>>>>  /* Unbind callback functions for thermal zone */
>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>> index fc4fdcbbdecc..674795ba0900 100644
>>>> --- a/include/linux/thermal.h
>>>> +++ b/include/linux/thermal.h
>>>> @@ -40,6 +40,9 @@
>>>>  /* No upper/lower limit requirement */
>>>>  #define THERMAL_NO_LIMIT    ((u32)~0)
>>>>
>>>> +/* Default weight of a bound cooling device */
>>>> +#define THERMAL_WEIGHT_DEFAULT 1
>>>> +
>>>>  /* Unit conversion macros */
>>>>  #define KELVIN_TO_CELSIUS(t)    (long)(((long)t-2732 >= 0) ?    \
>>>>                  ((long)t-2732+5)/10 : ((long)t-2732-5)/10)
>>>> @@ -375,7 +378,8 @@ void thermal_zone_device_unregister(struct
>>>> thermal_zone_device *);
>>>>
>>>>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>>>>                       struct thermal_cooling_device *,
>>>> -                     unsigned long, unsigned long);
>>>> +                     unsigned long, unsigned long,
>>>> +                     unsigned int);
>>>>  int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
>>>>                         struct thermal_cooling_device *);
>>>>  void thermal_zone_device_update(struct thermal_zone_device *);
>>>>
>>>>
>>
>
>


