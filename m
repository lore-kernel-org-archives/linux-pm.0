From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 6/9] sched: cpufreq: detect, process remote callbacks
Date: Wed, 29 Mar 2017 23:58:07 +0200
Message-ID: <2471781.eoW74D262T@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <2e807adcbf0d5136876f9de48c62e9e2dd2a5b06.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51495 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753647AbdC2WDv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 18:03:51 -0400
In-Reply-To: <2e807adcbf0d5136876f9de48c62e9e2dd2a5b06.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

On Thursday, March 09, 2017 05:15:16 PM Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> A callback is considered remote if the target CPU is not the current CPU
> and if it is not managed by the policy managing the current CPU or the
> current CPU can't do DVFS on its behalf.
> 
> Queue the irq work for remote callbacks on the destination CPU. The irq
> work will carry out the fast or slow switch as appropriate.
> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> [ vk: commit log, code cleanups, introduce dvfs_possible_from_any_cpu
>       and drop late callback support to avoid IPIs on remote CPUs. ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index b168c31f1c8f..9bad579b6b08 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -100,11 +100,11 @@ static void sugov_fast_switch(struct cpufreq_policy *policy,
>  }
>  
>  static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> -				unsigned int next_freq)
> +				int cpu, bool remote, unsigned int next_freq)
>  {
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  
> -	if (policy->fast_switch_enabled) {
> +	if (policy->fast_switch_enabled && !remote) {
>  		if (sg_policy->next_freq == next_freq) {
>  			trace_cpu_frequency(policy->cur, policy->cpu);
>  			return;
> @@ -116,7 +116,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>  		sg_policy->next_freq = next_freq;
>  		sg_policy->last_freq_update_time = time;
>  		sg_policy->work_in_progress = true;
> -		irq_work_queue(&sg_policy->irq_work);
> +		irq_work_queue_on(&sg_policy->irq_work, cpu);
>  	}
>  }
>  
> @@ -206,6 +206,20 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned long util, max;
>  	unsigned int next_f;
> +	int cpu, this_cpu = smp_processor_id();
> +	bool remote;
> +
> +	if (policy->dvfs_possible_from_any_cpu) {
> +		/*
> +		 * Avoid sending IPI to 'hook->cpu' if this CPU can change
> +		 * frequency on its behalf.
> +		 */
> +		remote = false;
> +		cpu = this_cpu;
> +	} else {
> +		cpu = hook->cpu;
> +		remote = this_cpu != hook->cpu;
> +	}

Honestly, this dvfs_possible_from_any_cpu thing doesn't make the code
particularly clear and I wouldn't bother adding it, at least to start with.

I would just not do the fast switch for remote updates at all.

Plus, the single-CPU policy case is additionally complicated by the recent
addition of sugov_cpu_is_busy(), so that needs to be take into account too.

>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
> @@ -220,7 +234,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  		sugov_iowait_boost(sg_cpu, &util, &max);
>  		next_f = get_next_freq(sg_policy, util, max);
>  	}
> -	sugov_update_commit(sg_policy, time, next_f);
> +	sugov_update_commit(sg_policy, time, cpu, remote, next_f);
>  }
>  
>  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
> @@ -269,8 +283,24 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  {
>  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned long util, max;
>  	unsigned int next_f;
> +	int cpu, this_cpu = smp_processor_id();
> +	bool remote;
> +
> +	if (policy->dvfs_possible_from_any_cpu ||
> +	    cpumask_test_cpu(this_cpu, policy->cpus)) {

Again, is this actually worth it?

Thanks,
Rafael
