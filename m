From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 13:16:45 +0800
Message-ID: <516F81BD.3030306@intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com> <516F42EE.6080802@intel.com> <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31560 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab3DRFRW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Apr 2013 01:17:22 -0400
In-Reply-To: <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 04/18/2013 12:26 PM, Viresh Kumar wrote:
> On 18 April 2013 06:18, Alex Shi <alex.shi@intel.com> wrote:
>> On 04/18/2013 12:46 AM, Viresh Kumar wrote:
>>> On 16 April 2013 12:44, Alex Shi <alex.shi@intel.com> wrote:
> 
>> Hi, Viresh, correct me if I am wrong. :)
>>
>> the affected_cpus value changed from 3.9-rc1, then we get the good performance,
>> and dropped after this commit. I have reverted this patch, then the performance recovered.
> 
> 
> What's the fps value you got with v3.8? Current values should be
> similar to that.

Yes. current value is similar to 3.8: 18fps, compare to 3.9-rc1, that is
also bad.
I mean the good performance started from 3.9-rc1 kernel.

> About your system: Can you give output of cpufreq-info for v3.8 and
> v3.9-latestrc?
> Your cpus share a clock line or not?

Yes our cpu shares a clock line. So the cpufreq-info is same. SNB CPU
p-state is per cpu package, and hardware will coordinate the software
asking, then decide which cpufreq should be.
> 
>> this patch remove the unconditionally related_cpus set:
>> @@ -730,7 +730,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>             policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
>>                 cpumask_copy(policy->cpus, perf->shared_cpu_map);
>>         }
>> -       cpumask_copy(policy->related_cpus, perf->shared_cpu_map);
> 
> Because setting related cpus now didn't had a meaning and people were
> facing regressions due to it.

I know. So, I reported this issue without asking for revert. :)
> 
>>
> 
>> Our p-state should be hardware coordinate, so affected_cpus is right on your patch.
> 
> Didn't get that.. Your cpus share clock line? If so, they should be set in
> policy->cpus by your driver and same would be reflected in related_cpus
> by cpufreq core.

That's sth I am also confused. Yes, that cpu share a clock line. But
Arjan and Len both said affected_cpus should only include the cpu self,
because cpu will do hardware coordination for them.
> 


-- 
Thanks Alex
