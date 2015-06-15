From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/12] cpufreq: governor: Don't WARN on invalid states
Date: Mon, 15 Jun 2015 15:22:44 +0530
Message-ID: <557EA06C.6030207@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <70b94233535af5a1fa391f3199ef8915b40fb7b7.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:59407 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbbFOJwy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 05:52:54 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 05:52:53 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 32B8D6E803F
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 05:44:37 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F9qoox57213148
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 09:52:50 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F9qmu4007433
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 05:52:50 -0400
In-Reply-To: <70b94233535af5a1fa391f3199ef8915b40fb7b7.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> The last commit returned errors on invalid state requests for a
> governor. But we are already issuing a WARN for an invalid state in
> cpufreq_governor_dbs().
> 
> Lets stop warning on that until the time cpufreq core is fixed to
> serialize state changes of the governor.

The way I see it is that if this patch series manages to capture invalid
states right, we don't need to necessarily serialize state changes in
the cpufreq core to get rid of the race conditions. So getting a START
after an EXIT will not be fatal(WARN_ON() will trigger then), if it is
identified as an invalid operation at that point and prevented.

So yes, we must get rid of the WARN_ON() not because we want to
reintroduce it later when all races are fixed but because the condition
that it is warning on can happen even if we get this fixed right making
it essentially a false positive.

And its ok to get rid of the WARN_ON() now rather than waiting till all
races are fixed, because anyway we are bound to crash the moment we hit
the warning today and we will know anyway that things went out of hand :P
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index ee2e19a1218a..c26f535d3d91 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -542,7 +542,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>  	else
>  		dbs_data = cdata->gdbs_data;
> 
> -	if (WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))) {
> +	if (!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT)) {
>  		ret = -EINVAL;
>  		goto unlock;
>  	}
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

