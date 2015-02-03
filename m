From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 01/18] cpufreq: Drop cpufreq_disabled() check from cpufreq_cpu_{get|put}()
Date: Tue, 03 Feb 2015 14:17:52 -0800
Message-ID: <54D14910.1020807@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <59b0050553f89e00298b585ba89d2627a0fab164.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42333 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbBCWRy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 17:17:54 -0500
In-Reply-To: <59b0050553f89e00298b585ba89d2627a0fab164.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> Even if cpufreq is disabled then also the per-cpu variable will return NULL and
> things will continue working as is. Remove this unnecessary check.

Commit text reword suggestion:

When cpufreq is disabled, the per-cpu variable would have been set to 
NULL. Remove this unnecessary check.

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index ca69f42b8e1e..72990ba59fad 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -203,7 +203,7 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>   	struct cpufreq_policy *policy = NULL;
>   	unsigned long flags;
>
> -	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
> +	if (cpu >= nr_cpu_ids)
>   		return NULL;
>
>   	if (!down_read_trylock(&cpufreq_rwsem))
> @@ -230,9 +230,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
>
>   void cpufreq_cpu_put(struct cpufreq_policy *policy)
>   {
> -	if (cpufreq_disabled())
> -		return;
> -
>   	kobject_put(&policy->kobj);
>   	up_read(&cpufreq_rwsem);
>   }
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
