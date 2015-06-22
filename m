From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 10/10] cpufreq: propagate errors returned from __cpufreq_governor()
Date: Mon, 22 Jun 2015 10:11:56 +0530
Message-ID: <55879214.2070809@linux.vnet.ibm.com>
References: <cover.1434713657.git.viresh.kumar@linaro.org> <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org> <55845930.7020503@linux.vnet.ibm.com> <20150620031207.GE1955@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:34212 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbbFVEmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 00:42:05 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 22 Jun 2015 00:42:04 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D0E4238C8041
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 00:42:02 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5M4g28458654770
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 04:42:02 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5M4g0Mk012312
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 00:42:02 -0400
In-Reply-To: <20150620031207.GE1955@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/20/2015 08:42 AM, Viresh Kumar wrote:
> On 19-06-15, 23:32, Preeti U Murthy wrote:
>> If INIT itself fails, we need to set policy->governor to NULL. I
>> included this in the testing of the patchset.
> 
> Diff from earlier patch:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index da672b910760..59fa0c1b7922 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2284,14 +2284,23 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	old_gov = policy->governor;
>  	/* end old governor */
>  	if (old_gov) {
> -		if(!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP))) {
> +		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
> +		if (ret) {
> +			/* This can happen due to race with other operations */
> +			pr_debug("%s: Failed to Stop Governor: %s (%d)\n",
> +				 __func__, old_gov->name, ret);
> +			return ret;
> +		} else {
>  			up_write(&policy->rwsem);
>  			ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
>  			down_write(&policy->rwsem);
> -		}
> 
> -		if (ret)
> -			return ret;
> +			if (ret) {
> +				pr_err("%s: Failed to Exit Governor: %s (%d)\n",
> +				       __func__, old_gov->name, ret);
> +				return ret;
> +			}
> +		}
>  	}
> 
>  	/* start new governor */
> @@ -2309,7 +2318,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	pr_debug("starting governor %s failed\n", policy->governor->name);
>  	if (old_gov) {
>  		policy->governor = old_gov;
> -		if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
> +		if (__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
> +			policy->governor = NULL;
> +		else
>  			__cpufreq_governor(policy, CPUFREQ_GOV_START);
>  	}
> 
> 
> New-patch:
> 
> --------------8<-------------------
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Thu, 11 Sep 2014 10:50:48 +0530
> Subject: [PATCH] cpufreq: propagate errors returned from __cpufreq_governor()
> 
> Return codes aren't honored properly in cpufreq_set_policy(). This can
> lead to two problems:
> - wrong errors propagated to sysfs
> - we try to do next state-change even if the previous one failed
> 
> cpufreq_governor_dbs() now returns proper errors on all invalid
> state-transition requests and this code should honor that.
> 
> Reviewed-and-Tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b612411655f9..59fa0c1b7922 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2284,16 +2284,29 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	old_gov = policy->governor;
>  	/* end old governor */
>  	if (old_gov) {
> -		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
> -		up_write(&policy->rwsem);
> -		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
> -		down_write(&policy->rwsem);
> +		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
> +		if (ret) {
> +			/* This can happen due to race with other operations */
> +			pr_debug("%s: Failed to Stop Governor: %s (%d)\n",
> +				 __func__, old_gov->name, ret);
> +			return ret;
> +		} else {
> +			up_write(&policy->rwsem);
> +			ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
> +			down_write(&policy->rwsem);
> +
> +			if (ret) {
> +				pr_err("%s: Failed to Exit Governor: %s (%d)\n",
> +				       __func__, old_gov->name, ret);
> +				return ret;
> +			}
> +		}
>  	}
> 
>  	/* start new governor */
>  	policy->governor = new_policy->governor;
> -	if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT)) {
> -		if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
> +	if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))) {
> +		if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)))
>  			goto out;
> 
>  		up_write(&policy->rwsem);
> @@ -2305,11 +2318,13 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	pr_debug("starting governor %s failed\n", policy->governor->name);
>  	if (old_gov) {
>  		policy->governor = old_gov;
> -		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
> -		__cpufreq_governor(policy, CPUFREQ_GOV_START);
> +		if (__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
> +			policy->governor = NULL;
> +		else
> +			__cpufreq_governor(policy, CPUFREQ_GOV_START);
>  	}
> 
> -	return -EINVAL;
> +	return ret;
> 
>   out:
>  	pr_debug("governor: change or update limits\n");
> 

There are some checkpatch errors on this patch.

Regards
Preeti U Murthy

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
