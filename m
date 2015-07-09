From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 41/46] sched/fair: add triggers for OPP change requests
Date: Thu, 09 Jul 2015 17:52:54 +0100
Message-ID: <559EA6E6.4010801@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com> <20150708154215.9112.98060@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:61185 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070AbbGIQwn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jul 2015 12:52:43 -0400
In-Reply-To: <20150708154215.9112.98060@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>
Cc: "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Mike,

On 08/07/15 16:42, Michael Turquette wrote:
> Hi Juri,
> 
> Quoting Morten Rasmussen (2015-07-07 11:24:24)
>> From: Juri Lelli <juri.lelli@arm.com>
>>
>> Each time a task is {en,de}queued we might need to adapt the current
>> frequency to the new usage. Add triggers on {en,de}queue_task_fair() for
>> this purpose.  Only trigger a freq request if we are effectively waking up
>> or going to sleep.  Filter out load balancing related calls to reduce the
>> number of triggers.
>>
>> cc: Ingo Molnar <mingo@redhat.com>
>> cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
>> ---
>>  kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index f74e9d2..b8627c6 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4281,7 +4281,10 @@ static inline void hrtick_update(struct rq *rq)
>>  }
>>  #endif
>>  
>> +static unsigned int capacity_margin = 1280; /* ~20% margin */
> 
> This is a 25% margin. Calling it ~20% is a bit misleading :)
> 

Well, 1024 is what you get if your remove 20% to 1280. But, I
confess it wasn't clear to me too at first sight ;). Anyway,
you are right that the way I use it below, you end up adding
25% to req_cap. It is just because I didn't want to add another
margin I guess. :)

> Should margin be scaled for cpus that do not have max capacity == 1024?
> In other words, should margin be dynamically calculated to be 20% of
> *this* cpu's max capacity?
> 
> I'm imagining a corner case where a heterogeneous cpu system is set up
> in such a way that adding margin that is hard-coded to 25% of 1024
> almost always puts req_cap to the highest frequency, skipping some
> reasonable capacity states in between.
> 

But, what below should actually ask for a 25% more related to the
current cpu usage. So, if you have let's say a usage of 300 (this
is both cpu and freq scaled) when you do what below you get:

  300 * 1280 / 1024 = 375

and 375 is 300 + 25%. It is the ratio between capacity_margin and
SCHED_CAPACITY_SCALE that gives you a percentage relative to cpu usage.
Or did I get it wrong?

>> +
>>  static bool cpu_overutilized(int cpu);
>> +static unsigned long get_cpu_usage(int cpu);
>>  struct static_key __sched_energy_freq __read_mostly = STATIC_KEY_INIT_FALSE;
>>  
>>  /*
>> @@ -4332,6 +4335,26 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>                 if (!task_new && !rq->rd->overutilized &&
>>                     cpu_overutilized(rq->cpu))
>>                         rq->rd->overutilized = true;
>> +               /*
>> +                * We want to trigger a freq switch request only for tasks that
>> +                * are waking up; this is because we get here also during
>> +                * load balancing, but in these cases it seems wise to trigger
>> +                * as single request after load balancing is done.
>> +                *
>> +                * XXX: how about fork()? Do we need a special flag/something
>> +                *      to tell if we are here after a fork() (wakeup_task_new)?
>> +                *
>> +                * Also, we add a margin (same ~20% used for the tipping point)
>> +                * to our request to provide some head room if p's utilization
>> +                * further increases.
>> +                */
>> +               if (sched_energy_freq() && !task_new) {
>> +                       unsigned long req_cap = get_cpu_usage(cpu_of(rq));
>> +
>> +                       req_cap = req_cap * capacity_margin
>> +                                       >> SCHED_CAPACITY_SHIFT;
> 
> Probably a dumb question:
> 
> Can we "cheat" here and just assume that capacity and load use the same
> units? That would avoid the multiplication and change your code to the
> following:
> 
> 	#define capacity_margin SCHED_CAPACITY_SCALE >> 2; /* 25% */
> 	req_cap += SCHED_CAPACITY_SCALE;
> 

I'd rather stick with an increase relative to the current usage
as opposed to adding 256 to every request. I fear that the latter
would end up cutting out some OPPs entirely, as you were saying above.

>> +                       cpufreq_sched_set_cap(cpu_of(rq), req_cap);
>> +               }
>>         }
>>         hrtick_update(rq);
>>  }
>> @@ -4393,6 +4416,23 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>         if (!se) {
>>                 sub_nr_running(rq, 1);
>>                 update_rq_runnable_avg(rq, 1);
>> +               /*
>> +                * We want to trigger a freq switch request only for tasks that
>> +                * are going to sleep; this is because we get here also during
>> +                * load balancing, but in these cases it seems wise to trigger
>> +                * as single request after load balancing is done.
>> +                *
>> +                * Also, we add a margin (same ~20% used for the tipping point)
>> +                * to our request to provide some head room if p's utilization
>> +                * further increases.
>> +                */
>> +               if (sched_energy_freq() && task_sleep) {
>> +                       unsigned long req_cap = get_cpu_usage(cpu_of(rq));
>> +
>> +                       req_cap = req_cap * capacity_margin
>> +                                       >> SCHED_CAPACITY_SHIFT;
>> +                       cpufreq_sched_set_cap(cpu_of(rq), req_cap);
> 
> Filtering out the load_balance bits is neat.
> 

Also, I guess we need to do that because we still have some rate
limit to the frequency at which we can issue requests. If we move
more that one task when load balacing, we could miss some requests.

Thanks,

- Juri

> Regards,
> Mike
> 
>> +               }
>>         }
>>         hrtick_update(rq);
>>  }
>> @@ -4959,8 +4999,6 @@ static int find_new_capacity(struct energy_env *eenv,
>>         return idx;
>>  }
>>  
>> -static unsigned int capacity_margin = 1280; /* ~20% margin */
>> -
>>  static bool cpu_overutilized(int cpu)
>>  {
>>         return (capacity_of(cpu) * 1024) <
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 

