From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 39/46] sched/cpufreq_sched: use static key for cpu
 frequency selection
Date: Fri, 10 Jul 2015 10:50:12 +0100
Message-ID: <559F9554.1080400@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-40-git-send-email-morten.rasmussen@arm.com> <20150708151956.9112.52403@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:62042 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752771AbbGJJuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jul 2015 05:50:00 -0400
In-Reply-To: <20150708151956.9112.52403@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>
Cc: "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Mike,

On 08/07/15 16:19, Michael Turquette wrote:
> Quoting Morten Rasmussen (2015-07-07 11:24:22)
>> From: Juri Lelli <juri.lelli@arm.com>
>>
>> Introduce a static key to only affect scheduler hot paths when sched
>> governor is enabled.
>>
>> cc: Ingo Molnar <mingo@redhat.com>
>> cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
>> ---
>>  kernel/sched/cpufreq_sched.c | 14 ++++++++++++++
>>  kernel/sched/fair.c          |  1 +
>>  kernel/sched/sched.h         |  6 ++++++
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
>> index 5020f24..2968f3a 100644
>> --- a/kernel/sched/cpufreq_sched.c
>> +++ b/kernel/sched/cpufreq_sched.c
>> @@ -203,6 +203,18 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>>         return;
>>  }
>>  
>> +static inline void set_sched_energy_freq(void)
>> +{
>> +       if (!sched_energy_freq())
>> +               static_key_slow_inc(&__sched_energy_freq);
>> +}
>> +
>> +static inline void clear_sched_energy_freq(void)
>> +{
>> +       if (sched_energy_freq())
>> +               static_key_slow_dec(&__sched_energy_freq);
>> +}
>> +
>>  static int cpufreq_sched_start(struct cpufreq_policy *policy)
>>  {
>>         struct gov_data *gd;
>> @@ -243,6 +255,7 @@ static int cpufreq_sched_start(struct cpufreq_policy *policy)
>>  
>>         policy->governor_data = gd;
>>         gd->policy = policy;
>> +       set_sched_energy_freq();
>>         return 0;
>>  
>>  err:
>> @@ -254,6 +267,7 @@ static int cpufreq_sched_stop(struct cpufreq_policy *policy)
>>  {
>>         struct gov_data *gd = policy->governor_data;
>>  
>> +       clear_sched_energy_freq();
> 
> <paranoia>
> 
> These controls are exposed to userspace via cpufreq sysfs knobs. Should
> we use a struct static_key_deferred and static_key_slow_dec_deferred()
> instead? This helps avoid a possible attack vector for slowing down the
> system.
> 
> </paranoia>
> 
> I don't really know what a sane default rate limit would be in that case
> though.

I guess we could go with HZ, as it seems to be the common default.

> Otherwise feel free to add:
> 
> Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> 

Thanks,

- Juri

> Regards,
> Mike
> 
>>         if (cpufreq_driver_might_sleep()) {
>>                 kthread_stop(gd->task);
>>         }
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index f7cb6c9..d395bc9 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4282,6 +4282,7 @@ static inline void hrtick_update(struct rq *rq)
>>  #endif
>>  
>>  static bool cpu_overutilized(int cpu);
>> +struct static_key __sched_energy_freq __read_mostly = STATIC_KEY_INIT_FALSE;
>>  
>>  /*
>>   * The enqueue_task method is called before nr_running is
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 30aa0c4..b5e27d9 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1476,6 +1476,12 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>>  }
>>  #endif
>>  
>> +extern struct static_key __sched_energy_freq;
>> +static inline bool sched_energy_freq(void)
>> +{
>> +       return static_key_false(&__sched_energy_freq);
>> +}
>> +
>>  #ifdef CONFIG_CPU_FREQ_GOV_SCHED
>>  void cpufreq_sched_set_cap(int cpu, unsigned long util);
>>  #else
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 

