From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid using inactive policies
Date: Fri, 18 Nov 2016 08:47:50 +0530
Message-ID: <20161118031750.GD3110@vireshk-i7>
References: <2600582.kqN5q7nCq0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36213 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbcKRDRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 22:17:54 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so52230878pfz.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2016 19:17:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2600582.kqN5q7nCq0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 17-11-16, 16:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two places in the cpufreq core in which low-level driver
> callbacks may be invoked for an inactive cpufreq policy, which isn't
> guaranteed to work in general.  Both are due to possible races with
> CPU offline.
> 
> First, in cpufreq_get(), the policy may become inactive after
> the check against policy->cpus in cpufreq_cpu_get() and before
> policy->rwsem is acquired, in which case using the policy going
> forward may not be correct.
> 
> Second, an analogous situation is possible in cpufreq_update_policy().
> 
> Avoid using inactive policies by adding policy_is_inactive() checks
> to the code in the above places.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1526,7 +1526,10 @@ unsigned int cpufreq_get(unsigned int cp
>  
>  	if (policy) {
>  		down_read(&policy->rwsem);
> -		ret_freq = __cpufreq_get(policy);
> +
> +		if (!policy_is_inactive(policy))
> +			ret_freq = __cpufreq_get(policy);
> +
>  		up_read(&policy->rwsem);
>  
>  		cpufreq_cpu_put(policy);
> @@ -2265,6 +2268,9 @@ int cpufreq_update_policy(unsigned int c
>  
>  	down_write(&policy->rwsem);
>  
> +	if (policy_is_inactive(policy))

You also need to set some value to 'ret' as it is uninitialized right now.

> +		goto unlock;
> +
>  	pr_debug("updating policy for CPU %u\n", cpu);
>  	memcpy(&new_policy, policy, sizeof(*policy));
>  	new_policy.min = policy->user_policy.min;

-- 
viresh
