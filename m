From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 2/2] sched/fair: do not call cpufreq hook unless util
 changed
Date: Thu, 24 Mar 2016 18:01:46 -0700
Message-ID: <56F48DFA.8020602@linaro.org>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <1458606068-7476-2-git-send-email-smuckle@linaro.org>
 <56F47C89.9070201@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F47C89.9070201@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, pboonstoppel@nvidia.com
List-Id: linux-pm@vger.kernel.org

Hi Sai,

On 03/24/2016 04:47 PM, Sai Gurrappadi wrote:
>> @@ -2850,7 +2851,8 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>>  	cfs_rq->load_last_update_time_copy = sa->last_update_time;
>>  #endif
>>  
>> -	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
>> +	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq &&
>> +	    (decayed || removed_util)) {
>>  		unsigned long max = rq->cpu_capacity_orig;
> 
> Should this filtering instead happen on the governor side?

Perhaps but that also means making a trip into that logic from this hot
path. To me it seemed better to avoid the overhead if possible,
especially since we already have info here on whether the util changed.
But if everyone agrees the overhead is negligible I'm happy to drop the
patch.

> Even if the CFS load itself didn't change, we could have switched from an
> RT/DL thread to a CFS thread so util would have to be updated from ULONG_MAX
> to whatever CFS needs right?

Agreed, given the current state of things this will delay the ramp down
in that case. The current scheme of having a single vote for CPU
capacity seems broken overall to me however.

If the CPU goes idle after RT/DL execution we'll leave the vote at fmax
until cpufreq_sched starts ignoring it due to staleness.

More importantly though, without capacity vote aggregation from
CFS/RT/DL it doesn't seem possible to ensure appropriate capacity. If
CFS keeps setting the capacity when it runs to a capacity based solely
on the CFS requirement, and there is RT or DL utilization in the system,
won't it tend to be underserved? It may actually be better to be lazy in
ramping down from fmax to compensate for not including RT/DL's
utilization, until we can more accurately calculate it.

We need vote aggregation from each sched class. This has been posted
both as part of the now-defunct schedfreq series as well as Mike
Turquette's recent series, which I hear he's working on rebasing.

Once that is in we need to decide how RT tasks should vote. I'm not
really a fan of the decision to run them at fmax. I think this changes
their semantics and it will be a non-starter for platforms with power
constraints and/or slow frequency transition times. Perhaps we could
make it configurable how the RT class should vote. It should be the RT
class's responsibility though IMO to reduce/drop its vote when necessary
though, which would address your concern above.

> Also now that CFS enqueue calls cpufreq_update_util, RT/DL requests could
> potentially get overridden.

I think this was already busted - enqueue_task_fair() calls
update_load_avg() on the sched entities in the hierarchy which were
already enqueued.

thanks,
Steve
