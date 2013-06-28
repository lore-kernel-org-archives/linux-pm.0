From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4] cpufreq: stats: Add 'load_table' debugfs file to show
 accumulated data of CPUs
Date: Fri, 28 Jun 2013 18:22:42 +0900
Message-ID: <51CD55E2.5060205@samsung.com>
References: <1372405697-13556-1-git-send-email-cw00.choi@samsung.com>
 <CAKohpon6AaSRQKvffPG+J=NUU+5JdVhFo-_uMm=2H3u-yT5h0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpon6AaSRQKvffPG+J=NUU+5JdVhFo-_uMm=2H3u-yT5h0A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06/28/2013 05:18 PM, Viresh Kumar wrote:
> On 28 June 2013 13:18, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU1 CPU2 CPU3
>> 175320          1400000      1400000   41   47    0   79
> 
> We decided to left indent all entries here. I see only the first one
> like this. What about others?
> 

OK, I'll modify it.

Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU1 CPU2 CPU3
23165      200000       200000       2    0    0    0

>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index dc9b72e..a13bdf9 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -87,6 +87,9 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>>         struct od_dbs_tuners *od_tuners = dbs_data->tuners;
>>         struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>>         struct cpufreq_policy *policy;
> 
> A simple solution to your problem can be
> 
>> +#ifdef CONFIG_CPU_FREQ_STAT
>> +       struct cpufreq_freqs freq;
> 
> struct cpufreq_freqs freq = {0};
> 
>> +#endif
>>         unsigned int max_load = 0;
>>         unsigned int ignore_nice;
>>         unsigned int j;
>> @@ -148,6 +151,9 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>>                         continue;
>>
>>                 load = 100 * (wall_time - idle_time) / wall_time;
>> +#ifdef CONFIG_CPU_FREQ_STAT
>> +               freq.load[j] = load;
>> +#endif
>>
>>                 if (dbs_data->cdata->governor == GOV_ONDEMAND) {
>>                         int freq_avg = __cpufreq_driver_getavg(policy, j);
>> @@ -161,6 +167,15 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>>                         max_load = load;
>>         }
>>
>> +#ifdef CONFIG_CPU_FREQ_STAT
>> +       for_each_cpu_not(j, policy->cpus)
>> +               freq.load[j] = 0;
> 
> and remove this.

OK. I'll modify it as your comment.

> 
>> +       freq.time = ktime_to_ms(ktime_get());
>> +       freq.old = policy->cur;
>> +
>> +       cpufreq_notify_transition(policy, &freq, CPUFREQ_LOADCHECK);
>> +#endif
> 
> If I remember well you had another instance where you were setting
> load as zero when wall time is less than idle time?

Right, I initailized CPUs load in for_each_cpu(j, policy->cpus) as zero.
The previous code couldn't initialize the load value of offline cpu.

But, This issue is resolved after applying following code as your comment.
	> struct cpufreq_freqs freq = {0};

> 
>>         dbs_data->cdata->gov_check_cpu(cpu, max_load);
>>  }
>>  EXPORT_SYMBOL_GPL(dbs_check_cpu);
>> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> 
>> +static int cpufreq_stats_create_debugfs(struct cpufreq_policy *policy)
>> +{
> 
>> +       /* Create debugfs directory and file for cpufreq */
>> +       sprintf(buf, "cpu%d", policy->cpu);
>> +       stat->debugfs_cpu = debugfs_create_dir(buf, debugfs_cpufreq);
>> +       if (!stat->debugfs_cpu) {
>> +               ret = -ENOMEM;
>> +               goto err_alloc;
>> +       }
>> +
>> +       if (!debugfs_create_file("load_table", S_IWUSR, stat->debugfs_cpu,
>> +                               policy, &load_table_fops)) {
>> +               ret = -ENOMEM;
>> +               goto err_debugfs;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_debugfs:
>> +       debugfs_remove_recursive(stat->debugfs_cpu);
>> +err_alloc:
>> +       kfree(stat->load_table);
>> +err:
>> +       return ret;
>> +}
> 
> Can you describe a bit about the layout this will create in debugfs?
> I thought you will have a load_table file per policy->cpu ??
> 

The debugfs_cpufreq is debugfs root directory (/sys/kernel/debug/cpufreq)
and debugfs_cpufreq has many child directory for Per-CPU debugfs according to NR_CPUS number (/sys/kernel/debug/cpufreq/cpuX).
Finally, Per-CPU debugfs create load_table debugfs file (/sys/kernel/debug/cpufreq/cpuX/load_table).

For example, only CPU0 create sysfs directory and file (/sys/devices/system/cpu/cpu0/cpufreq)
and then other CPUx create link of created sysfs directory by CPU0 in cpufreq_add_dev_symlink().

So, I'm considering whether to create link of CPUx's debugfs file except for CPU0 as sysfs file.
- /sys/kernel/debug/cpufreq/cpu1/
- /sys/kernel/debug/cpufreq/cpu2/
- /sys/kernel/debug/cpufreq/cpu3/

> Like: /sys/kernel/debug/cpufreq/cpu0/load_table
> 
> Now in the show table function you are doing for_each_present_cpu()
> which may contain more cpus than are present in policy. Right?
> 

You're right.

> Probably you need to do, for_each_cpu(cpu, policy->cpus)..
> 

OK I'll modify it.

- A number of online CPU is 4
Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU1 CPU2 CPU3
23165      200000       200000       2    0    0    0
23370      200000       200000       2    0    0    0
23575      200000       200000       2    0    1    0
23640      200000       200000       5    1    1    0
23780      200000       200000       3    0    1    0
23830      200000       200000       7    1    0    0
23985      200000       200000       1    0    0    0
24190      200000       200000       2    0    1    1
24385      200000       200000       2    0    0    0
24485      200000       200000       6    0    1    0

- A number of online CPU is 2
Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU3
37615      200000       200000       0    0
37792      200000       200000       0    5
38015      200000       200000       21   8
38215      200000       200000       0    0
38275      200000       200000       5    0
38415      200000       200000       15   3
38615      200000       200000       0    0
38730      200000       200000       1    0
38945      200000       200000       0    0
39155      200000       200000       1    1

> Also what will happen when governor isn't ondemand/conservative?
> We will still try to create this table? What will be present inside it?
> 

I'm considering whether to check the kind of cpufreq governor for creating load_table
in cpufreq_stats or execute dbs_check_cpu() on performance/powersave governor to check
CPUx load. If you have opinion about this, I'd like to listen it.

Thanks,
Chanwoo Choi










