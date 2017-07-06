From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: schedutil: Fix sugov_start versus sugov_update_shared race
Date: Thu, 06 Jul 2017 22:48:55 +0200
Message-ID: <9317902.eOnA0Raa4s@aspire.rjw.lan>
References: <1499363600-10732-1-git-send-email-markivx@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54230 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751873AbdGFU4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 16:56:36 -0400
In-Reply-To: <1499363600-10732-1-git-send-email-markivx@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikram Mulukutla <markivx@codeaurora.org>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, juri.lelli@arm.com, skannan@codeaurora.org, linux-pm@vger.kernel.org

On Thursday, July 06, 2017 10:53:20 AM Vikram Mulukutla wrote:
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

OK

Any objections anyone?

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
> 
