From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required RT CPU capacity
Date: Wed, 31 Aug 2016 03:31:07 +0200
Message-ID: <1779842.1JHXT67au9@vostro.rjw.lan>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org> <1472236848-17038-3-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472236848-17038-3-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 26, 2016 11:40:48 AM Steve Muckle wrote:
> A policy of going to fmax on any RT activity will be detrimental
> for power on many platforms. Often RT accounts for only a small amount
> of CPU activity so sending the CPU frequency to fmax is overkill. Worse
> still, some platforms may not be able to even complete the CPU frequency
> change before the RT activity has already completed.
> 
> Cpufreq governors have not treated RT activity this way in the past so
> it is not part of the expected semantics of the RT scheduling class. The
> DL class offers guarantees about task completion and could be used for
> this purpose.
> 
> Modify the schedutil algorithm to instead use rt_avg as an estimate of
> RT utilization of the CPU.
> 
> Based on previous work by Vincent Guittot <vincent.guittot@linaro.org>.

If we do it for RT, why not to do a similar thing for DL?  As in the
original patch from Peter, for example?

> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index cb8a77b1ef1b..89094a466250 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -146,13 +146,21 @@ static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
>  
>  static void sugov_get_util(unsigned long *util, unsigned long *max)
>  {
> -	struct rq *rq = this_rq();
> -	unsigned long cfs_max;
> +	int cpu = smp_processor_id();
> +	struct rq *rq = cpu_rq(cpu);
> +	unsigned long max_cap, rt;
> +	s64 delta;
>  
> -	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +	max_cap = arch_scale_cpu_capacity(NULL, cpu);
>  
> -	*util = min(rq->cfs.avg.util_avg, cfs_max);
> -	*max = cfs_max;
> +	delta = rq_clock(rq) - rq->age_stamp;
> +	if (unlikely(delta < 0))
> +		delta = 0;
> +	rt = div64_u64(rq->rt_avg, sched_avg_period() + delta);
> +	rt = (rt * max_cap) >> SCHED_CAPACITY_SHIFT;

These computations are rather heavy, so I wonder if they are avoidable based
on the flags, for example?

Plus is SCHED_CAPACITY_SHIFT actually defined for all architectures?

One more ugly thing is about using rq_clock(rq) directly from here whereas we
pass it around as the 'time' argument elsewhere.

> +
> +	*util = min(rq->cfs.avg.util_avg + rt, max_cap);
> +	*max = max_cap;
>  }

Thanks,
Rafael
