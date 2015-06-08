From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V7 1/6] cpufreq: Don't allow updating inactive policies from sysfs
Date: Tue, 09 Jun 2015 01:19:23 +0200
Message-ID: <1543467.8Qo1djPj9c@vostro.rjw.lan>
References: <cover.1433767914.git.viresh.kumar@linaro.org> <243ddd967eebe1cafeda824a5ab5c67885d3653d.1433767914.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61706 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932101AbbFHWxg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 18:53:36 -0400
In-Reply-To: <243ddd967eebe1cafeda824a5ab5c67885d3653d.1433767914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Monday, June 08, 2015 06:25:27 PM Viresh Kumar wrote:
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
>  drivers/cpufreq/cpufreq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5d780ff5a10a..7eeff892c0a6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -875,11 +875,18 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  
>  	down_write(&policy->rwsem);
>  
> +	/* Updating inactive policies is invalid, so avoid doing that. */
> +	if (unlikely(policy_is_inactive(policy))) {
> +		ret = -EPERM;

I'm not sure if -EPERM is the best error code for this case.  It doesn't depend
on the actual permissions, but rather on the policy status that may change
going forward.

It might be better to use -EBUSY even.

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
> @@ -1610,6 +1617,10 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>  
>  	ret_freq = cpufreq_driver->get(policy->cpu);
>  
> +	/* Updating inactive policies is invalid, so avoid doing that. */
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
