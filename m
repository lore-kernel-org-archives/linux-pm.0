From: Michael Wang <wangyun@linux.vnet.ibm.com>
Subject: Re: [v3.10 regression] deadlock on cpu hotplug
Date: Wed, 10 Jul 2013 10:40:48 +0800
Message-ID: <51DCC9B0.9090507@linux.vnet.ibm.com>
References: <1443144.WnBWEpaopK@amdc1032> <51DB724F.9050708@linux.vnet.ibm.com> <1754044.EVIH1UZj6p@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1754044.EVIH1UZj6p@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Tomasz Figa <t.figa@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/09/2013 07:51 PM, Bartlomiej Zolnierkiewicz wrote:
[snip]
> 
> It doesn't help and unfortunately it just can't help as it only
> addresses lockdep functionality while the issue is not a lockdep
> problem but a genuine locking problem. CPU hot-unplug invokes
> _cpu_down() which calls cpu_hotplug_begin() which in turn takes
> &cpu_hotplug.lock. The lock is then hold during __cpu_notify()
> call. Notifier chain goes up to cpufreq_governor_dbs() which for
> CPUFREQ_GOV_STOP event does gov_cancel_work(). This function
> flushes pending work and waits for it to finish. The all above
> happens in one kernel thread. At the same time the other kernel
> thread is doing the work we are waiting to complete and it also
> happens to do gov_queue_work() which calls get_online_cpus().
> Then the code tries to take &cpu_hotplug.lock which is already
> held by the first thread and deadlocks.

Hmm...I think I get your point, some thread hold the lock and
flush some work which also try to hold the same lock, correct?

Ok, that's a problem, let's figure out a good way to solve it :)

Regards,
Michael Wang




> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index 5af40ad..aa05eaa 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -229,6 +229,8 @@ static void set_sampling_rate(struct dbs_data *dbs_data,
>>         }
>>  }
>>  
>> +static struct lock_class_key j_cdbs_key;
>> +
>>  int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>>                 struct common_dbs_data *cdata, unsigned int event)
>>  {
>> @@ -366,6 +368,8 @@ int (struct cpufreq_policy *policy,
>>                                         kcpustat_cpu(j).cpustat[CPUTIME_NICE];
>>  
>>                         mutex_init(&j_cdbs->timer_mutex);
>> +                       lockdep_set_class(&j_cdbs->timer_mutex, &j_cdbs_key);
>> +
>>                         INIT_DEFERRABLE_WORK(&j_cdbs->work,
>>                                              dbs_data->cdata->gov_dbs_timer);
>>                 }
>>
>> Regards,
>> Michael Wang
> 
