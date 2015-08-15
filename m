From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 40/46] sched/cpufreq_sched: compute freq_new based
 on capacity_orig_of()
Date: Sat, 15 Aug 2015 14:46:38 +0200
Message-ID: <20150815124638.GG10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-41-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436293469-25707-41-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:23PM +0100, Morten Rasmussen wrote:
> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
> index 2968f3a..7071528 100644
> --- a/kernel/sched/cpufreq_sched.c
> +++ b/kernel/sched/cpufreq_sched.c
> @@ -184,7 +184,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>  		goto out;
>  
>  	/* Convert the new maximum capacity request into a cpu frequency */
> -	freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;
> +	freq_new = (capacity * policy->max) / capacity_orig_of(cpu);
>  
>  	/* No change in frequency? Bail and return current capacity. */
>  	if (freq_new == policy->cur)

Can't we avoid exporting that lot by simply passing in the right values
to begin with?
