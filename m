From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Return 0 from ->fast_switch() on errors
Date: Fri, 11 Aug 2017 01:13:10 +0200
Message-ID: <8693637.6NBGkAB8Q9@aspire.rjw.lan>
References: <a219f5b42d06a78bd254ca1b23047d45702f12d2.1502254023.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58400 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753089AbdHJXVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 19:21:30 -0400
In-Reply-To: <a219f5b42d06a78bd254ca1b23047d45702f12d2.1502254023.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sudeep.holla@arm.com, Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org

On Wednesday, August 9, 2017 6:51:46 AM CEST Viresh Kumar wrote:
> CPUFREQ_ENTRY_INVALID is a special symbol which is used to specify that
> an entry in the cpufreq table is invalid. But using it outside of the
> scope of the cpufreq table looks a bit incorrect.
> 
> We can represent an invalid frequency by writing it as 0 instead if we
> need. Note that it is already done that way for the return value of the
> ->get() callback.
> 
> Lets do the same for ->fast_switch() and not use CPUFREQ_ENTRY_INVALID
> outside of the scope of cpufreq table.
> 
> Also update the comment over cpufreq_driver_fast_switch() to clearly
> mention what this returns.
> 
> None of the drivers return CPUFREQ_ENTRY_INVALID as of now from
> ->fast_switch() callback and so we don't need to update any of those.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c        | 7 ++++---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b2cc98551fc3..9588e15da26b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1832,9 +1832,10 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>   * twice in parallel for the same policy and that it will never be called in
>   * parallel with either ->target() or ->target_index() for the same policy.
>   *
> - * If CPUFREQ_ENTRY_INVALID is returned by the driver's ->fast_switch()
> - * callback to indicate an error condition, the hardware configuration must be
> - * preserved.
> + * Returns the actual frequency set for the CPU.
> + *
> + * If 0 is returned by the driver's ->fast_switch() callback to indicate an
> + * error condition, the hardware configuration must be preserved.
>   */
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  					unsigned int target_freq)
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5465bf221e8f..2e74c49776be 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -123,7 +123,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>  
>  	if (policy->fast_switch_enabled) {
>  		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
> -		if (next_freq == CPUFREQ_ENTRY_INVALID)
> +		if (!next_freq)
>  			return;
>  
>  		policy->cur = next_freq;
> 

Applied, thanks!
