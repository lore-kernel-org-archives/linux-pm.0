From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Restore policy min/max limits on CPU online
Date: Fri, 17 Mar 2017 08:50:16 +0530
Message-ID: <20170317032016.GC31040@vireshk-i7>
References: <2084010.4xkKok06Gp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36649 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdCQD2N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 23:28:13 -0400
Received: by mail-pf0-f176.google.com with SMTP id o126so33417690pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2017 20:28:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2084010.4xkKok06Gp@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 16-03-17, 23:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On CPU online the cpufreq core restores the previous governor (or
> the previous "policy" setting for ->setpolicy drivers), but it does
> not restore the min/max limits at the same time, which is confusing,
> inconsistent and real pain for users who set the limits and then
> suspend/resume the system (using full suspend), in which case the
> limits are reset on all CPUs except for the boot one.
> 
> Fix this by making cpufreq_init_policy() restore the limits when it
> sees that this is CPU online and not initialization from scratch.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -979,6 +979,8 @@ static int cpufreq_init_policy(struct cp
>  	/* Update governor of new_policy to the governor used before hotplug */
>  	gov = find_governor(policy->last_governor);
>  	if (gov) {
> +		new_policy.min = policy->user_policy.min;
> +		new_policy.max = policy->user_policy.max;
>  		pr_debug("Restoring governor %s for cpu %d\n",
>  				policy->governor->name, policy->cpu);
>  	} else {
> @@ -991,11 +993,14 @@ static int cpufreq_init_policy(struct cp
>  
>  	/* Use the default policy if there is no last_policy. */
>  	if (cpufreq_driver->setpolicy) {
> -		if (policy->last_policy)
> +		if (policy->last_policy) {
>  			new_policy.policy = policy->last_policy;
> -		else
> +			new_policy.min = policy->user_policy.min;
> +			new_policy.max = policy->user_policy.max;
> +		} else {
>  			cpufreq_parse_governor(gov->name, &new_policy.policy,
>  					       NULL);
> +		}
>  	}
>  	/* set default policy */
>  	return cpufreq_set_policy(policy, &new_policy);

What about something like this instead ?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b8ff617d449d..5dbdd261aa73 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1184,6 +1184,9 @@ static int cpufreq_online(unsigned int cpu)
                for_each_cpu(j, policy->related_cpus)
                        per_cpu(cpufreq_cpu_data, j) = policy;
                write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+       } else {
+               policy->min = policy->user_policy.min;
+               policy->max = policy->user_policy.max;
        }
 
        if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {


-- 
viresh
