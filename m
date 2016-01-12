From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 05/19] cpufreq: assert locking when accessing
 cpufreq_policy_list
Date: Tue, 12 Jan 2016 15:04:52 +0530
Message-ID: <20160112093452.GW1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-6-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33607 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934521AbcALJe4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 04:34:56 -0500
Received: by mail-pa0-f41.google.com with SMTP id cy9so337079895pac.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 01:34:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452533760-13787-6-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 11-01-16, 17:35, Juri Lelli wrote:
> cpufreq_policy_list is guarded by cpufreq_driver_lock. Add appropriate
> locking assertions to check that we always access the list while holding
> the associated lock.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 00a00cd..63d6efb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -65,6 +65,7 @@ static bool suitable_policy(struct cpufreq_policy *policy, bool active)
>  static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
>  					  bool active)
>  {
> +	lockdep_assert_held(&cpufreq_driver_lock);
>  	do {
>  		policy = list_next_entry(policy, policy_list);
>  
> @@ -80,6 +81,7 @@ static struct cpufreq_policy *first_policy(bool active)
>  {
>  	struct cpufreq_policy *policy;
>  
> +	lockdep_assert_held(&cpufreq_driver_lock);

Because both first_policy() and next_policy() are parts of
for_each_suitable_policy() macro, checking this in first_policy() is
sufficient. next_policy() isn't designed to be used by any other code.

>  	/* No policies in the list */
>  	if (list_empty(&cpufreq_policy_list))
>  		return NULL;
> @@ -2430,6 +2432,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  	if (ret)
>  		goto err_boost_unreg;
>  
> +	lockdep_assert_held(&cpufreq_driver_lock);

Why do you need a cpufreq_driver_lock here? And the above change
should generate a lockdep here as the lock isn't taken right now.

>  	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
>  	    list_empty(&cpufreq_policy_list)) {
>  		/* if all ->init() calls failed, unregister */
> -- 
> 2.2.2

-- 
viresh
