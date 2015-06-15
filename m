From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/12] cpufreq: propagate errors returned from __cpufreq_governor()
Date: Mon, 15 Jun 2015 16:00:15 +0530
Message-ID: <557EA937.60202@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <1e4cea25fc1bf43924a39944ca9d1ec0782621e8.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:33543 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbbFOKa0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 06:30:26 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 06:30:26 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 41AA338C8052
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 06:30:23 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5FAUN2S61276248
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 10:30:23 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5FAULtb029428
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 06:30:22 -0400
In-Reply-To: <1e4cea25fc1bf43924a39944ca9d1ec0782621e8.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> At few places in cpufreq_set_policy() either we aren't checking return errors of
> __cpufreq_governor() or aren't returning them as is to the callers. This
> sometimes propagates wrong errors to sysfs OR we try to do more operations even
> if we have failed.
> 
> Now that we return -EBUSY from __cpufreq_governor() on invalid requests, there
> are more chances of hitting these errors. Lets fix them by checking and
> returning errors properly.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b612411655f9..da672b910760 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2284,16 +2284,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	old_gov = policy->governor;
>  	/* end old governor */
>  	if (old_gov) {
> -		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
> -		up_write(&policy->rwsem);
> -		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
> -		down_write(&policy->rwsem);
> +		if(!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP))) {
> +			up_write(&policy->rwsem);
> +			ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);

>From my comments in the previous patches, EXIT should always succeed. In
that case we only need to take care of STOP. So we can perhaps do a

ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP)
if (!ret)
  ..
  .. ?

It looks better this way.

> +			down_write(&policy->rwsem);
> +		}
> +
> +		if (ret)

How about a pr_debug("Failed to stop old governor %s",
policy->gov->name)  here ?

> +			return ret;
>  	}
> 
>  	/* start new governor */
>  	policy->governor = new_policy->governor;
> -	if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT)) {
> -		if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
> +	if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))) {
> +		if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)))

Do we really need to capture the return values here ? If there are
errors we fall down to return EINVAL. Will this not be a valid error
condition?

>  			goto out;
> 
>  		up_write(&policy->rwsem);
> @@ -2305,11 +2309,11 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	pr_debug("starting governor %s failed\n", policy->governor->name);
>  	if (old_gov) {
>  		policy->governor = old_gov;
> -		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
> -		__cpufreq_governor(policy, CPUFREQ_GOV_START);
> +		if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
> +			__cpufreq_governor(policy, CPUFREQ_GOV_START);

I would suggest printing a debug message if INIT fails and calling
__cpufreq_governor(POLICY_EXIT) if START fails. And EXIT is not supposed
to fail. This will leave the cpufreq governor in a sane state.
>  	}
> 
> -	return -EINVAL;
> +	return ret;
> 
>   out:
>  	pr_debug("governor: change or update limits\n");
> 

Regards
Preeti U Murthy

