From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 07/18] cpufreq: Drop (now) useless check 'cpu > nr_cpu_ids'
Date: Wed, 11 Feb 2015 19:15:57 -0800
Message-ID: <54DC1AED.6020506@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <0b79fabc34316fe1e38c9cbe4750bd68ae65b03b.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60141 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbbBLDQD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 22:16:03 -0500
In-Reply-To: <0b79fabc34316fe1e38c9cbe4750bd68ae65b03b.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> Earlier we used to find the 'policy' belonging to a cpu with the help of a
> per-cpu variable. And if 'cpu' passed to cpufreq_cpu_get() is bigger than
> 'nr_cpu_ids', it would have caused unpredictable issues as the per-cpu variable
> wouldn't have covered that value of 'cpu'. And so we had this check.
>
> We traverse active-policy list to find policy for a cpu now. Even if 'cpu'
> passed to cpufreq_cpu_get() is an invalid number (i.e. greater than nr_cpu_ids),
> we will be able to manage it without any unpredictable behavior.
>
> And so this check isn't required anymore. Get rid of it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7f947287ba46..d9528046f651 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -172,9 +172,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>   	struct cpufreq_policy *policy = NULL;
>   	unsigned long flags;
>
> -	if (cpu >= nr_cpu_ids)
> -		return NULL;
> -
>   	if (!down_read_trylock(&cpufreq_rwsem))
>   		return NULL;
>
>

You are getting rid of this check because you no longer use the per-cpu 
variable. So, just squash it with the previous patch that removes the 
per-cpu variable?

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
