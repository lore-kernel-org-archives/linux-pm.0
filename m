From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq: Schedule work for the first-online CPU on resume
Date: Thu, 02 Apr 2015 11:38:33 -0700
Message-ID: <551D8CA9.4010002@codeaurora.org>
References: <9775122d957a0cd594cfc43b2d81ebbf78e6dc2f.1427950272.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <9775122d957a0cd594cfc43b2d81ebbf78e6dc2f.1427950272.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "3.15+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/01/2015 09:51 PM, Viresh Kumar wrote:
> All CPUs leaving the first-online CPU are hotplugged out on suspend and
> and cpufreq core stops managing them.
>
> On resume, we need to call cpufreq_update_policy() for this CPU's policy
> to make sure its frequency is in sync with cpufreq's cached value, as it
> might have got updated by hardware during suspend/resume.
>
> The policies are always added to the top of the policy-list. So, in
> normal circumstances, CPU 0's policy will be the last one in the list.
> And so the code checks for the last policy.
>
> But there are cases where it will fail. Consider quad-core system, with
> policy-per core. If CPU0 is hotplugged out and added back again, the
> last policy will be on CPU1 :(
>
> To fix this in a proper way, always look for the policy of the first
> online CPU. That way we will be sure that we are calling
> cpufreq_update_policy() for the only CPU that wasn't hotplugged out.
>
> Cc: 3.15+ <stable@vger.kernel.org> # 3.15+
> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

"Reported by" or something similar for me identifying the issue?

> ---
>   drivers/cpufreq/cpufreq.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 28e59a48b35f..8ae655c364f4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1698,15 +1698,18 @@ void cpufreq_resume(void)
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
> +	 * schedule call cpufreq_update_policy() for first-online CPU, as that
> +	 * wouldn't be hotplugged-out on suspend. It will verify that the
> +	 * current freq is in sync with what we believe it to be.
> +	 */
> +	policy = cpufreq_cpu_get_raw(cpumask_first(cpu_online_mask));
> +	if (WARN_ON(!policy))
> +		return;
> +
> +	schedule_work(&policy->update);
>   }
>
>   /**
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
