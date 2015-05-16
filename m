From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 07/14] cpufreq: Don't allow updating inactive-policies from sysfs
Date: Sat, 16 May 2015 03:10:11 +0200
Message-ID: <2674706.qWzjVNUKcn@vostro.rjw.lan>
References: <cover.1431065963.git.viresh.kumar@linaro.org> <6ad4377106496d9d148005c902602c66eb307930.1431065963.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57751 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934479AbbEPAo5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 20:44:57 -0400
In-Reply-To: <6ad4377106496d9d148005c902602c66eb307930.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

The dash after "inactive" in the subject is not necessary IMO.

On Friday, May 08, 2015 11:53:50 AM Viresh Kumar wrote:
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
>  drivers/cpufreq/cpufreq.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index bd8a47b5054e..652a843a553b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -887,11 +887,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  
>  	down_write(&policy->rwsem);
>  
> +	/*
> +	 * Policy might not be active currently, and so we shouldn't try
> +	 * updating any values here. policy->cpus is cleared for inactive policy
> +	 * and so cpufreq_cpu_get_raw() should fail.

These comments don't really clarify things.  It'd be better to say something
like "Updating inactive policies is invalid, so avoid doing that."

> +	 */
> +	if (unlikely(policy_is_inactive(policy))) {
> +		ret = -EPERM;

This doesn't seem to be the appropriate error code to return here.

-EBUSY or -EAGAIN would be better IMO.

> +		goto unlock_policy_rwsem;
> +	}
> +
>  	if (fattr->store)
>  		ret = fattr->store(policy, buf, count);
>  	else
>  		ret = -EIO;
>  
> +unlock_policy_rwsem:
>  	up_write(&policy->rwsem);
>  
>  	up_read(&cpufreq_rwsem);
> @@ -1619,6 +1630,14 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>  
>  	ret_freq = cpufreq_driver->get(policy->cpu);
>  
> +	/*
> +	 * Policy might not be active currently, and so we shouldn't try
> +	 * updating any values here. policy->cpus is cleared for inactive policy
> +	 * and so cpufreq_cpu_get_raw() should fail.
> +	 */
> +	if (unlikely(policy_is_inactive(policy)))
> +		return ret_freq;
> +
>  	if (ret_freq && policy->cur &&
>  		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
>  		/* verify no discrepancy between actual and
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
