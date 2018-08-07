From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Tue, 7 Aug 2018 14:54:04 +0100
Message-ID: <20180807135403.s7jktvxmhycujeht@queper01-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-7-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Monday 06 Aug 2018 at 17:39:38 (+0100), Patrick Bellasi wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a7affc729c25..bb25ef66c2d3 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -200,6 +200,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util_cfs, util_rt;
>  	unsigned long util, irq, max;
>  
>  	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);

IIUC, not far below this you should still have something like:

	if (rt_rq_is_runnable(&rq->rt))
		return max;

So you won't reach the actual clamping code at the end of the function
when a RT task is runnable no?

Also, I always had the feeling that the default for RT should be
util_min == 1024, and then users could decide to lower the bar if they
want to. For the specific case of RT, that feels more natural than
applying a max util clamp IMO. What do you think ?

Thanks,
Quentin
