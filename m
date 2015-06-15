From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/12] cpufreq: governor: Avoid invalid states with additional
 checks
Date: Mon, 15 Jun 2015 14:29:17 +0530
Message-ID: <557E93E5.3030604@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <280186b68a8b906365316876a7b6d9eafb28296b.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:54973 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbbFOI70 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 04:59:26 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 02:59:26 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7732F6E803F
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:51:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F8xN0F63504578
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 08:59:23 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F8xLQ5011242
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:59:23 -0400
In-Reply-To: <280186b68a8b906365316876a7b6d9eafb28296b.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> There can be races where the request has come to a wrong state. For
> example INIT followed by STOP (instead of START) or START followed by
> EXIT (instead of STOP).
> 
> Also make sure, once we have started canceling queued works, we don't
> queue any new works. That can lead to the case where the work-handler
> finds many data structures are freed and so NULL pointer exceptions.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 56 ++++++++++++++++++++++++++++++--------
>  drivers/cpufreq/cpufreq_governor.h |  1 +
>  2 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index aa24aa9a9eb3..ee2e19a1218a 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -169,8 +169,12 @@ static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
>  void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  		unsigned int delay, bool all_cpus)
>  {
> +	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
>  	int i;
> 
> +	if (!cdbs->ccdbs->enabled)
> +		return;

policy->governor_enabled is already doing this job. Why this additional
check ?

> +
>  	mutex_lock(&cpufreq_governor_lock);
>  	if (!policy->governor_enabled)
>  		goto out_unlock;
> @@ -234,6 +238,8 @@ static void dbs_timer(struct work_struct *work)
>  	bool modify_all = true;
> 
>  	mutex_lock(&dbs_data->cdata->mutex);
> +	if (!cdbs->ccdbs->enabled)
> +		goto unlock;

This should not trigger at all if we get the entries into
cpufreq_governor_dbs() fixed. I don't like the idea of adding
checks/locks in places where it can be avoided.

> 
>  	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
>  		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
> @@ -251,6 +257,7 @@ static void dbs_timer(struct work_struct *work)
>  	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
>  	gov_queue_work(dbs_data, policy, delay, modify_all);
> 
> +unlock:
>  	mutex_unlock(&dbs_data->cdata->mutex);
>  }
> 
> @@ -376,10 +383,15 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
>  	return ret;
>  }
> 
> -static void cpufreq_governor_exit(struct cpufreq_policy *policy,
> -				  struct dbs_data *dbs_data)
> +static int cpufreq_governor_exit(struct cpufreq_policy *policy,
> +				 struct dbs_data *dbs_data)
>  {
>  	struct common_dbs_data *cdata = dbs_data->cdata;
> +	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
> +
> +	/* STOP should have been called by now */

This is not true, atleast in the races that I have seen. The problem is
not about STOP not being called before an EXIT. It is about a START
being called after a STOP and before an EXIT. The comment should ideally
be "The policy is active, stop it before exit" or similar.

> +	if (cdbs->ccdbs->enabled)
> +		return -EBUSY;

And.. in such a scenario, we must not be aborting EXIT; rather it must
cancel the queued work and successfully exit the policy. An EXIT is a
more urgent operation than START, given its call sites. Also an EXIT
will not leave the cpufreq governors in a limbo state, it is bound to
restart a new policy or quit a policy if the last cpu goes down. A
racing START operation however is typically from a call site referencing
an older policy. Its better to abort this than the EXIT operation.

It may mean a user is trying to switch governors, and the exit operation
is quitting the old governor as a result. A START from a
cpufreq_remove_dev_finish() racing in just before this is no reason to
prevent switching governors.

> 
>  	policy->governor_data = NULL;
>  	if (!--dbs_data->usage_count) {
> @@ -395,6 +407,8 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
>  		free_ccdbs(policy, cdata);
>  		kfree(dbs_data);
>  	}
> +
> +	return 0;
>  }
> 
>  static int cpufreq_governor_start(struct cpufreq_policy *policy,
> @@ -409,6 +423,10 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  	if (!policy->cur)
>  		return -EINVAL;
> 
> +	/* START shouldn't be already called */
> +	if (ccdbs->enabled)
> +		return -EBUSY;

Why not reuse policy->governor_enabled in each of these places ?

Regards
Preeti U Murthy

