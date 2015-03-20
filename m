From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 02/20] cpufreq: Merge __cpufreq_add_dev() and cpufreq_add_dev()
Date: Thu, 19 Mar 2015 17:34:42 -0700
Message-ID: <550B6B22.1090500@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <cb3787174ea4da5ebe52efc974dff715c3241968.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38123 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbCTAen (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 20:34:43 -0400
In-Reply-To: <cb3787174ea4da5ebe52efc974dff715c3241968.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> cpufreq_add_dev() is an unnecessary wrapper over __cpufreq_add_dev(). Merge
> them.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 29 ++++++++++++-----------------
>   1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc51b8fbb0b0..4884caf92bff 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1125,7 +1125,16 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
>   	return 0;
>   }
>
> -static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> +/**
> + * cpufreq_add_dev - add a CPU device
> + *
> + * Adds the cpufreq interface for a CPU device.
> + *
> + * The Oracle says: try running cpufreq registration/unregistration concurrently
> + * with with cpu hotplugging and all hell will break loose. Tried to clean this
> + * mess up, but more thorough testing is needed. - Mathieu
> + */
> +static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   {
>   	unsigned int j, cpu = dev->id;
>   	int ret = -ENOMEM;
> @@ -1336,20 +1345,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   	return ret;
>   }
>
> -/**
> - * cpufreq_add_dev - add a CPU device
> - *
> - * Adds the cpufreq interface for a CPU device.
> - *
> - * The Oracle says: try running cpufreq registration/unregistration concurrently
> - * with with cpu hotplugging and all hell will break loose. Tried to clean this
> - * mess up, but more thorough testing is needed. - Mathieu
> - */
> -static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> -{
> -	return __cpufreq_add_dev(dev, sif);
> -}
> -
>   static int __cpufreq_remove_dev_prepare(struct device *dev,
>   					struct subsys_interface *sif)
>   {
> @@ -2328,7 +2323,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
>   	if (dev) {
>   		switch (action & ~CPU_TASKS_FROZEN) {
>   		case CPU_ONLINE:
> -			__cpufreq_add_dev(dev, NULL);
> +			cpufreq_add_dev(dev, NULL);
>   			break;
>
>   		case CPU_DOWN_PREPARE:
> @@ -2340,7 +2335,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
>   			break;
>
>   		case CPU_DOWN_FAILED:
> -			__cpufreq_add_dev(dev, NULL);
> +			cpufreq_add_dev(dev, NULL);
>   			break;
>   		}
>   	}
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
