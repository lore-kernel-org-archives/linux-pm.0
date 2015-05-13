From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: validate callback for menu governor
Date: Wed, 13 May 2015 10:37:31 +0200
Message-ID: <CAKXjFTO-dNpE7PtUS56xwV5=YmkBrqMm8KvQ-B2-1AQOwEKz-g@mail.gmail.com>
References: <CAKXjFTN7HBGNMBuxh8E8FaACG3xgYuLKYHs6vbQq7WtvKLttrw@mail.gmail.com>
	<2016693.8fDGBo5Ojl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34932 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933001AbbEMIhc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 04:37:32 -0400
Received: by oign205 with SMTP id n205so25733725oig.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2015 01:37:31 -0700 (PDT)
In-Reply-To: <2016693.8fDGBo5Ojl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM list <linux-pm@vger.kernel.org>, =?UTF-8?Q?Bartosz_Go=C5=82aszewski?= <bgolaszewski@baylibre.com>, Benoit Cousson <bcousson@baylibre.com>

Hi Rafael,

On Wed, May 13, 2015 at 2:13 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, May 12, 2015 06:30:38 PM Axel Haslam wrote:
>> Hi,
>>
>> Recently a question about cpuidle and cluster off states came
>> up in a separate discussion [1].
>>
>> The question is if it would be useful to add a "validate" callback in the
>> cpuidle menu governor. Cpuidle drivers could use this callback to check if
>> entering a cluster off state by the "last man" would not violate the target
>> residency requirements.
>
> So consider how it works in the platform-coordinated mode.  CPUs requrest a
> certain cluster state and the platform records the requests.  It doesn't
> record the expected wakeup times, though, but only who requested what state
> and uses that information to determine what wakeup latency is acceptable
> worst-case.
>
> Should the OS-coordinated variant work differently?

at least on the os-coordinated variant,  the menu governor
has a rough idea when the cpus will wake up. i thought we could
use that prediction to avoid cluster off's that are too short.
but as you mention below, target residency is not a critical
parameter, so its just better to accept that we might wakeup
shortly after a cluster is turned off.


>
>> i think the same problem is explained at the top of
>> ./drivers/cpuidle/cpuidle-big_little.c,
>> so im sorry if this was addressed before.
>>
>> To illustrate the scenario, on a system where cpu0 and cpu1 are in the same
>> cluster and where the target residency time for the cluster off state is 5ms,
>> imagine that:
>>
>> cpu 1 enters the cluster off  state at time t0.
>
> It doesn't enter that state just yet.  A request to enter it is made at this
> time.

right, i should have said "requests" instead of "enters".

>
>> the predicted wakeup by the governor for this cpu is in 20ms
>>
>> cpu 0 enters the cluster off  state at t0 + 19ms.
>> the predicted wakeup is in 30ms.
>>
>> in this case the cluster off state will actually be entered 1ms before cpu1
>> is predicted to wake up, and the cluster off residency constraint would not
>> be met.
>
> The target residency is not a constraint.  It is an advisory value for the
> governor to consider, but if a CPU wakes up earlier than that, we'll just
> not save energy (or save less of it).  It is not critical as long as it
> doesn't happen too often.
>

Ok, So if target residency is not a constraint/critical,
i guess its not worth to check for a imminent wakeup
on the cluster.

>> To avoid this, before entering the cluster off state, the last cpu could
>> "validate" that the predicted wakeup time of all the cpus in his cluster
>> *still* don't violate the cluster off state requirements.
>
> That is potentially racy with respect to wakeups of the other CPUs, isn't it?
>
>> maybe this is a corner case that does not justify the added logic, which ends
>> up being more expensive.
>
> It really seems so.
>
>> a  simple prototype looks something like this:
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index b8a5fa1..bdd3211 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/math64.h>
>>  #include <linux/module.h>
>> +#include <linux/cpu.h>
>>
>>  /*
>>   * Please note when changing the tuning values:
>> @@ -124,6 +125,7 @@ struct menu_device {
>>
>>      unsigned int    next_timer_us;
>>      unsigned int    predicted_us;
>> +    unsigned int    predicted_time_us;
>
> The names here are too similar to each other.
>
>>      unsigned int    bucket;
>>      unsigned int    correction_factor[BUCKETS];
>>      unsigned int    intervals[INTERVALS];
>> @@ -276,6 +278,45 @@ again:
>>      goto again;
>>  }
>>
>> +/* Check if the idle state is still valid for a given cpu */
>> +static bool menu_validate(struct cpuidle_driver *drv,
>> +        struct cpuidle_device *dev,
>> +        int cpu,
>> +        int state)
>> +{
>> +    unsigned int now_us;
>> +    int last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
>> +    struct menu_device *data;
>> +    unsigned int remaining_us;
>> +    int i;
>> +
>> +    now_us = ktime_to_us(ktime_get_raw());
>> +    data = per_cpu_ptr(&menu_devices, cpu);
>> +    remaining_us = data->predicted_time_us - now_us;
>> +
>
> If 'state' is the state selected by the governor, I don't quite understand why
> you need the loop below.  Can't you simply check if the sum of target_residency
> and exit_latency of 'state' is still below remaining_us?

yes, right. i should have checked only the state
we are interested in.

>
>> +    /* Get the new recomended state for this cpu */
>> +    for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
>> +        struct cpuidle_state *s = &drv->states[i];
>> +        struct cpuidle_state_usage *su = &dev->states_usage[i];
>> +
>> +        if (s->disabled || su->disable)
>> +            continue;
>> +
>> +        if (s->target_residency > remaining_us)
>> +            continue;
>> +
>> +        last_state_idx = i;
>> +
>> +        /* state (or deeper) is still allowed */
>> +        if (last_state_idx >= state)
>> +            return true;
>> +    }
>> +
>> +    /* the cpu doest not allow for the requested state */
>> +    return false;
>> +
>> +}
>> +
>>  /**
>>   * menu_select - selects the next idle state to enter
>>   * @drv: cpuidle driver containing state data
>> @@ -352,6 +393,8 @@ static int menu_select(struct cpuidle_driver *drv,
>> struct cpuidle_device *dev)
>>
>>          data->last_state_idx = i;
>>      }
>> +    data->predicted_time_us = ktime_to_us(ktime_get_raw())
>> +        + data->predicted_us;
>>
>>      return data->last_state_idx;
>>  }
>> @@ -470,6 +513,7 @@ static struct cpuidle_governor menu_governor = {
>>      .enable =    menu_enable_device,
>>      .select =    menu_select,
>>      .reflect =    menu_reflect,
>> +    .validate =    menu_validate,
>>      .owner =    THIS_MODULE,
>>  };
>>
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 9c5e892..e917fa9 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -226,6 +226,11 @@ struct cpuidle_governor {
>>                      struct cpuidle_device *dev);
>>      void (*reflect)        (struct cpuidle_device *dev, int index);
>>
>> +    bool (*validate)    (struct cpuidle_driver *drv,
>> +                    struct cpuidle_device *dev,
>> +                    int cpu,
>> +                    int state);
>> +
>>      struct module         *owner;
>>  };
>>
>> Regards
>> Axel
>>
>> [1] http://marc.info/?l=linux-pm&m=143143190116868&w=2
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
