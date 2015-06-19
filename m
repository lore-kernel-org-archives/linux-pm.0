From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 10/10] cpufreq: propagate errors returned from __cpufreq_governor()
Date: Fri, 19 Jun 2015 23:32:24 +0530
Message-ID: <55845930.7020503@linux.vnet.ibm.com>
References: <cover.1434713657.git.viresh.kumar@linaro.org> <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:51860 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbbFSSC4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 14:02:56 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 19 Jun 2015 14:02:55 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D7920C9004A
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 13:53:58 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5JI2qSK62455902
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 18:02:52 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5JI2nbS028763
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 14:02:51 -0400
In-Reply-To: <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/19/2015 05:18 PM, Viresh Kumar wrote:
> Return codes aren't honored properly in cpufreq_set_policy(). This can
> lead to two problems:
> - wrong errors propagated to sysfs
> - we try to do next state-change even if the previous one failed
> 
> cpufreq_governor_dbs() now returns proper errors on all invalid
> state-transition requests and this code should honor that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Minor points below.

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
> +			down_write(&policy->rwsem);
> +		}
> +
> +		if (ret)
> +			return ret;

Some debug prints help here? Like "Failed to stop govenor".
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
> @@ -2305,11 +2309,11 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	pr_debug("starting governor %s failed\n", policy->governor->name);
>  	if (old_gov) {
>  		policy->governor = old_gov;
> -		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
> -		__cpufreq_governor(policy, CPUFREQ_GOV_START);
> +		if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
> +			__cpufreq_governor(policy, CPUFREQ_GOV_START);

If INIT itself fails, we need to set policy->governor to NULL. I
included this in the testing of the patchset.

Regards
Preeti U Murthy

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
