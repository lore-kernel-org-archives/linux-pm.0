From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/5] cpufreq: postfix policy directory with the first
 CPU in related_cpus
Date: Fri, 16 Oct 2015 12:38:42 +0530
Message-ID: <20151016070842.GY19018@linux>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
 <f64c9a0941f179d55ab95f4b9a038df0acbfefa3.1444924623.git.viresh.kumar@linaro.org>
 <561FFB30.8030406@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35666 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbbJPHIu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 03:08:50 -0400
Received: by pabws5 with SMTP id ws5so14681746pab.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 00:08:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <561FFB30.8030406@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 15-10-15, 12:14, Saravana Kannan wrote:
> On 10/15/2015 09:05 AM, Viresh Kumar wrote:
> >The sysfs policy directory is postfixed currently with the CPU number
> >for which the policy was created, which isn't necessarily the first CPU
> >in related_cpus mask.
> >
> >To make it more consistent and predictable, lets postfix the policy with
> >the first cpu in related-cpus mask.
> >
> >Suggested-by: Saravana Kannan <skannan@codeaurora.org>
> >Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >---
> >  drivers/cpufreq/cpufreq.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> >diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >index 4fa2215cc6ec..3fe13875565d 100644
> >--- a/drivers/cpufreq/cpufreq.c
> >+++ b/drivers/cpufreq/cpufreq.c
> >@@ -1022,7 +1022,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> >  {
> >  	struct device *dev = get_cpu_device(cpu);
> >  	struct cpufreq_policy *policy;
> >-	int ret;
> >
> >  	if (WARN_ON(!dev))
> >  		return NULL;
> >@@ -1040,13 +1039,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> >  	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
> >  		goto err_free_rcpumask;
> >
> >-	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
> >-				   cpufreq_global_kobject, "policy%u", cpu);
> >-	if (ret) {
> >-		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> >-		goto err_free_real_cpus;
> >-	}
> >-
> >  	INIT_LIST_HEAD(&policy->policy_list);
> >  	init_rwsem(&policy->rwsem);
> >  	spin_lock_init(&policy->transition_lock);
> >@@ -1057,7 +1049,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> >  	policy->cpu = cpu;
> >  	return policy;
> >
> >-err_free_real_cpus:
> >  	free_cpumask_var(policy->real_cpus);
> 
> Delete this line too? Does GCC not complain about unreachable code?

Ick.. Nah GCC never complained for it or may be it needs some other
compilation flags to complain about such cases.

> >  err_free_rcpumask:
> >  	free_cpumask_var(policy->related_cpus);
> >@@ -1163,6 +1154,16 @@ static int cpufreq_online(unsigned int cpu)
> >  		cpumask_copy(policy->related_cpus, policy->cpus);
> >  		/* Remember CPUs present at the policy creation time. */
> >  		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
> >+
> >+		/* Initialize the kobject */
> >+		ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
> >+					   cpufreq_global_kobject, "policy%u",
> >+					   cpumask_first(policy->related_cpus));
> >+		if (ret) {
> >+			pr_err("%s: failed to init policy->kobj: %d\n",
> >+			       __func__, ret);
> >+			goto out_exit_policy;
> 
> out_exit_policy label includes a call to cpufreq_policy_free(). That
> function needs to be changed to not call cpufreq_policy_put_kobj()
> in this case so that we don't try to kobject_put() an unallocated
> kobj.
> 
> Maybe you an call cpufreq_policy_put_kobj() in the error handling
> path of this function? Basically split out kojb alloc and free from
> policy alloc and free and alloc/free them around the same time
> (cpufreq_remove_Dev() will have to also call
> cpufreq_policy_put_kobj() when real_cpus is empty().
> 
> The refactor is just a suggestion. I'm looking at the latest code in
> a gitweb and making comments. So, I might have missed some corner
> cases in the refactor.
> 
> Also, it might be better to move the notifier from within
> cpufreq_policy_put_kobj() to cpufreq_policy_free()? Seems more
> appropriate.

Thanks for spotting a real bug here, I have another solution for this
though. Lemme resend that and you review it up.

-- 
viresh
