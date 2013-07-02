From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4] cpufreq: stats: Add 'load_table' debugfs file to show
 accumulated data of CPUs
Date: Tue, 02 Jul 2013 16:03:45 +0900
Message-ID: <51D27B51.2050404@samsung.com>
References: <1372405697-13556-1-git-send-email-cw00.choi@samsung.com>
 <CAKohpon6AaSRQKvffPG+J=NUU+5JdVhFo-_uMm=2H3u-yT5h0A@mail.gmail.com>
 <51CD55E2.5060205@samsung.com>
 <CAKohpokY+GEt9UaU5inWaiooLq8sX7jy63sok+FFvs_KyQpcKg@mail.gmail.com>
 <51D276E3.9030206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <51D276E3.9030206@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

On 07/02/2013 03:44 PM, Chanwoo Choi wrote:
> On 06/28/2013 07:13 PM, Viresh Kumar wrote:
>> On 28 June 2013 14:52, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>> On 06/28/2013 05:18 PM, Viresh Kumar wrote:
>>>> On 28 June 2013 13:18, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>>>> Can you describe a bit about the layout this will create in debugfs?
>>>> I thought you will have a load_table file per policy->cpu ??
>>>>
>>>
>>> The debugfs_cpufreq is debugfs root directory (/sys/kernel/debug/cpufreq)
>>
>> Which you are creating anyway in your patch.
>>
>>> and debugfs_cpufreq has many child directory for Per-CPU debugfs according to NR_CPUS number (/sys/kernel/debug/cpufreq/cpuX).
>>
>> Even you are creating this only for policy->cpu
>>
>>> Finally, Per-CPU debugfs create load_table debugfs file (/sys/kernel/debug/cpufreq/cpuX/load_table).
>>>
>>> For example, only CPU0 create sysfs directory and file (/sys/devices/system/cpu/cpu0/cpufreq)
>>> and then other CPUx create link of created sysfs directory by CPU0 in cpufreq_add_dev_symlink().
>>
>> This isn't how its happening now. You aren't creating any links.
> 
> You're right. This patch didn't create link for CPU1/2/3.
> 
>>
>>> So, I'm considering whether to create link of CPUx's debugfs file except for CPU0 as sysfs file.
>>> - /sys/kernel/debug/cpufreq/cpu1/
>>> - /sys/kernel/debug/cpufreq/cpu2/
>>> - /sys/kernel/debug/cpufreq/cpu3/
>>
>> Yes please.
> 
> OK. I'll create link for CPU1,2,3 if all CPUs is included in one cluster.
> 
> I explain the sequence for creating sysfs file of CPU0/1/2/3.
> There are difference about sysfs file. Only, CPU0 creates sysfs file
> and then CPU1/2/3 create a link to CPU0 sysfs file. If we want to create
> debugfs link for CPU1/2/3, I should have to create debugfs file for CPU0 /
I made wrong sentence and then change it.
: I should have to debugfs -> I should have to create debugfs file
> debugfs link for CPU1/2/3 when cpufreq_register_driver() is operated.
> This proposal won't always remove debugfs file for cpufreq when user change
> cpufreq governor from ondemand/conservative to performance/powersave.
> 
> So, I suggest that cpufreq core executes dbs_check_cpu() to calculate
> CPUx load when cpufreq governor is performance/powersave. While maintaing
> same cpu frequency on performance/powersave governor, there are different
> power-consumption according to CPUx load. I think we need to check CPUs load
> on peformance/powersave governor.
> 
> [Flow sequence for CPU0]
> cpufreq_register_driver()
> ->subsys_interface_register()
> -->sif->add_dev()
> ---> cpufreq_add_dev()
> ----> cpufreq_add_policy_cpu()
> -----> sysfs_create_link(&dev->kboj, &policy->kobj, "cpufreq");	: Create sysfs file (/sys/devices/system/cpu/cpu0/cpufreq)
> 
> [Flow sequence for CPU1/2/3]
> cpufreq_register_driver()
> ->subsys_interface_register()
> -->sif->add_dev()
> ---> cpufreq_add_dev()
> ----> cpufreq_add_policy_cpu()
> -----> cpufreq_add_dev_interface(cpu, ...)
> ------> cpufreq_add_dev_symlink(cpu, ...) : Create sysfs link about CPU0 sysfs file(/sys/devices/system/cpu/cpu0/cpufreq)
> 
>>
>>> - A number of online CPU is 4
>>> Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU1 CPU2 CPU3
>>> 23165      200000       200000       2    0    0    0
>>> 23370      200000       200000       2    0    0    0
>>> 23575      200000       200000       2    0    1    0
>>> 23640      200000       200000       5    1    1    0
>>> 23780      200000       200000       3    0    1    0
>>> 23830      200000       200000       7    1    0    0
>>> 23985      200000       200000       1    0    0    0
>>> 24190      200000       200000       2    0    1    1
>>> 24385      200000       200000       2    0    0    0
>>> 24485      200000       200000       6    0    1    0
>>>
>>> - A number of online CPU is 2
>>> Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU3
>>> 37615      200000       200000       0    0
>>> 37792      200000       200000       0    5
>>> 38015      200000       200000       21   8
>>> 38215      200000       200000       0    0
>>> 38275      200000       200000       5    0
>>> 38415      200000       200000       15   3
>>> 38615      200000       200000       0    0
>>> 38730      200000       200000       1    0
>>> 38945      200000       200000       0    0
>>> 39155      200000       200000       1    1
>>
>> If you do the loop over for_each_cpu(cpu, policy->cpus),
>> this problem will be resolved. You will see only online cpus.
>>
>>> I'm considering whether to check the kind of cpufreq governor for creating load_table
>>> in cpufreq_stats or execute dbs_check_cpu() on performance/powersave governor to check
>>> CPUx load. If you have opinion about this, I'd like to listen it.
>>
>> Maybe create these directories and do this stuff only when
>> the first CPUFREQ_LOADCHECK notification is received inside
>> cpufreq_stats.c
>>
>> Also don't create debug/cpufreq directory unless you have any
>> stuff to be created within this directory. Like, don't create it
>> if we are using performance governor for all cpus.
>>
> 
> If core create debugfs/cpufreq directory when first CPUFREQ_LOADCHECK
> notification is received inside cpufreq_stats.c, CPU1/2/3 don't send
> CPUFREQ_LOADCHECK notification. In result, cpufreq_stats.c couldn't
> create link for /sys/kernel/debug/cpufreq/cpu[1-3].
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
