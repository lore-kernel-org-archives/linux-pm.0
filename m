From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 12/12] cpufreq: governor: Narrow down the dbs_data_mutex coverage
Date: Thu, 18 Feb 2016 17:32:45 +0100
Message-ID: <CAJZ5v0iH_1y4xu-Q1FVAjX21Guv9wmeuMp9aoHV5myw01Kkp7A@mail.gmail.com>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
	<8616971.q0P8tF6lFz@vostro.rjw.lan>
	<20160218062040.GR2610@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160218062040.GR2610@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 18, 2016 at 7:20 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18-02-16, 02:38, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Since cpufreq_governor_dbs() is now always called with policy->rwsem
>> held, it cannot be executed twice in parallel for the same policy.
>> Thus it is not necessary to hold dbs_data_mutex around the invocations
>> of cpufreq_governor_start/stop/limits() from it as those functions
>> never modify any data that can be shared between different policies.
>>
>> However, cpufreq_governor_dbs() may be executed twice in parallal
>> for different policies using the same gov->gdbs_data object and
>> dbs_data_mutex is still necessary to protect that object against
>> concurrent updates.
>>
>> For this reason, narrow down the dbs_data_mutex locking to
>> cpufreq_governor_init/exit() where it is needed and rename the
>> mutex to gov_dbs_data_mutex to reflect its purpose.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpufreq/cpufreq_governor.c |   53 ++++++++++++++++++-------------------
>>  1 file changed, 27 insertions(+), 26 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
>> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
>> @@ -24,7 +24,7 @@
>>
>>  static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
>>
>> -static DEFINE_MUTEX(dbs_data_mutex);
>> +static DEFINE_MUTEX(gov_dbs_data_mutex);
>>
>>  /* Common sysfs tunables */
>>  /**
>> @@ -422,10 +422,10 @@ static void free_policy_dbs_info(struct
>>  static int cpufreq_governor_init(struct cpufreq_policy *policy)
>>  {
>>       struct dbs_governor *gov = dbs_governor_of(policy);
>> -     struct dbs_data *dbs_data = gov->gdbs_data;
>> +     struct dbs_data *dbs_data;
>>       struct policy_dbs_info *policy_dbs;
>>       unsigned int latency;
>> -     int ret;
>> +     int ret = 0;
>>
>>       /* State should be equivalent to EXIT */
>>       if (policy->governor_data)
>> @@ -435,6 +435,10 @@ static int cpufreq_governor_init(struct
>>       if (!policy_dbs)
>>               return -ENOMEM;
>>
>> +     /* Protect gov->gdbs_data against concurrent updates. */
>> +     mutex_lock(&gov_dbs_data_mutex);
>> +
>> +     dbs_data = gov->gdbs_data;
>>       if (dbs_data) {
>>               if (WARN_ON(have_governor_per_policy())) {
>>                       ret = -EINVAL;
>> @@ -447,8 +451,7 @@ static int cpufreq_governor_init(struct
>>               dbs_data->usage_count++;
>>               list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
>>               mutex_unlock(&dbs_data->mutex);
>> -
>> -             return 0;
>> +             goto out;
>>       }
>>
>>       dbs_data = kzalloc(sizeof(*dbs_data), GFP_KERNEL);
>> @@ -488,10 +491,14 @@ static int cpufreq_governor_init(struct
>>       ret = kobject_init_and_add(&dbs_data->kobj, &gov->kobj_type,
>>                                  get_governor_parent_kobj(policy),
>>                                  "%s", gov->gov.name);
>> -     if (!ret)
>> -             return 0;
>> +     if (ret)
>> +             goto err;
>>
>> -     /* Failure, so roll back. */
>> +out:
>> +     mutex_unlock(&gov_dbs_data_mutex);
>> +     return ret;
>> +
>> +err:
>
> This has turned into an ugly maze, really. I think it would be much
> better if we sacrifice a bit on consistency in the code, and move the
> locks in cpufreq_governor_dbs() around invocations to
> cpufreq_governor_init(). Or maybe create a
> __cpufreq_governor_init(), or whatever.
>
> That routine is hardly readably anymore.

Yes, it's not pretty, but I can still read it just fine.  Maybe that's
because I'm used to things like that. :-)

But OK, you have a point.  I'll rework this one.

Thanks,
Rafael
