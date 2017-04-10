From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 2/2] cpufreq: schedutil: Utilization aggregation
Date: Mon, 10 Apr 2017 23:13:08 +0200
Message-ID: <CAJZ5v0iR_LvqE7Xa0fyrjwUH2X-H9MaK730QVgZ72xEwEq=FRg@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2242635.g1ACnTm5vK@aspire.rjw.lan>
 <20170410112607.GD30804@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34701 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdDJVNJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 17:13:09 -0400
In-Reply-To: <20170410112607.GD30804@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Apr 10, 2017 at 1:26 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Rafael,

Hi,

> thanks for this set. I'll give it a try (together with your previous
> patch) in the next few days.
>
> A question below.
>
> On 10/04/17 02:11, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Due to the limitation of the rate of frequency changes the schedutil
>> governor only estimates the CPU utilization entirely when it is about
>> to update the frequency for the corresponding cpufreq policy.  As a
>> result, the intermediate utilization values are discarded by it,
>> but that is not appropriate in general (like, for example, when
>> tasks migrate from one CPU to another or exit, in which cases the
>> utilization measured by PELT may change abruptly between frequency
>> updates).
>>
>> For this reason, modify schedutil to estimate CPU utilization
>> completely whenever it is invoked for the given CPU and store the
>> maximum encountered value of it as input for subsequent new frequency
>> computations.  This way the new frequency is always based on the
>> maximum utilization value seen by the governor after the previous
>> frequency update which effectively prevents intermittent utilization
>> variations from causing it to be reduced unnecessarily.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>
> [...]
>
>> -static void sugov_get_util(unsigned long *util, unsigned long *max)
>> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned int flags)
>>  {
>> +     unsigned long cfs_util, cfs_max;
>>       struct rq *rq = this_rq();
>> -     unsigned long cfs_max;
>>
>> -     cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
>> +     sg_cpu->flags |= flags & SCHED_CPUFREQ_RT_DL;
>> +     if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
>> +             return;
>>
>
> IIUC, with this you also keep track of any RT/DL tasks that woke up
> during the last throttling period, and react accordingly as soon a
> triggering event happens after the throttling period elapses.

Right (that's the idea at least).

> Given that for RT (and still for DL as well) the next event is a
> periodic tick, couldn't happen that the required frequency transition
> for an RT task, that unfortunately woke up before the end of a throttling
> period, gets delayed of a tick interval (at least 4ms on ARM)?

No, that won't be an entire tick unless it wakes up exactly at the
update time AFAICS.

> Don't we need to treat such wake up events (RT/DL) in a special way and
> maybe set a timer to fire and process them as soon as the current
> throttling period elapses? Might be a patch on top of this I guess.

Setting a timer won't be a good idea at all, as it would need to be a
deferrable one and Thomas would not like that (I'm sure).

We could in principle add some special casing around that, like for
example pass flags to sugov_should_update_freq() and opportunistically
ignore freq_update_delay_ns if SCHED_CPUFREQ_RT_DL is set in there,
but that would lead to extra overhead on systems where frequency
updates happen in-context.

Also the case looks somewhat corner to me to be honest.

Thanks,
Rafael
