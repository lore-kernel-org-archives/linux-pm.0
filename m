From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 06/20] cpufreq: Create for_each_{in}active_policy()
Date: Thu, 19 Mar 2015 18:01:13 -0700
Message-ID: <550B7159.7090601@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <3335dcc924b60249617dfad711c602927fb1f2b7.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39294 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbCTBBP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 21:01:15 -0400
In-Reply-To: <3335dcc924b60249617dfad711c602927fb1f2b7.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> policy->cpus is cleared unconditionally now on hotplug-out of a CPU and it can
> be checked to know if a policy is active or inactive. Create helper routines to
> iterate over all active/inactive policies, based on policy->cpus field.
>
> Replace all instances of for_each_policy() with for_each_active_policy() to make
> them iterate only for active policies. (We haven't made changes yet to keep
> inactive policies in the same list, but that will be followed in a later patch).
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 81 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 72 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6ed87d02d293..d3f9ce3b94d3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -32,11 +32,74 @@
>   #include <trace/events/power.h>
>
>   /* Macros to iterate over lists */
> -/* Iterate over online CPUs policies */
>   static LIST_HEAD(cpufreq_policy_list);
> +static inline bool policy_is_inactive(struct cpufreq_policy *policy)
> +{
> +	return cpumask_empty(policy->cpus);
> +}
> +
> +/*
> + * Finds Next Acive/Inactive policy
> + *
> + * policy: Previous policy.
> + * active: Looking for active policy (true) or Inactive policy (false).
> + */
> +static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> +					  bool active)
> +{
> +	while (1) {

I don't like while(1) unless it's really meant to be an infinite loop. I 
think a do while would work here and also be more compact and readable.

> +		if (likely(policy))
> +			policy = list_next_entry(policy, policy_list);
> +		else
> +			policy = list_first_entry(&cpufreq_policy_list,
> +						  typeof(*policy), policy_list);

Can't you just move this part into expr1? That would make it much 
clear/easier to understand

> +
> +		/* No more policies */
> +		if (&policy->policy_list == &cpufreq_policy_list)
> +			return policy;

I'm kinda confused by the fact that you return policy here 
unconditionally. I think it's a bug. No? Eg: Is there's only one policy 
in the system and you are looking for an inactive policy. Wouldn't this 
return the only policy -- the one that's active.

> +
> +		/*
> +		 * Table to explains logic behind following expression:
> +		 *
> +		 *	Active		policy_is_inactive	Result
> +		 *						(policy or next)
> +		 *
> +		 *	0		0			next
> +		 *	0		1			policy
> +		 *	1		0			policy
> +		 *	1		1			next
> +		 */
> +		if (active ^ policy_is_inactive(policy))
> +			return policy;
> +	};
> +}
> +
> +/*
> + * Iterate over online CPUs policies
> + *
> + * Explanation:
> + * - expr1: marks __temp NULL and gets the first __active policy.
> + * - expr2: checks if list is finished, if yes then it sets __policy to the last
> + *	    __active policy and returns 0 to end the loop.
> + * - expr3: preserves last __active policy and gets the next one.
> + */
> +#define __for_each_active_policy(__policy, __temp, __active)		\
> +	for (__temp = NULL, __policy = next_policy(NULL, __active);	\
> +	     &__policy->policy_list != &cpufreq_policy_list ||		\
> +	     ((__policy = __temp) && 0);				\
> +	     __temp = __policy, __policy = next_policy(__policy, __active))
> +
>   #define for_each_policy(__policy)				\
>   	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
>
> +/*
> + * Routines to iterate over active or inactive policies
> + * __policy: next active/inactive policy will be returned in this.
> + * __temp: for internal purpose, not to be used by caller.
> + */
> +#define for_each_active_policy(__policy, __temp) __for_each_active_policy(__policy, __temp, true)
> +#define for_each_inactive_policy(__policy, __temp) __for_each_active_policy(__policy, __temp, false)
> +
>   /* Iterate over governors */
>   static LIST_HEAD(cpufreq_governor_list);
>   #define for_each_governor(__governor)				\

Stuff below this looks fine.

> @@ -1142,7 +1205,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   {
>   	unsigned int j, cpu = dev->id;
>   	int ret = -ENOMEM;
> -	struct cpufreq_policy *policy;
> +	struct cpufreq_policy *policy, *tpolicy;
>   	unsigned long flags;
>   	bool recover_policy = cpufreq_suspended;
>

<snip>

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
