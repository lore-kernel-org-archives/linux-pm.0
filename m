From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 10:15:24 -0400
Message-ID: <5BBE097C.50202@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010054449.GC2768@tesla>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010054449.GC2768@tesla>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Hello Javi,

Thanks for the interest.

On 10/10/2018 01:44 AM, Javi Merino wrote:
> On Tue, Oct 09, 2018 at 12:24:55PM -0400, Thara Gopinath wrote:
>> Thermal governors can respond to an overheat event for a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in linux kernel, in event of maximum
>> frequency capping of a cpu, the maximum available compute
>> capacity of the cpu is not adjusted at all. In other words, scheduler
>> is unware maximum cpu capacity restrictions placed due to thermal
>> activity.
> 
> Interesting, I would have sworn that I tested this years ago by
> lowering the maximum frequency of a cpufreq domain, and the scheduler
> reacted accordingly to the new maximum capacities of the cpus.
> 
>>           This patch series attempts to address this issue.
>> The benefits identified are better task placement among available
>> cpus in event of overheating which in turn leads to better
>> performance numbers.
>>
>> The delta between the maximum possible capacity of a cpu and
>> maximum available capacity of a cpu due to thermal event can
>> be considered as thermal pressure. Instantaneous thermal pressure
>> is hard to record and can sometime be erroneous as there can be mismatch
>> between the actual capping of capacity and scheduler recording it.
>> Thus solution is to have a weighted average per cpu value for thermal
>> pressure over time. The weight reflects the amount of time the cpu has
>> spent at a capped maximum frequency. To accumulate, average and
>> appropriately decay thermal pressure, this patch series uses pelt
>> signals and reuses the available framework that does a similar
>> bookkeeping of rt/dl task utilization.
>>
>> Regarding testing, basic build, boot and sanity testing have been
>> performed on hikey960 mainline kernel with debian file system.
>> Further aobench (An occlusion renderer for benchmarking realworld
>> floating point performance) showed the following results on hikey960
>> with debain.
>>
>>                                         Result          Standard        Standard
>>                                         (Time secs)     Error           Deviation
>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>
>> Thara Gopinath (7):
>>   sched/pelt: Add option to make load and util calculations frequency
>>     invariant
>>   sched/pelt.c: Add support to track thermal pressure
>>   sched: Add infrastructure to store and update instantaneous thermal
>>     pressure
>>   sched: Initialize per cpu thermal pressure structure
>>   sched/fair: Enable CFS periodic tick to update thermal pressure
>>   sched/fair: update cpu_capcity to reflect thermal pressure
>>   thermal/cpu-cooling: Update thermal pressure in case of a maximum
>>     frequency capping
>>
>>  drivers/base/arch_topology.c  |  1 +
>>  drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
> 
> thermal?  There are other ways in which the maximum frequency of a cpu
> can be limited, for example from userspace via scaling_max_freq.

Yes there are other ways in which maximum frequency of a cpu can be
capped. The difference probably is that in case of a user-space cap, the
time duration the cpu remains in the capped state is significantly
higher than capping due to a thermal event. So may be the response of
the scheduler should be different in that scenario (like rebuilding the
capacities of all cpus etc).

This patch series does not rebuild the scheduler structures. This just
tells the scheduler that some cpu capacity is stolen.
> 
> When something (anything) changes the maximum frequency of a cpufreq
> policy, the scheduler should be notified.  I think this change should
> be done in cpufreq instead to make it generic and not particular to
> a given maximum frequency "capper".

I am glad to hear you say this!  So far, all I have heard whenever I
bring up this topic is issues with such an update from cpufreq(delays,
lost updates etc). Personally, I have not seen these issues enough to
comment on them. I will really like to hear more about these issues for
an update from cpufreq here on the list.

For me, the patch series is a mechanism to let scheduler know that a
thermal event has stolen some cpu capacity. The update itself can happen
from any framework which can track the event and we all mutually agree on.

Regards
Thara

> 
> Cheers,
> Javi
> 


-- 
Regards
Thara
