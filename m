From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V7 1/6] cpufreq: Don't allow updating inactive policies
 from sysfs
Date: Tue, 09 Jun 2015 14:50:53 -0700
Message-ID: <55775FBD.4030708@codeaurora.org>
References: <cover.1433767914.git.viresh.kumar@linaro.org> <243ddd967eebe1cafeda824a5ab5c67885d3653d.1433767914.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60991 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbFIVuz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2015 17:50:55 -0400
In-Reply-To: <243ddd967eebe1cafeda824a5ab5c67885d3653d.1433767914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, Srivatsa Bhat <srivatsa@mit.edu>

On 06/08/2015 05:55 AM, Viresh Kumar wrote:
> Later commits would change the way policies are managed today. Policies
> wouldn't be freed on cpu hotplug (currently they aren't freed only for
> suspend), and while the CPU is offline, the sysfs cpufreq files would
> still be present.
>
> User may accidentally try to update the sysfs files in following
> directory: '/sys/devices/system/cpu/cpuX/cpufreq/'. And that would
> result in undefined behavior as policy wouldn't be active then.
>
> Apart from updating the store() routine, we also update __cpufreq_get()
> which can call cpufreq_out_of_sync(). The later routine tries to update
> policy->cur and starts notifying kernel about it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5d780ff5a10a..7eeff892c0a6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -875,11 +875,18 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>
>   	down_write(&policy->rwsem);
>
> +	/* Updating inactive policies is invalid, so avoid doing that. */
> +	if (unlikely(policy_is_inactive(policy))) {
> +		ret = -EPERM;
> +		goto unlock_policy_rwsem;
> +	}
> +
>   	if (fattr->store)
>   		ret = fattr->store(policy, buf, count);
>   	else
>   		ret = -EIO;
>
> +unlock_policy_rwsem:
>   	up_write(&policy->rwsem);
>
>   	up_read(&cpufreq_rwsem);
> @@ -1610,6 +1617,10 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>
>   	ret_freq = cpufreq_driver->get(policy->cpu);
>
> +	/* Updating inactive policies is invalid, so avoid doing that. */
> +	if (unlikely(policy_is_inactive(policy)))
> +		return ret_freq;
> +
>   	if (ret_freq && policy->cur &&
>   		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
>   		/* verify no discrepancy between actual and
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
