From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 01/20] cpufreq: Add doc style comment about cpufreq_cpu_{get|put}()
Date: Thu, 19 Mar 2015 17:34:30 -0700
Message-ID: <550B6B16.3050301@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <3e39c8ea46c06a2933e8bae2117396ed220d548b.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38109 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbCTAeb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 20:34:31 -0400
In-Reply-To: <3e39c8ea46c06a2933e8bae2117396ed220d548b.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> This clearly states what the code inside these routines is doing and how these
> must be used.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 28e59a48b35f..fc51b8fbb0b0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -207,6 +207,23 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>   	return per_cpu(cpufreq_cpu_data, cpu);
>   }
>
> +/**
> + * cpufreq_cpu_get: returns policy for a cpu and marks it busy.
> + *
> + * @cpu: cpu to find policy for.
> + *
> + * This returns policy for 'cpu', returns NULL if it doesn't exist.
> + * It also increments the kobject reference count to mark it busy and so would
> + * require a corresponding call to cpufreq_cpu_put() to decrement it back.
> + * If corresponding call cpufreq_cpu_put() isn't made, the policy wouldn't be
> + * freed as that depends on the kobj count.
> + *
> + * It also takes a read-lock of 'cpufreq_rwsem' and doesn't put it back if a
> + * valid policy is found. This is done to make sure the driver doesn't get
> + * unregistered while the policy is being used.
> + *
> + * Return: A valid policy on success, otherwise NULL on failure.
> + */
>   struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>   {
>   	struct cpufreq_policy *policy = NULL;
> @@ -237,6 +254,16 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
>
> +/**
> + * cpufreq_cpu_put: Decrements the usage count of a policy
> + *
> + * @policy: policy earlier returned by cpufreq_cpu_get().
> + *
> + * This decrements the kobject reference count incremented earlier by calling
> + * cpufreq_cpu_get().
> + *
> + * It also drops the read-lock of 'cpufreq_rwsem' taken at cpufreq_cpu_get().
> + */
>   void cpufreq_cpu_put(struct cpufreq_policy *policy)
>   {
>   	kobject_put(&policy->kobj);
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
