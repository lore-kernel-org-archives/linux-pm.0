From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 03/20] cpufreq: Throw warning when we try to get policy
 for an invalid CPU
Date: Thu, 19 Mar 2015 17:34:58 -0700
Message-ID: <550B6B32.3060500@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <94d5e5e04cb8278ae9798a6a2837063152dd60aa.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38146 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbCTAe7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 20:34:59 -0400
In-Reply-To: <94d5e5e04cb8278ae9798a6a2837063152dd60aa.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> Simply returning here with an error is not enough. It shouldn't be allowed at
> all to try calling cpufreq_cpu_get() for an invalid CPU.
>
> Add a WARN here to make it clear that it wouldn't be acceptable at all.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4884caf92bff..9da8ed5bdd21 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -229,7 +229,7 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>   	struct cpufreq_policy *policy = NULL;
>   	unsigned long flags;
>
> -	if (cpu >= nr_cpu_ids)
> +	if (WARN_ON(cpu >= nr_cpu_ids))
>   		return NULL;
>
>   	if (!down_read_trylock(&cpufreq_rwsem))
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
