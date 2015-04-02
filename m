From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 07/20] cpufreq: Call schedule_work() for the last active
 policy
Date: Wed, 01 Apr 2015 20:40:53 -0700
Message-ID: <551CBA45.6080702@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <d9273b6f27de39f077b97f2929b47aa885220933.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56817 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbDBDkz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 23:40:55 -0400
In-Reply-To: <d9273b6f27de39f077b97f2929b47aa885220933.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> We need to call schedule_work() only for the policy belonging to boot CPU, i.e.
> CPU0. Checking for list_is_last() wouldn't work anymore as there can be inactive
> policies present in the list after the last active one. 'policy' still points to
> the last active policy at the termination of the for_each_active_policy() loop,
> use that to call schedule_work().
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d3f9ce3b94d3..e728c796c327 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1779,15 +1779,14 @@ void cpufreq_resume(void)
>   		    || __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))
>   			pr_err("%s: Failed to start governor for policy: %p\n",
>   				__func__, policy);
> -
> -		/*
> -		 * schedule call cpufreq_update_policy() for boot CPU, i.e. last
> -		 * policy in list. It will verify that the current freq is in
> -		 * sync with what we believe it to be.
> -		 */
> -		if (list_is_last(&policy->policy_list, &cpufreq_policy_list))
> -			schedule_work(&policy->update);
>   	}
> +
> +	/*
> +	 * schedule call cpufreq_update_policy() for boot CPU, i.e. last
> +	 * policy in list. It will verify that the current freq is in
> +	 * sync with what we believe it to be.
> +	 */
> +	schedule_work(&policy->update);
>   }
>
>   /**

Ok, I don't think this will work after the next patch/end of the series.

Some ground rules/clarification: When the suspend/resume code and this 
cpufreq_suspend/resume functions talk about boot CPU, they don't really 
mean the boot CPU. It really means the CPU with the smallest CPU ID when 
suspend is initiated. For example in a 4 core system, if CPU0 is 
hotplugged off, then "boot CPU" in the context of suspend/resume is 
actually CPU1. That's the reason we can't simply do "get policy of CPU0" 
and the schedule work.

So what this patch really is assuming is that the last active policy in 
the policy list corresponds to the CPU with the smallest CPU ID when 
suspend is initiated.

That was true when we added/deleted policies when CPUs are hotplugged 
on/off (even during lightweight tear-down, we did add/delete). However, 
at the end of the series, we won't be adding/deleting these policies 
from the list for each hotplug add/remove. So, the last active policy in 
the list doesn't always correspond to the online CPU with the smallest 
CPU ID during suspend/resume.

Here's an example case:
* Assume we never physically hot plug the CPUs.
* Assume it's a system with 4 independent CPUs.
* We boot with just CPU0 active.
* So, the policy list will now have: CPU0 policy.
* CPU2 is then brought online.
* So, the policy list will now have: CPU2 policy, CPU0 policy.
* CPU1 is then brought online.
* So, the policy list will now have: CPU1 policy CPU2 policy, CPU0 policy.
* CPU0 is taken offline.
* So, the policy list will now have: CPU1 policy CPU2 policy, CPU0 
inactive policy.
* Now suspend happens and then we resume.
* We really need to be scheduling the work for CPU1 since that's the 
"boot cpu" for suspend/resume.
* But the last active policy is for CPU2 and we schedule work for that.

Nack for the patch, unless I missed some list maintenance code.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
