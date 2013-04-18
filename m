From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 08:48:46 +0800
Message-ID: <516F42EE.6080802@intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44234 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935603Ab3DRAtW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 20:49:22 -0400
In-Reply-To: <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 04/18/2013 12:46 AM, Viresh Kumar wrote:
> On 16 April 2013 12:44, Alex Shi <alex.shi@intel.com> wrote:
>> LKP found a performance and performance/watt regression on commit
>> aa77a52764a92216b61, acpi-cpufreq: Don't set policy->related_cpus from
>> .init.
>>
>> The commit removed the related_cpus setting, plus Our laptop has no
>> coordinate type setting in BIOS. So the related_cpus is only include the
>> cpu self, then the policy->cpus are impacted and only has self too.
>>
>> With ondemand governor, the bad commit cause bltk-game benchmark drop to
>> 18fps from 50fps, the performance/watt value also dropped a lot.
>> bltk-game runs 9 thread on the 4core*HT laptop.
>>
>> As Arjan and Len mentioned, the commit is correct in logical,
>> policy->cpus should only include the cpu self.
>> So I don't know where is the problem, maybe ondemand or some place
>> others. Anyway, I just report the issue to you.
> 
> I really don't believe the commit you are pointing to should have any impact
> on performance. Because before i changed definitions of affected and
> related cpus, related_cpus was just not used at all (leaving some hotplug cases
> to identify the last governor).. And so even if we set related_cpus from driver
> earlier, it shouldn't be doing anything.

Hi, Viresh, correct me if I am wrong. :)

the affected_cpus value changed from 3.9-rc1, then we get the good performance, 
and dropped after this commit. I have reverted this patch, then the performance recovered.

this patch remove the unconditionally related_cpus set:
@@ -730,7 +730,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
            policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
                cpumask_copy(policy->cpus, perf->shared_cpu_map);
        }
-       cpumask_copy(policy->related_cpus, perf->shared_cpu_map);
 
that cause path change in cpufreq_add_dev(), 
 #ifdef CONFIG_HOTPLUG_CPU
 873         /* Check if this cpu was hot-unplugged earlier and has siblings */
 874         spin_lock_irqsave(&cpufreq_driver_lock, flags);
 875         for_each_online_cpu(sibling) {
 876                 struct cpufreq_policy *cp = per_cpu(cpufreq_cpu_data, sibling);
 877                 if (cp && cpumask_test_cpu(cpu, cp->related_cpus)) {
 878                         spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 879                         return cpufreq_add_policy_cpu(cpu, sibling, dev);
 880                 }
 881         }

cpufreq_add_policy_cpu() has no chance to run for other cpus, since they are not in
cp->related_cpus, line 877.

The bltk-game use cpu to decode video, it has 9 load varied threads.
The following is the typical snapshot of asked cpufreq:
with your patch
[alexs@lkp-sb01 ~]$ cat /sys/.../cpu*/cpufreq/scaling_cur_freq
2201000
800000
800000
800000
800000
800000
2201000
800000

Wihtout your patch
[alexs@lkp-sb01 ~]$ cat /sys/.../cpu*/cpufreq/scaling_cur_freq
2201000
2201000
2201000
2201000
2201000
2201000
2201000
2201000

Our p-state should be hardware coordinate, so affected_cpus is right on your patch.

> 
> And now after it is being removed from acpi driver, i believe
> situation should still
> be the same.
> 


-- 
Thanks Alex
