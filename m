Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622717;
	b=ZHISyQNScwWkiPOcJlKl3HPSzeHznXTE4op3h+VWhygJYx6CSP3iwMb9g2XJ6fogPN46
	 5WkOD92p/5yarHnOXhYfBfrOuPK3oInlav4adpFxAY+i5GS4CHJpsfKtGkrquDnVT3xOV
	 CSJoKt/4UPCYONPl+tDC9O6nII89y7Uh45g5G5klwlInA2FV7McWGlvqIL22q5Gs5Vcy+
	 QsHOn7flYV2Gy80Jv45GrXzV1esb/oHC4ekS1oW1keYz2BWZ95WJbYWW+bSsT0x8gYUtX
	 f7ZFWBbbRjokHyfz6NdLIChJw/eQUQX6g3XXCbTeFqOagS9PmmWQnTK6pFiALSdlahQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622717;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6GE+oW9VUCeYQjdlVSh11j1PrHRV8CvUfIrZyP+fpIU=;
	b=34LtRf1VtcPLbvFEbxS+4jP7LKlTmqcWTujThKBaO8Eq3l3o4qtaalMav6jHms1zAm1O
	 Q+KiKouP9fT+GQBe03V0Jj3it1G8mHLcXie0u5h9PKRfoU3Mq/TbTZEOtRzdlvSRzHG3S
	 5Fzmk0qJRoVhdBoUwvyrUd+35z3+y/7jNlZtJxKeHRPMfxthAgg4lO7JqwuRBjMxtee0h
	 xo5fKszDZlnvxepv4PuHadDcP4vEwG071Xz8Cj1akvPKYdoLzZ32T46qObhtABuYqVQ0j
	 CEvPHhvPZ0W0XOyjb6x3hRn0QY2Z80z392rJZQLSkmU7qQ4ZtOyEFhhzTjq33lx5meQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="f/SYFLql";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57515606A31E;
	Wed, 25 Nov 2026 16:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57515606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=f/SYFLql
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D5B42F;
	Wed, 25 Nov 2026 08:05:12 -0800 (PST)
Received: from [10.57.69.217] (unknown [10.57.69.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C0883F632;
	Wed, 25 Nov 2026 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795622715; bh=Q18/gANHfBS9yusGn73g+rKuPFygV4jQITWOkgLzLKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f/SYFLqlrH7fMaiAmXY47z5gjemNut7y8vgnBcixaHbyN4WQO1DePlV16mYVcHcOk
	 efbHdspYW8kj0bR7SjlplxmrVK5oWrZTGWve23HywrPLTUkSQGDgPB6K02s6jH4q2P
	 dJg28w6A9ItJNFyownAMj3CuUeE9NWArbgN90yxg=
Message-ID: <17853c0e-9981-47f2-a62e-8ac4b2a192a6@arm.com>
Date: Wed, 25 Nov 2026 16:05:08 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping
 entities
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org,
 linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev,
 qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com,
 sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com,
 elif.topuz@arm.com
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org>
 <50f73e24-bf40-4fcf-a232-8747087ddbeb@arm.com>
 <CAKfTPtDJFkSJm67CzoB=p5PCc60eVToEcy-=bxaThLXr5KGd7A@mail.gmail.com>
Content-Language: en-US
From: Elif Topuz <elif.topuz@arm.com>
In-Reply-To: <CAKfTPtDJFkSJm67CzoB=p5PCc60eVToEcy-=bxaThLXr5KGd7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 25/11/2026 08:17, Vincent Guittot wrote:
> Hi Elif,
> 
> On Tue, 24 Nov 2026 at 16:13, Elif Topuz <elif.topuz@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> On 06/11/2026 15:19, Vincent Guittot wrote:
>>> Similarly to delayed dequeue, which enables an entity to decay its negative
>>> lag while sleeping, a task should not keep a positive lag forever.
>>>
>>> The sleep duration and the weight are used to decay the positive lag at
>>> wakeup.
>>>
>>> Apply the decay when enqueueing on prev rq for which we hold the lock to
>>> get rq_clock_task().
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
>>>  1 file changed, 90 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 0feec172fd37..5cd171f830d8 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>       return avruntime - vlag != se->vruntime;
>>>  }
>>>
>>> +/*
>>> + * Signed add and clamp on underflow.
>>> + *
>>> + * Explicitly do a load-store to ensure the intermediate value never hits
>>> + * memory. This allows lockless observations without ever seeing the negative
>>> + * values.
>>> + */
>>> +#define add_positive(_ptr, _val) do {                           \
>>> +     typeof(_ptr) ptr = (_ptr);                              \
>>> +     __signed_scalar_typeof(*ptr) val = (_val);              \
>>> +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
>>> +                                                             \
>>> +     res = var + val;                                        \
>>> +                                                             \
>>> +     if (val < 0 && res > var)                               \
>>> +             res = 0;                                        \
>>> +                                                             \
>>> +     WRITE_ONCE(*ptr, res);                                  \
>>> +} while (0)
>>> +
>>> +/*
>>> + * Remove and clamp on negative, from a local variable.
>>> + *
>>> + * A variant of sub_positive(), which does not use explicit load-store
>>> + * and is thus optimized for local variable updates.
>>> + */
>>> +#define lsub_positive(_ptr, _val) do {                               \
>>> +     typeof(_ptr) ptr = (_ptr);                              \
>>> +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
>>> +} while (0)
>>> +
>>> +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
>>> +static unsigned long task_h_load(struct task_struct *p);
>>> +
>>> +static __always_inline
>>> +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
>>> +{
>>> +     struct sched_entity *se = &p->se;
>>> +     s64 delta_exec, vlag = se->vlag;
>>> +     unsigned long cfs_load;
>>> +     struct rq *rq;
>>> +
>>> +     WARN_ON_ONCE(se->on_rq);
>>> +
>>> +     /* Negative lag is managed by delayed dequeue path */
>>> +     if (vlag <= 0)
>>> +             return;
>>> +
>>> +     rq = rq_of(cfs_rq);
>>> +
>>> +     /* No fast access to prev rq task clock */
>>> +     if (flags & ENQUEUE_MIGRATED)
>>> +             return;
>>> +
>>> +     /* Compute sleep time */
>>> +     delta_exec = rq_clock_task(rq) - se->exec_start;
>>> +     if (unlikely(delta_exec <= 0))
>>> +             return;
>>> +
>>> +     /* For anything above ~4 seconds, save computation and clear the lag */
>>> +     if (unlikely(delta_exec >> 32)) {
>>> +             se->vlag = 0;
>>> +             return;
>>> +     }
>>> +
>>> +     /*
>>> +      * Use cfs' load and p's weight to estimate what would have been the
>>> +      * share for p. task's load contribution to cfs' load is replaced by
>>> +      * its weight.
>>> +      */
>>> +     cfs_load = cfs_rq_load_avg(cfs_rq);
>>> +     lsub_positive(&cfs_load, task_h_load(p));
>>> +     if (cfs_load) {
>>> +             unsigned long weight = scale_load_down(se->h_load.weight);
>>> +
>>> +             delta_exec *= weight;
>>> +             delta_exec = div64_long(delta_exec, cfs_load + weight);
>>> +     }
>>> +
>>> +     vlag -= calc_delta_fair(delta_exec, se);
>>> +
>>> +     /* vlag can't become neg while sleeping */
>>> +     se->vlag = max(0, vlag);
>>> +}
>>> +
>>>  /*
>>>   * Entity is eligible once it received less service than it ought to have,
>>>   * eg. lag >= 0.
>>> @@ -4693,38 +4778,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>       cfs_rq->nr_queued--;
>>>  }
>>>
>>> -/*
>>> - * Signed add and clamp on underflow.
>>> - *
>>> - * Explicitly do a load-store to ensure the intermediate value never hits
>>> - * memory. This allows lockless observations without ever seeing the negative
>>> - * values.
>>> - */
>>> -#define add_positive(_ptr, _val) do {                           \
>>> -     typeof(_ptr) ptr = (_ptr);                              \
>>> -     __signed_scalar_typeof(*ptr) val = (_val);              \
>>> -     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
>>> -                                                             \
>>> -     res = var + val;                                        \
>>> -                                                             \
>>> -     if (val < 0 && res > var)                               \
>>> -             res = 0;                                        \
>>> -                                                             \
>>> -     WRITE_ONCE(*ptr, res);                                  \
>>> -} while (0)
>>> -
>>> -/*
>>> - * Remove and clamp on negative, from a local variable.
>>> - *
>>> - * A variant of sub_positive(), which does not use explicit load-store
>>> - * and is thus optimized for local variable updates.
>>> - */
>>> -#define lsub_positive(_ptr, _val) do {                               \
>>> -     typeof(_ptr) ptr = (_ptr);                              \
>>> -     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
>>> -} while (0)
>>> -
>>> -
>>>  /*
>>>   * Because of rounding, se->util_sum might ends up being +1 more than
>>>   * cfs->util_sum. Although this is not a problem by itself, detaching
>>> @@ -8152,7 +8205,7 @@ static void
>>>  enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>  {
>>>       int rq_h_nr_queued = rq->cfs.h_nr_queued;
>>> -     int task_new = !(flags & ENQUEUE_WAKEUP);
>>> +     int task_wake = flags & ENQUEUE_WAKEUP;
>>>       struct sched_entity *se = &p->se;
>>>       struct cfs_rq *cfs_rq = &rq->cfs;
>>>       unsigned long weight;
>>> @@ -8185,6 +8238,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>       if (p->in_iowait)
>>>               cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>>>
>>> +     if (task_wake)
>>> +             decay_entity_lag(cfs_rq, p, flags);
>>> +
>>>       curr = (cfs_rq->curr == se);
>>>       /*
>>>        * This can actually happen with CFS_BANDWIDTH, a task can be throttled
>>> @@ -8225,7 +8281,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>        * into account, but that is not straightforward to implement,
>>>        * and the following generally works well enough in practice.
>>>        */
>>> -     if (!task_new)
>>> +     if (task_wake)
>>>               check_update_overutilized_status(rq);
>>>
>>>       assert_list_leaf_cfs_rq(rq);
>>
>> I have tested the patchset with cyclictest and rtapp like you mentioned in your
>> cover letter. I have used Ampere Altra with 160 cpus.
>>
>> I run these sets:
>> - cyclictest with a 3777 us period and default slice with 2xNR_CPUS rt-app tasks
>> that run continuously with default slice.
>> - cyclictest with a 3777 us period and 8ms slice with 2xNR_CPUS rt-app tasks
>> that run continuously with a 16ms slice.
>> - cyclictest with a 3777 us period and default slice with 2xNR_CPUS rt-app tasks
>> run periodically with default slice.
>> - cyclictest with a 3777 us period and 8ms slice with 2xNR_CPUS rt-app tasks run
>> periodically with a 16ms slice.
>> I have also run them 130 seconds.
>>
>> Cases with continuous rt-app:
>>
>> | Kernel   | Slice   |   Samples |   P50 |   P90 |   P99 |   P99.9 |   Max |
>> |:---------|:--------|----------:|------:|------:|------:|--------:|------:|
>> | base     | Default |     34403 |    53 |    54 |    56 |     287 |  3996 |
>> | patch    | Default |     26748 |  1979 |  5637 |  7119 |    9264 | 10895 |
> 
> the p99.9 increase is somewhat expected and related to patches 1-4
> because we soften the capacity of short task to preempt current when
> they have the same slice
> 
>> | base     | 8/16 ms |     34406 |    53 |    54 |    56 |     269 | 11880 |
>> | patch    | 8/16 ms |     34256 |    53 |    54 |    62 |    9126 | 15429 |
> 
> The p99.9 value is not expected. Is it something that you can
> repeatedly reproduce? Also, what was the slice of other tasks on your
> system? if they stay to default 2.8ms they can disturb your test by
> preventing cyclictest to preempt rt-app. I noticed that when rt or
> deadline threads (like sugov) woke up simultaneously it could disturb
> cyclictest preemption. I'm working on fixing this for the next version
> I will look more deeply at this case while preparing the next version

yes, I have run the same experiment few more times and got the similar results.
As you said other tasks stayed to default 2.8ms in the system.

> 
>>
>> Percentage differences:
>>                                         base |                  patch
>> slice                                default |                default
>> 99th Percentile                           56 |         7119 (-12612%)
>> 99.9th Percentile                        287 |          9264 (-3128%)
>> Maximum                                 3996 |          10895 (-173%)
>>
>>                                         base |                  patch
>> slice                               8ms/16ms |               8ms/16ms
>> 99th Percentile                           56 |              62 (-11%)
>> 99.9th Percentile                        269 |          9126 (-3293%)
>> Maximum                                11880 |           15429 (-30%)
>>
>>
>> Cases with periodic rt-app:
>>
>> | Kernel   | Slice   |   Samples |   P50 |   P90 |   P99 |   P99.9 |   Max |
>> |:---------|:--------|----------:|------:|------:|------:|--------:|------:|
>> | base     | Default |     33795 |    56 |   901 |  4366 |    6156 |  9039 |
>> | patch    | Default |     33081 |    60 |  2734 |  5055 |    6395 |  9165 |
>> | base     | 8/16 ms |     34419 |    56 |    61 |    86 |     291 |   554 |
>> | patch    | 8/16 ms |     34419 |    56 |    59 |    77 |     161 |   540 |
> 
> Thise results are more aligned with my expectations
> 
>>
>> Percentage differences:
>>                                         base |                  patch
>> slice                                default |                default
>> 99th Percentile                         4366 |            5055 (-16%)
>> 99.9th Percentile                       6156 |             6395 (-4%)
>> Maximum                                 9039 |             9165 (-1%)
>>
>>                                         base |                  patch
>> slice                               8ms/16ms |               8ms/16ms
>> 99th Percentile                           86 |              77 (+10%)
>> 99.9th Percentile                        291 |             161 (+45%)
>> Maximum                                  554 |              540 (+3%)
>>
>> With the periodic rt-app the difference between base and patches are lower, and
>> using custom slices I can see the improvement. However, when using continuous
>> rt-app, especially with the default slice case, I see the worst latency. I have
>> noticed that this difference is coming from "decay_entity_lag()". If I
>> understand correctly, most of the time cyclictest's lag reduced to zero after
>> decay_entity_lag(), and it cannot preempt the rt-app tasks.
> 
> yes, patches 1-4 have the benefit to reduce preemption between tasks
> using the same slice but at the cost of scheduling latency for short
> sleeping tasks.
> 
>>
>> I have also run hackbench with continuous NR_CPUS rt-app tasks with default
>> slices and custom slices (hackbench with a 8ms slice and rt-app with a 16ms
>> slice). Both threads-pipe and process-pipe for g=1 and f=160 gave around 50%
>> worst execution time with default slice. When using custom slice, this
>> difference is much lower.
> 
> I haven't run those tests but will look into them. Have you tried
> hackbench alone and did you see some differences?

When running alone, the results are similar.

Default slice:
MODE    IPC      G  FD |    Base(s)/CV |   Patch(s)/CV |   diff%
----------------------------------------------------------------
process pipe     1  10 |   0.028/40.1% |   0.034/48.5% |  -22.9%
process pipe     1  20 |   0.093/38.5% |   0.081/57.2% |  +13.0%
process pipe     1  40 |   0.281/20.5% |   0.286/25.7% |   -1.9%
process pipe     1  80 |    0.824/4.8% |    0.844/5.3% |   -2.5%
process pipe     1 160 |    3.429/4.8% |    2.558/9.6% |  +25.4%
process socket   1  10 |   0.069/59.9% |   0.073/42.7% |   -5.3%
process socket   1  20 |   0.208/26.4% |   0.191/36.2% |   +8.4%
process socket   1  40 |    0.445/4.4% |    0.445/4.7% |   +0.2%
process socket   1  80 |    1.034/6.4% |    1.040/7.4% |   -0.5%
process socket   1 160 |    2.983/1.7% |    2.895/0.8% |   +2.9%
threads pipe     1  10 |   0.048/40.1% |   0.055/37.2% |  -15.3%
threads pipe     1  20 |   0.107/39.3% |   0.135/31.8% |  -26.5%
threads pipe     1  40 |   0.269/36.7% |   0.260/33.9% |   +3.5%
threads pipe     1  80 |   0.706/21.3% |    0.929/4.9% |  -31.6%
threads pipe     1 160 |    2.523/5.9% |    2.705/5.4% |   -7.2%
threads socket   1  10 |    0.110/8.7% |   0.099/22.2% |  +10.2%
threads socket   1  20 |    0.215/8.0% |   0.230/11.1% |   -6.9%
threads socket   1  40 |   0.423/39.2% |   0.420/29.7% |   +0.7%
threads socket   1  80 |    1.134/2.7% |    1.043/5.3% |   +8.1%
threads socket   1 160 |    3.111/2.1% |    3.036/1.1% |   +2.4%

[...]

Thanks,
Elif
