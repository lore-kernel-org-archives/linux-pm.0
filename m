From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: governor: Fix race in
 dbs_update_util_handler()
Date: Mon, 22 Feb 2016 10:53:36 +0530
Message-ID: <20160222052336.GB28226@vireshk-i7>
References: <2410542.x6e5Rli2VY@vostro.rjw.lan>
 <2648721.JQxjFin8bu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35625 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbcBVFXy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 00:23:54 -0500
Received: by mail-pa0-f49.google.com with SMTP id ho8so87213837pac.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2016 21:23:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2648721.JQxjFin8bu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21-02-16, 03:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a scenarion that may lead to undesired results in

             scenario

> dbs_update_util_handler().  Namely, if two CPUs sharing a policy
> enter the funtion at the same time, pass the sample delay check
> and then one of them is stalled until dbs_work_handler() (queued
> up by the other CPU) clears the work counter, it may update the
> work counter and queue up another work item prematurely.
> 
> To prevent that from happening, use the observation that the CPU
> queuing up a work item in dbs_update_util_handler() updates the
> last sample time.  This means that if another CPU was stalling after
> passing the sample delay check and now successfully updated the work
> counter as a result of the race described above, it will see the new
> value of the last sample time which is different from what it used in
> the sample delay check before.  If that happens, the sample delay
> check passed previously is not valid any more, so the CPU should not
> continue, but leaving the funtion at that point might miss an
> opportunity to take the next sample, so simply clear the work
> counter and jump to the beginning of the function in that case.
> 
> Fixes: f17cbb53783c (cpufreq: governor: Avoid atomic operations in hot paths)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -341,8 +341,9 @@ static void dbs_update_util_handler(stru
>  {
>  	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
>  	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
> -	u64 delta_ns;
> +	u64 delta_ns, lst;
>  
> + start:
>  	/*
>  	 * The work may not be allowed to be queued up right now.
>  	 * Possible reasons:
> @@ -357,7 +358,8 @@ static void dbs_update_util_handler(stru
>  	 * of sample_delay_ns used in the computation may be stale.
>  	 */
>  	smp_rmb();
> -	delta_ns = time - policy_dbs->last_sample_time;
> +	lst = ACCESS_ONCE(policy_dbs->last_sample_time);

The comment on the top of ACCESS_ONCE() asks us to use READ_ONCE() if possible.

> +	delta_ns = time - lst;
>  	if ((s64)delta_ns < policy_dbs->sample_delay_ns)
>  		return;
>  
> @@ -366,9 +368,19 @@ static void dbs_update_util_handler(stru
>  	 * at this point.  Otherwise, we need to ensure that only one of the
>  	 * CPUs sharing the policy will do that.
>  	 */
> -	if (policy_dbs->is_shared &&
> -	    !atomic_add_unless(&policy_dbs->work_count, 1, 1))
> -		return;
> +	if (policy_dbs->is_shared) {
> +		if (!atomic_add_unless(&policy_dbs->work_count, 1, 1))
> +			return;
> +
> +		/*
> +		 * If another CPU updated last_sample_time in the meantime, we
> +		 * shouldn't be here, so clear the work counter and try again.
> +		 */
> +		if (unlikely(lst != ACCESS_ONCE(policy_dbs->last_sample_time))) {
> +			atomic_set(&policy_dbs->work_count, 0);
> +			goto start;
> +		}

I think we should be doing this here:

	delta_ns = time - ACCESS_ONCE(policy_dbs->last_sample_time);
 	if ((s64)delta_ns < policy_dbs->sample_delay_ns) {
                atomic_set(&policy_dbs->work_count, 0);
 		return;
        }

There is no point running the routine again, we already have ->work_count
incremented for us, lets do the check right now.

Over that, in theory, with your code, it is possible that one of the CPU can get
stuck in the goto->start loop indefinitely :)

> +	}
>  
>  	policy_dbs->last_sample_time = time;
>  	policy_dbs->work_in_progress = true;

-- 
viresh
