From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 1/5] cpufreq: Use cpumask_copy instead of cpumask_or to
 copy a mask
Date: Mon, 12 Oct 2015 12:12:56 -0700
Message-ID: <561C0638.8060105@codeaurora.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org> <b8dc587ec7767b89b1d24f1348acd1a341e54a4a.1444583718.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39626 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbbJLTM6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 15:12:58 -0400
In-Reply-To: <b8dc587ec7767b89b1d24f1348acd1a341e54a4a.1444583718.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/11/2015 10:21 AM, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

The commit text should explain the why you are doing this.

> ---
>   drivers/cpufreq/cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 25c4c15103a0..b32521432db4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1221,7 +1221,7 @@ static int cpufreq_online(unsigned int cpu)
>
>   	if (new_policy) {
>   		/* related_cpus should at least include policy->cpus. */
> -		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
> +		cpumask_copy(policy->related_cpus, policy->cpus);

Again, why? It actually seems wrong. A 4 core cluster could come up with 
just 2 cores when the policy is added. But the related CPUs would be 4 CPUs.

>   		/* Remember CPUs present at the policy creation time. */
>   		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
>   	}
>

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
