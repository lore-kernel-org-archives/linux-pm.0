From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 08/18] cpufreq: Add doc style comment about cpufreq_cpu_{get|put}()
Date: Wed, 11 Feb 2015 19:19:17 -0800
Message-ID: <54DC1BB5.2020107@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <7b7de04921e8e2e57fbe2c8e75898c9d9284a269.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60327 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbbBLDTY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 22:19:24 -0500
In-Reply-To: <7b7de04921e8e2e57fbe2c8e75898c9d9284a269.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> This clearly states what the code inside these routines is doing and how these
> must be used.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d9528046f651..21c8ef6073d7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -167,6 +167,23 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>   	return NULL;
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

I'm not sure we need to or should refer to kobject count (maybe just 
reference count instead?) and cpufreq_rwsem in the documentation. Those 
are implementation specific details and IMHO, shouldn't be in the 
documentation. I think it would be better to just explain the impact 
(which you already do) -- policy will never be freed and it will also 
prevent the cpufreq driver from getting unregistered.

Just my 2 cents.

>   struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>   {
>   	struct cpufreq_policy *policy = NULL;
> @@ -193,6 +210,16 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
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

Similar comment here.

>   void cpufreq_cpu_put(struct cpufreq_policy *policy)
>   {
>   	kobject_put(&policy->kobj);
>

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
