From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 04/20] cpufreq: Keep a single path for adding managed
 CPUs
Date: Thu, 19 Mar 2015 17:37:45 -0700
Message-ID: <550B6BD9.7080602@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <ff44aa28b7c344936cbc43cfcff7efac92ad9700.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38203 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbCTAhr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 20:37:47 -0400
In-Reply-To: <ff44aa28b7c344936cbc43cfcff7efac92ad9700.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> There are two cases when we may try to add already managed CPUs:
The term manages CPUs is a bit unclear/confusing. When I hear managed 
CPUs, I think CPUs that are already marked in policy->cpus and the 
governor has already been started on them.

Can you clarify this commit text please?

> - On boot, the first cpu has marked all policy->cpus managed and so we will find
>    policy for all other policy->cpus later on.
> - When a managed cpu is hotplugged out and later brought back in.
>
> Currently we manage these two with separate paths and checks. While the first
> one is detected by testing cpu against 'policy->cpus', the other one is detected
> by testing cpu against 'policy->related_cpus'.
>
> We can manage both these via a single path and there is no need to do special
> checking for the first one.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9da8ed5bdd21..d06d1241a900 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -992,6 +992,10 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
>   	int ret = 0;
>   	unsigned long flags;
>
> +	/* Is cpu already managed ? */
> +	if (cpumask_test_cpu(cpu, policy->cpus))
> +		return 0;
> +
>   	if (has_target()) {
>   		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
>   		if (ret) {
> @@ -1147,16 +1151,10 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>
>   	pr_debug("adding CPU %u\n", cpu);
>
> -	/* check whether a different CPU already registered this
> -	 * CPU because it is in the same boat. */
> -	policy = cpufreq_cpu_get_raw(cpu);
> -	if (unlikely(policy))
> -		return 0;
> -
>   	if (!down_read_trylock(&cpufreq_rwsem))
>   		return 0;
>
> -	/* Check if this cpu was hot-unplugged earlier and has siblings */
> +	/* Check if this cpu already has a policy to manage it */
>   	read_lock_irqsave(&cpufreq_driver_lock, flags);
>   	for_each_policy(policy) {
>   		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
>

If comment text is fixed,
Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
