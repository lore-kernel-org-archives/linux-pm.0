From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 05/20] cpufreq: Clear policy->cpus even for the last
 CPU
Date: Thu, 19 Mar 2015 17:43:25 -0700
Message-ID: <550B6D2D.5080108@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <8c1be216c9f2e2b14a12d6acdbe49b7241d19ad0.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38488 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbCTAn1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 20:43:27 -0400
In-Reply-To: <8c1be216c9f2e2b14a12d6acdbe49b7241d19ad0.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> We clear policy->cpus mask while CPUs are hotplugged out. We do it for all CPUs
> except the last CPU of the policy. I don't remember what the rationale behind
> that was, but I couldn't think of anything that will break if we remove this
> conditional clearing and always clear policy->cpus.
>
> The benefit we get out of it is, we can know if a policy is active or not by
> checking if this field is empty or not. That will be used by later commits.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d06d1241a900..6ed87d02d293 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,9 +1430,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>
>   	down_write(&policy->rwsem);
>   	cpus = cpumask_weight(policy->cpus);
> -
> -	if (cpus > 1)
> -		cpumask_clear_cpu(cpu, policy->cpus);
> +	cpumask_clear_cpu(cpu, policy->cpus);
>   	up_write(&policy->rwsem);
>
>   	/* If cpu is last user of policy, free policy */
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
