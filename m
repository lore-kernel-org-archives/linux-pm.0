From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 2/2] cpufreq: schedutil: Utilization aggregation
Date: Mon, 10 Apr 2017 22:59:16 +0200
Message-ID: <CAJZ5v0gePrW+hnR4UdGnxuibhcUvcfHSfULFok3tYEsOvD7eLA@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2242635.g1ACnTm5vK@aspire.rjw.lan>
 <CAJWu+orhpeirhB1u-KTOBjWTQoTEJdStR3BP14WxkB=RZP49sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35868 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbdDJU7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 16:59:18 -0400
In-Reply-To: <CAJWu+orhpeirhB1u-KTOBjWTQoTEJdStR3BP14WxkB=RZP49sg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On Mon, Apr 10, 2017 at 8:39 AM, Joel Fernandes <joelaf@google.com> wrote:
> Hi Rafael,

Hi,

> On Sun, Apr 9, 2017 at 5:11 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>

[cut]

>> @@ -154,22 +153,30 @@ static unsigned int get_next_freq(struct
>>         return cpufreq_driver_resolve_freq(policy, freq);
>>  }
>>
>> -static void sugov_get_util(unsigned long *util, unsigned long *max)
>> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned int flags)
>>  {
>> +       unsigned long cfs_util, cfs_max;
>>         struct rq *rq = this_rq();
>> -       unsigned long cfs_max;
>>
>> -       cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
>> +       sg_cpu->flags |= flags & SCHED_CPUFREQ_RT_DL;
>> +       if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
>> +               return;
>>
>> -       *util = min(rq->cfs.avg.util_avg, cfs_max);
>> -       *max = cfs_max;
>> +       cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
>> +       cfs_util = min(rq->cfs.avg.util_avg, cfs_max);
>> +       if (sg_cpu->util * cfs_max < sg_cpu->max * cfs_util) {
>
> Assuming all CPUs have equal compute capacity, doesn't this mean that
> sg_cpu->util is updated only if cfs_util > sg_cpu->util?

Yes, it does.

> Maybe I missed something, but wouldn't we want sg_cpu->util to be
> reduced as well when cfs_util reduces? Doesn't this condition
> basically discard all updates to sg_cpu->util that could have reduced
> it?
>
>> +               sg_cpu->util = cfs_util;
>> +               sg_cpu->max = cfs_max;
>> +       }
>>  }


Well, that's the idea. :-)

During the discussion at the OSPM-summit we concluded that discarding
all of the utilization changes between the points at which frequency
updates actually happened was not a good idea, so they needed to be
aggregated somehow.

There are a few ways to aggregate them, but the most straightforward
one (and one which actually makes sense) is to take the maximum as the
aggregate value.

Of course, this means that we skew things towards performance here,
but I'm not worried that much. :-)

Thanks,
Rafael
