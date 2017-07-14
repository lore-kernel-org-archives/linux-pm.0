From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [Eas-dev] [PATCH V3 2/3] cpufreq: schedutil: Process remote callback
 for shared policies
Date: Thu, 13 Jul 2017 19:02:37 -0700
Message-ID: <5968263D.1020801@codeaurora.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org> <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59216 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbdGNCCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 22:02:39 -0400
In-Reply-To: <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org

On 07/12/2017 11:44 PM, Viresh Kumar wrote:
> This patch updates the schedutil governor to process cpufreq utilization
> update hooks called for remote CPUs.
>
> The schedutil governor already has proper locking in place for shared
> policy update hooks and nothing extra is required to be done.
>
> Based on initial work from Steve Muckle.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   kernel/sched/cpufreq_schedutil.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index ed9c589e5386..2599e7e7a82c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -154,12 +154,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>   	return cpufreq_driver_resolve_freq(policy, freq);
>   }
>
> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
>   {
> -	struct rq *rq = this_rq();
> +	struct rq *rq = cpu_rq(cpu);
>   	unsigned long cfs_max;
>
> -	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
>
>   	*util = min(rq->cfs.avg.util_avg, cfs_max);
>   	*max = cfs_max;
> @@ -233,7 +233,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>   	if (flags & SCHED_CPUFREQ_RT_DL) {
>   		next_f = policy->cpuinfo.max_freq;
>   	} else {
> -		sugov_get_util(&util, &max);
> +		sugov_get_util(&util, &max, hook->cpu);
>   		sugov_iowait_boost(sg_cpu, &util, &max);
>   		next_f = get_next_freq(sg_policy, util, max);
>   		/*
> @@ -291,14 +291,15 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>   {
>   	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>   	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +	struct cpufreq_policy *policy = sg_policy->policy;
>   	unsigned long util, max;
>   	unsigned int next_f;
>
> -	/* Don't allow remote callbacks */
> -	if (smp_processor_id() != hook->cpu)
> +	/* Allow remote callbacks only on the CPUs sharing cpufreq policy */
> +	if (!cpumask_test_cpu(smp_processor_id(), policy->cpus))
>   		return;

Honestly, this seems like such a chip/platform specific decision. 
There's no reason that one can't have a chip where you can change the 
frequency of any CPU from any other CPU. If there's such a limitation, 
we should let that be handled at the CPU freq driver level instead of 
having to know about any of that at the scheduler. Heck, at worst case, 
the CPU freq driver can send an IPI and execute that work on the CPU of 
interest.

In all Qualcomm chipsets (well, at least the ones that have been used in 
Android devices so far), we can switch the frequency of any CPU from any 
other CPU. If we can do that even without fast switching, why wouldn't 
any theoretical fast switching be incapable of supporting this? Is this 
a limitation specific to x86 that we are assuming all architectures and 
platforms are going to have?

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
