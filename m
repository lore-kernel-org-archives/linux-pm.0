From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data pointer
Date: Wed, 03 Feb 2016 17:40:24 -0800
Message-ID: <56B2AC08.7060006@codeaurora.org>
References: <3705929.bslqXH980s@vostro.rjw.lan> <1876466.AY9fn15fDn@vostro.rjw.lan> <56B2A53C.8080503@codeaurora.org> <CAJZ5v0gdR23cCocT3qw4ry26bMQ=qjcwatk9uu-Z1JDLKTSffQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37238 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965109AbcBDBk1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 20:40:27 -0500
In-Reply-To: <CAJZ5v0gdR23cCocT3qw4ry26bMQ=qjcwatk9uu-Z1JDLKTSffQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>

On 02/03/2016 05:25 PM, Rafael J. Wysocki wrote:
> On Thu, Feb 4, 2016 at 2:11 AM, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 02/03/2016 03:22 PM, Rafael J. Wysocki wrote:
>>>
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> If the ondemand and conservative governors cannot use per-policy
>>> tunables (CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not set in the cpufreq
>>> driver), all policy objects point to the same single dbs_data object.
>>> Additionally, that object is pointed to by a global pointer hidden in
>>> the governor's data structures.
>>>
>>> There is no reason for that pointer to be buried in those
>>> data structures, though, so make it explicitly global.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/cpufreq/cpufreq_governor.c |   20 ++++++++++----------
>>>    drivers/cpufreq/cpufreq_governor.h |   20 ++++++++++----------
>>>    2 files changed, 20 insertions(+), 20 deletions(-)
>>>
>>> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
>>> ===================================================================
>>> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
>>> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
>>> @@ -78,7 +78,7 @@ __ATTR(_name, 0644, show_##_name##_gov_p
>>>    static ssize_t show_##file_name##_gov_sys                             \
>>>    (struct kobject *kobj, struct attribute *attr, char *buf)             \
>>>    {                                                                     \
>>> -       struct _gov##_dbs_tuners *tuners =
>>> _gov##_dbs_cdata.gdbs_data->tuners; \
>>> +       struct _gov##_dbs_tuners *tuners = global_dbs_data->tuners; \
>>>          return sprintf(buf, "%u\n", tuners->file_name);                 \
>>>    }                                                                     \
>>>                                                                          \
>>> @@ -94,7 +94,7 @@ static ssize_t show_##file_name##_gov_po
>>>    static ssize_t store_##file_name##_gov_sys                            \
>>>    (struct kobject *kobj, struct attribute *attr, const char *buf, size_t
>>> count) \
>>>    {                                                                     \
>>> -       struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;         \
>>> +       struct dbs_data *dbs_data = global_dbs_data;            \
>>>          return store_##file_name(dbs_data, buf, count);                 \
>>>    }                                                                     \
>>>                                                                          \
>>> @@ -201,19 +201,14 @@ struct cs_dbs_tuners {
>>>    /* Common Governor data across policies */
>>>    struct dbs_data;
>>>    struct common_dbs_data {
>>> -       /* Common across governors */
>>> +       struct cpufreq_governor gov;
>>> +
>>>          #define GOV_ONDEMAND            0
>>>          #define GOV_CONSERVATIVE        1
>>>          int governor;
>>>          struct attribute_group *attr_group_gov_sys; /* one governor -
>>> system */
>>>          struct attribute_group *attr_group_gov_pol; /* one governor -
>>> policy */
>>>
>>> -       /*
>>> -        * Common data for platforms that don't set
>>> -        * CPUFREQ_HAVE_GOVERNOR_PER_POLICY
>>> -        */
>>> -       struct dbs_data *gdbs_data;
>>> -
>>>          struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
>>>          void *(*get_cpu_dbs_info_s)(int cpu);
>>>          unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
>>> @@ -233,6 +228,11 @@ struct dbs_data {
>>>          void *tuners;
>>>    };
>>>
>>> +/*
>>> + * Common governor data for platforms without
>>> CPUFREQ_HAVE_GOVERNOR_PER_POLICY.
>>> + */
>>> +extern struct dbs_data *global_dbs_data;
>>> +
>>>    /* Governor specific ops, will be passed to dbs_data->gov_ops */
>>>    struct od_ops {
>>>          void (*powersave_bias_init_cpu)(int cpu);
>>> @@ -256,7 +256,7 @@ static inline int delay_for_sampling_rat
>>>    static ssize_t show_sampling_rate_min_gov_sys                         \
>>>    (struct kobject *kobj, struct attribute *attr, char *buf)             \
>>>    {                                                                     \
>>> -       struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;         \
>>> +       struct dbs_data *dbs_data = global_dbs_data;                    \
>>>          return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);       \
>>>    }                                                                     \
>>>                                                                          \
>>> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
>>> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
>>> @@ -22,6 +22,9 @@
>>>
>>>    #include "cpufreq_governor.h"
>>>
>>> +struct dbs_data *global_dbs_data;
>>> +EXPORT_SYMBOL_GPL(global_dbs_data);
>>> +
>>>    DEFINE_MUTEX(dbs_data_mutex);
>>>    EXPORT_SYMBOL_GPL(dbs_data_mutex);
>>>
>>> @@ -377,22 +380,19 @@ static int cpufreq_governor_init(struct
>>>                                          latency * LATENCY_MULTIPLIER));
>>>
>>>          if (!have_governor_per_policy())
>>> -               cdata->gdbs_data = dbs_data;
>>> +               global_dbs_data = dbs_data;
>>>
>>>          policy->governor_data = dbs_data;
>>>
>>>          ret = sysfs_create_group(get_governor_parent_kobj(policy),
>>>                                   get_sysfs_attr(dbs_data));
>>> -       if (ret)
>>> -               goto reset_gdbs_data;
>>> -
>>> -       return 0;
>>> +       if (!ret)
>>> +               return 0;
>>
>>
>> I think the previous method of a handling the error is easier to read and
>> more in line with the typical kernel coding style. The successful path ends
>> in an unconditional return statement and the error paths are handled with a
>> goto.
>
> You are talking about something like this now:
>
>      if (condition)
>          goto label;
>
>      return 0;
>
> label:
>      do stuff
>
> I'm sorry, but I fail to see how this is easier to read than
>
>      if (!condition)
>          return 0;
>
>      do stuff
>
> The return statement is not unconditional in either case, but in the
> first one it is just obfuscated by using the label and goto which are
> completely unnecessary.
>

It's more readable because someone new is quickly scanning the code to 
understand what's going on, once you hit an unconditional return (as in, 
return without any ifs around it) you can just assume the rest of the 
code is error handling and skip reading/mentally processing them.

That, and it's more inline with how most of the kernel handles error 
conditions.

Anyway, you are removing it since it's not related to the patch. So, not 
planning to debate this fairly subjective opinion further.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
