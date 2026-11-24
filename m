Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533221;
	b=XzvfK4g+jl1hsAq1q98t1typcsmnmT14OD4dNxUsGIkdambuDPim+Fl03Bpg9eLYl+Gc
	 dXDsbWJ+ZEEahDHqcCirZvFuilrL/V05oQk6LH16/GkctnLdLg/nSXDciy4Y2gUhkhdK3
	 i8GcjWMebnasDGX16jkPlZwFnTomOXlGZKiw5jT+5mHqNaihe51yTf/rhmKg9Xb5OAeN1
	 6XryTVBV5wv5ZaeAmdjLV5rn2mRVAm7p7myCCGwCQQyryPR09Sbnu1QxBqO6EXC8kCGnh
	 WDHdNkUO79G7Amo0kkyA4nv2NfOkzwUmeh38tg5VCJFnSoc9lblEChzgJg1gNF0+CuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533221;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xuVnGIq70Jt7PsLqUtpwUEIHH5cTzo6TThTgCw0Rhmg=;
	b=WnO7pYeESiS8SRP+N19je9GAEShmfZh/oZfRGpg9Tpyb5yeLWmDr6psUf3ZvBo2Uy6Pz
	 hhTIYBvd8PGFIx6nSWmINjdjjlwZbkVCNGHDyNeBBZLNVn5uFkaOwKugRAUDBpZ9gPuvR
	 EqkkrlJFVlh7OA4QqQTpwL8eIWOuEbSEMOXTVIO77rZrqKCjoas/kt039lGiYMowheqAb
	 LM13mYLOnY16+UHD76bnRk+WST362z0biKlWgfeUB/COIkl68InHMa3xKu2eqCtqwKmrc
	 oachNgmGQ/MEjgZ0HmyZ5XDxAVOn4S4ls7WlywCZomC1d6C2h8Dcq5C7B6bf2Q94IbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="UBlph/+B";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB217606A31E;
	Tue, 24 Nov 2026 15:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB217606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UBlph/+B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D67339;
	Tue, 24 Nov 2026 07:13:37 -0800 (PST)
Received: from [10.57.69.110] (unknown [10.57.69.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55B03F763;
	Tue, 24 Nov 2026 07:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795533219; bh=WiPkPoBbp9Cc4cKVNnuwwTitom9qXMyF6bdGvW//2HA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UBlph/+B/mpsl9P2mJbFwn4P+NGHaVMeAiHlFexcPanZuL+GOMX0ztIo/2BAy7Ash
	 /rii2xZaxliZlo86bV/eFcQZhxSTg+6pe5kXJTQxtLP1lyziPcnHV9+V54bIB48AuC
	 DVMx1+TqUPy/SH3uMJsmr4j3Q/jpc6YcwhFwxdVI=
Message-ID: <50f73e24-bf40-4fcf-a232-8747087ddbeb@arm.com>
Date: Tue, 24 Nov 2026 15:13:14 +0000
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
Content-Language: en-US
From: Elif Topuz <elif.topuz@arm.com>
In-Reply-To: <20261106151947.3991524-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 06/11/2026 15:19, Vincent Guittot wrote:
> Similarly to delayed dequeue, which enables an entity to decay its negative
> lag while sleeping, a task should not keep a positive lag forever.
> 
> The sleep duration and the weight are used to decay the positive lag at
> wakeup.
> 
> Apply the decay when enqueueing on prev rq for which we hold the lock to
> get rq_clock_task().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 90 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0feec172fd37..5cd171f830d8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	return avruntime - vlag != se->vruntime;
>  }
>  
> +/*
> + * Signed add and clamp on underflow.
> + *
> + * Explicitly do a load-store to ensure the intermediate value never hits
> + * memory. This allows lockless observations without ever seeing the negative
> + * values.
> + */
> +#define add_positive(_ptr, _val) do {                           \
> +	typeof(_ptr) ptr = (_ptr);                              \
> +	__signed_scalar_typeof(*ptr) val = (_val);              \
> +	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> +								\
> +	res = var + val;                                        \
> +								\
> +	if (val < 0 && res > var)                               \
> +		res = 0;                                        \
> +								\
> +	WRITE_ONCE(*ptr, res);                                  \
> +} while (0)
> +
> +/*
> + * Remove and clamp on negative, from a local variable.
> + *
> + * A variant of sub_positive(), which does not use explicit load-store
> + * and is thus optimized for local variable updates.
> + */
> +#define lsub_positive(_ptr, _val) do {				\
> +	typeof(_ptr) ptr = (_ptr);				\
> +	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
> +} while (0)
> +
> +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> +static unsigned long task_h_load(struct task_struct *p);
> +
> +static __always_inline
> +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> +{
> +	struct sched_entity *se = &p->se;
> +	s64 delta_exec, vlag = se->vlag;
> +	unsigned long cfs_load;
> +	struct rq *rq;
> +
> +	WARN_ON_ONCE(se->on_rq);
> +
> +	/* Negative lag is managed by delayed dequeue path */
> +	if (vlag <= 0)
> +		return;
> +
> +	rq = rq_of(cfs_rq);
> +
> +	/* No fast access to prev rq task clock */
> +	if (flags & ENQUEUE_MIGRATED)
> +		return;
> +
> +	/* Compute sleep time */
> +	delta_exec = rq_clock_task(rq) - se->exec_start;
> +	if (unlikely(delta_exec <= 0))
> +		return;
> +
> +	/* For anything above ~4 seconds, save computation and clear the lag */
> +	if (unlikely(delta_exec >> 32)) {
> +		se->vlag = 0;
> +		return;
> +	}
> +
> +	/*
> +	 * Use cfs' load and p's weight to estimate what would have been the
> +	 * share for p. task's load contribution to cfs' load is replaced by
> +	 * its weight.
> +	 */
> +	cfs_load = cfs_rq_load_avg(cfs_rq);
> +	lsub_positive(&cfs_load, task_h_load(p));
> +	if (cfs_load) {
> +		unsigned long weight = scale_load_down(se->h_load.weight);
> +
> +		delta_exec *= weight;
> +		delta_exec = div64_long(delta_exec, cfs_load + weight);
> +	}
> +
> +	vlag -= calc_delta_fair(delta_exec, se);
> +
> +	/* vlag can't become neg while sleeping */
> +	se->vlag = max(0, vlag);
> +}
> +
>  /*
>   * Entity is eligible once it received less service than it ought to have,
>   * eg. lag >= 0.
> @@ -4693,38 +4778,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	cfs_rq->nr_queued--;
>  }
>  
> -/*
> - * Signed add and clamp on underflow.
> - *
> - * Explicitly do a load-store to ensure the intermediate value never hits
> - * memory. This allows lockless observations without ever seeing the negative
> - * values.
> - */
> -#define add_positive(_ptr, _val) do {                           \
> -	typeof(_ptr) ptr = (_ptr);                              \
> -	__signed_scalar_typeof(*ptr) val = (_val);              \
> -	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> -								\
> -	res = var + val;                                        \
> -								\
> -	if (val < 0 && res > var)                               \
> -		res = 0;                                        \
> -								\
> -	WRITE_ONCE(*ptr, res);                                  \
> -} while (0)
> -
> -/*
> - * Remove and clamp on negative, from a local variable.
> - *
> - * A variant of sub_positive(), which does not use explicit load-store
> - * and is thus optimized for local variable updates.
> - */
> -#define lsub_positive(_ptr, _val) do {				\
> -	typeof(_ptr) ptr = (_ptr);				\
> -	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
> -} while (0)
> -
> -
>  /*
>   * Because of rounding, se->util_sum might ends up being +1 more than
>   * cfs->util_sum. Although this is not a problem by itself, detaching
> @@ -8152,7 +8205,7 @@ static void
>  enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	int rq_h_nr_queued = rq->cfs.h_nr_queued;
> -	int task_new = !(flags & ENQUEUE_WAKEUP);
> +	int task_wake = flags & ENQUEUE_WAKEUP;
>  	struct sched_entity *se = &p->se;
>  	struct cfs_rq *cfs_rq = &rq->cfs;
>  	unsigned long weight;
> @@ -8185,6 +8238,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (p->in_iowait)
>  		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>  
> +	if (task_wake)
> +		decay_entity_lag(cfs_rq, p, flags);
> +
>  	curr = (cfs_rq->curr == se);
>  	/*
>  	 * This can actually happen with CFS_BANDWIDTH, a task can be throttled
> @@ -8225,7 +8281,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 * into account, but that is not straightforward to implement,
>  	 * and the following generally works well enough in practice.
>  	 */
> -	if (!task_new)
> +	if (task_wake)
>  		check_update_overutilized_status(rq);
>  
>  	assert_list_leaf_cfs_rq(rq);

I have tested the patchset with cyclictest and rtapp like you mentioned in your
cover letter. I have used Ampere Altra with 160 cpus.

I run these sets:
- cyclictest with a 3777 us period and default slice with 2xNR_CPUS rt-app tasks
that run continuously with default slice.
- cyclictest with a 3777 us period and 8ms slice with 2xNR_CPUS rt-app tasks
that run continuously with a 16ms slice.
- cyclictest with a 3777 us period and default slice with 2xNR_CPUS rt-app tasks
run periodically with default slice.
- cyclictest with a 3777 us period and 8ms slice with 2xNR_CPUS rt-app tasks run
periodically with a 16ms slice.
I have also run them 130 seconds.

Cases with continuous rt-app:

| Kernel   | Slice   |   Samples |   P50 |   P90 |   P99 |   P99.9 |   Max |
|:---------|:--------|----------:|------:|------:|------:|--------:|------:|
| base     | Default |     34403 |    53 |    54 |    56 |     287 |  3996 |
| patch    | Default |     26748 |  1979 |  5637 |  7119 |    9264 | 10895 |
| base     | 8/16 ms |     34406 |    53 |    54 |    56 |     269 | 11880 |
| patch    | 8/16 ms |     34256 |    53 |    54 |    62 |    9126 | 15429 |

Percentage differences:
                                        base |                  patch
slice                                default |                default
99th Percentile                           56 |         7119 (-12612%)
99.9th Percentile                        287 |          9264 (-3128%)
Maximum                                 3996 |          10895 (-173%)

                                        base |                  patch
slice                               8ms/16ms |               8ms/16ms
99th Percentile                           56 |              62 (-11%)
99.9th Percentile                        269 |          9126 (-3293%)
Maximum                                11880 |           15429 (-30%)


Cases with periodic rt-app:

| Kernel   | Slice   |   Samples |   P50 |   P90 |   P99 |   P99.9 |   Max |
|:---------|:--------|----------:|------:|------:|------:|--------:|------:|
| base     | Default |     33795 |    56 |   901 |  4366 |    6156 |  9039 |
| patch    | Default |     33081 |    60 |  2734 |  5055 |    6395 |  9165 |
| base     | 8/16 ms |     34419 |    56 |    61 |    86 |     291 |   554 |
| patch    | 8/16 ms |     34419 |    56 |    59 |    77 |     161 |   540 |

Percentage differences:
                                        base |                  patch
slice                                default |                default
99th Percentile                         4366 |            5055 (-16%)
99.9th Percentile                       6156 |             6395 (-4%)
Maximum                                 9039 |             9165 (-1%)

                                        base |                  patch
slice                               8ms/16ms |               8ms/16ms
99th Percentile                           86 |              77 (+10%)
99.9th Percentile                        291 |             161 (+45%)
Maximum                                  554 |              540 (+3%)

With the periodic rt-app the difference between base and patches are lower, and
using custom slices I can see the improvement. However, when using continuous
rt-app, especially with the default slice case, I see the worst latency. I have
noticed that this difference is coming from "decay_entity_lag()". If I
understand correctly, most of the time cyclictest's lag reduced to zero after
decay_entity_lag(), and it cannot preempt the rt-app tasks.

I have also run hackbench with continuous NR_CPUS rt-app tasks with default
slices and custom slices (hackbench with a 8ms slice and rt-app with a 16ms
slice). Both threads-pipe and process-pipe for g=1 and f=160 gave around 50%
worst execution time with default slice. When using custom slice, this
difference is much lower.

Default slice:
MODE    IPC      G  FD |    Base(s)/CV |   Patch(s)/CV |   diff%
----------------------------------------------------------------
process pipe     1  10 |   0.172/10.9% |   0.077/25.6% |  +55.4%
process pipe     1  20 |    0.409/6.7% |   0.558/18.9% |  -36.6%
process pipe     1  40 |   1.145/23.1% |   2.176/15.1% |  -90.1%
process pipe     1  80 |    5.326/7.5% |    7.248/8.6% |  -36.1%
process pipe     1 160 |   14.105/4.5% |   21.404/6.1% |  -51.7%
process socket   1  10 |  0.055/113.9% |   0.176/35.8% | -221.8%
process socket   1  20 |    0.467/3.5% |   0.454/21.0% |   +2.9%
process socket   1  40 |    1.014/5.6% |    1.062/5.4% |   -4.6%
process socket   1  80 |   2.584/10.8% |   2.820/16.9% |   -9.1%
process socket   1 160 |    6.786/7.7% |   7.525/13.1% |  -10.9%
threads pipe     1  10 |   0.050/10.9% |   0.148/14.5% | -198.0%
threads pipe     1  20 |   0.283/65.4% |   0.650/10.1% | -129.2%
threads pipe     1  40 |   1.285/53.5% |    2.269/7.9% |  -76.5%
threads pipe     1  80 |    5.702/5.7% |    7.727/8.2% |  -35.5%
threads pipe     1 160 |   14.412/5.7% |   22.659/8.4% |  -57.2%
threads socket   1  10 |   0.218/13.2% |   0.237/23.6% |   -9.1%
threads socket   1  20 |    0.528/3.3% |    0.533/6.3% |   -1.0%
threads socket   1  40 |    1.085/2.7% |   1.269/20.3% |  -17.0%
threads socket   1  80 |    2.549/8.0% |   3.258/22.7% |  -27.8%
threads socket   1 160 |    7.241/7.0% |   7.909/12.3% |   -9.2%

Custom slice:
MODE    IPC      G  FD |    Base(s)/CV |   Patch(s)/CV |   diff%
----------------------------------------------------------------
process pipe     1  10 |   0.053/54.7% |   0.040/40.9% |  +25.6%
process pipe     1  20 |   0.373/48.3% |   0.318/13.1% |  +14.7%
process pipe     1  40 |   1.130/40.4% |   1.704/23.1% |  -50.8%
process pipe     1  80 |   4.570/14.0% |   3.558/15.2% |  +22.2%
process pipe     1 160 |  11.877/10.9% |  13.374/17.3% |  -12.6%
process socket   1  10 |   0.068/15.1% |   0.095/34.8% |  -39.5%
process socket   1  20 |    0.222/8.1% |    0.278/2.1% |  -25.2%
process socket   1  40 |    0.716/2.7% |    0.660/4.6% |   +7.8%
process socket   1  80 |    3.261/9.6% |    1.768/5.7% |  +45.8%
process socket   1 160 |    8.099/3.9% |    6.134/9.7% |  +24.3%
threads pipe     1  10 |   0.048/31.6% |   0.060/29.8% |  -26.1%
threads pipe     1  20 |   0.264/15.0% |   0.232/17.2% |  +12.0%
threads pipe     1  40 |   0.838/20.9% |   1.558/25.6% |  -86.0%
threads pipe     1  80 |   5.794/15.9% |   3.933/23.3% |  +32.1%
threads pipe     1 160 |   14.666/7.7% |  12.614/16.4% |  +14.0%
threads socket   1  10 |   0.068/14.2% |   0.111/27.1% |  -62.7%
threads socket   1  20 |    0.232/8.2% |   0.334/12.1% |  -43.9%
threads socket   1  40 |    0.753/5.9% |   0.983/14.5% |  -30.5%
threads socket   1  80 |    3.655/6.3% |   2.585/21.5% |  +29.3%
threads socket   1 160 |    8.959/4.6% |    8.628/3.8% |   +3.7%

I have also used g=[1, 4, 8, 16] and f=20, but didn't see much difference
between the base and the patchset.

Thanks,
Elif

