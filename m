From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: Fix sugov_start versus
 sugov_update_shared race
Date: Fri, 7 Jul 2017 08:55:09 +0530
Message-ID: <20170707032509.GC1523@vireshk-i7>
References: <1499363600-10732-1-git-send-email-markivx@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35896 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbdGGDZO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 23:25:14 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so10311146pfl.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Jul 2017 20:25:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1499363600-10732-1-git-send-email-markivx@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikram Mulukutla <markivx@codeaurora.org>
Cc: rafael.j.wysocki@intel.com, juri.lelli@arm.com, skannan@codeaurora.org, linux-pm@vger.kernel.org

On 06-07-17, 10:53, Vikram Mulukutla wrote:
> With a shared policy in place, when one of the CPUs in the policy is
> hotplugged out and then brought back online, sugov_stop and
> sugov_start are called in order.
> 
> sugov_stop removes utilization hooks for each CPU in the policy and
> does nothing else in the for_each_cpu loop. sugov_start on the other
> hand iterates through the CPUs in the policy and re-initializes the
> per-cpu structure _and_ adds the utilization hook. This implies that
> the scheduler is allowed to invoke a CPU's utilization update hook
> when the rest of the per-cpu structures have yet to be re-inited.
> 
> Apart from some strange values in tracepoints this doesn't cause a
> problem, but if we do end up accessing a pointer from the per-cpu
> sugov_cpu structure somewhere in the sugov_update_shared path,
> we will likely see crashes since the memset for another CPU in the
> policy is free to race with sugov_update_shared from the CPU that is
> ready to go. So let's fix this now to first init all per-cpu
> structures, and then add the per-cpu utilization update hooks all at
> once.
> 
> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 076a2e3..29a3970 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -610,6 +610,11 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		sg_cpu->sg_policy = sg_policy;
>  		sg_cpu->flags = SCHED_CPUFREQ_RT;
>  		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
> +	}
> +
> +	for_each_cpu(cpu, policy->cpus) {
> +		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> +
>  		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
>  					     policy_is_shared(policy) ?
>  							sugov_update_shared :

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
