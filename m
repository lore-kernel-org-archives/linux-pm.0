From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 44/46] sched/fair: jump to max OPP when crossing
 UP threshold
Date: Fri, 10 Jul 2015 11:17:52 +0100
Message-ID: <559F9BD0.2090303@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-45-git-send-email-morten.rasmussen@arm.com> <20150708164744.9112.6023@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:45179 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753380AbbGJKRl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jul 2015 06:17:41 -0400
In-Reply-To: <20150708164744.9112.6023@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>
Cc: "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Mike,

On 08/07/15 17:47, Michael Turquette wrote:
> Quoting Morten Rasmussen (2015-07-07 11:24:27)
>> From: Juri Lelli <juri.lelli@arm.com>
>>
>> Since the true utilization of a long running task is not detectable while
>> it is running and might be bigger than the current cpu capacity, create the
>> maximum cpu capacity head room by requesting the maximum cpu capacity once
>> the cpu usage plus the capacity margin exceeds the current capacity. This
>> is also done to try to harm the performance of a task the least.
>>
>> cc: Ingo Molnar <mingo@redhat.com>
>> cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
>> ---
>>  kernel/sched/fair.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 323331f..c2d6de4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8586,6 +8586,25 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>  
>>         if (!rq->rd->overutilized && cpu_overutilized(task_cpu(curr)))
>>                 rq->rd->overutilized = true;
>> +
>> +       /*
>> +        * To make free room for a task that is building up its "real"
>> +        * utilization and to harm its performance the least, request a
>> +        * jump to max OPP as soon as get_cpu_usage() crosses the UP
>> +        * threshold. The UP threshold is built relative to the current
>> +        * capacity (OPP), by using same margin used to tell if a cpu
>> +        * is overutilized (capacity_margin).
>> +        */
>> +       if (sched_energy_freq()) {
>> +               int cpu = cpu_of(rq);
>> +               unsigned long capacity_orig = capacity_orig_of(cpu);
>> +               unsigned long capacity_curr = capacity_curr_of(cpu);
>> +
>> +               if (capacity_curr < capacity_orig &&
>> +                   (capacity_curr * SCHED_LOAD_SCALE) <
>> +                   (get_cpu_usage(cpu) * capacity_margin))
>> +                       cpufreq_sched_set_cap(cpu, capacity_orig);
> 
> I'm sure that at some point the Product People are going to want to tune
> the capacity value that is requested. Hard-coding the max
> capacity/frequency in is a reasonable start, but at some point it would
> be nice to fetch an intermediate capacity defined by the cpufreq driver
> for this particular cpu. We have already seen that a lot in Android
> devices using the interactive governor and it could be done from
> cpufreq_sched_start().
> 

Yeah, right, this bit is subject to change. The thing you are proposing
is one possible way to please Product People. However, we are going to
experiment with a couple of alternatives. The point is that we might
don't want to start exposing tuning knobs from the beginning. I'm
saying this because, IMHO, we should try hard to reduce the number of
tuning knobs to a minimum, so that we don't end up with what other
governors have. The whole thing should "just work" on most
configurations, ideally. :)

So, our current thoughts are around:

 - try to derive this "jump to" point by looking at the energy
   model; if we can spot an OPP that is particularly energy
   efficient and it also gives enough computing capacity, maybe
   it is the right place to settle for a bit before going to max;
   isn't this what you would tune the system to do anyway?

 - we have a prototype (that we should release as an RFC somewhat
   soon) infrastructure to let users tune both scheduling decisions
   and OPP selection; this "jump to" point might be related in
   some way to the tuning infrastructure; I'd say that we could
   wait for that RFC to happen and we continue this discussion :)

Thanks,

- Juri

> Regards,
> Mike
> 
>> +       }
>>  }
>>  
>>  /*
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

