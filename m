From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 5/5] cpufreq: Drop redundant check for inactive policies
Date: Mon, 12 Oct 2015 12:35:38 -0700
Message-ID: <561C0B8A.5020808@codeaurora.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org> <2d6d59c2b0654872a32a9b63874b750e6b808cb5.1444583718.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41442 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbJLTfk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 15:35:40 -0400
In-Reply-To: <2d6d59c2b0654872a32a9b63874b750e6b808cb5.1444583718.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/11/2015 10:21 AM, Viresh Kumar wrote:
> We just made sure policy->cpu is online and this check will always fail
> as the policy is active. Drop it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 58aabe0f2d2c..4fa2215cc6ec 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -843,18 +843,11 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>
>   	down_write(&policy->rwsem);
>
> -	/* Updating inactive policies is invalid, so avoid doing that. */
> -	if (unlikely(policy_is_inactive(policy))) {
> -		ret = -EBUSY;
> -		goto unlock_policy_rwsem;
> -	}
> -
>   	if (fattr->store)
>   		ret = fattr->store(policy, buf, count);
>   	else
>   		ret = -EIO;
>
> -unlock_policy_rwsem:
>   	up_write(&policy->rwsem);
>   unlock:
>   	put_online_cpus();
>

Doesn't really seem related to the sysfs reorg/clean up. Should it be a 
separate patch outside of this series?

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
