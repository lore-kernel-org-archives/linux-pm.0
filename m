From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/10] cpufreq: conservative: Avoid races with transition
 notifier
Date: Tue, 23 Jun 2015 21:23:41 +0530
Message-ID: <55898105.2050907@linux.vnet.ibm.com>
References: <cover.1434959517.git.viresh.kumar@linaro.org> <41ef05ed3b93677b4519e4c6c758753a7e63d432.1434959517.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:46169 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbbFWPxu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 11:53:50 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Tue, 23 Jun 2015 11:53:50 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 28A0F38C807E
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 11:53:46 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5NFrjJG62062678
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 15:53:45 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5NFrj4c014840
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 11:53:45 -0400
In-Reply-To: <41ef05ed3b93677b4519e4c6c758753a7e63d432.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> It is possible that cpufreq transition notifier is called while the
> governor is performing its EXIT operation. If this happens, 'ccdbs'

When does this happen ? As far as I can see, cpufreq transition notifier
gets called from the cpufreq kworker or when we set the cpufreq limits.
And from your previous patches, an exit operation only proceeds after
ensuring that no kworker is running (check on ccdbs->policy). And LIMIT
operation does not run in parallel too.

Regards
Preeti U Murthy

> may get updated to NULL, while it is being accessed from the notifier
> callback. And that will result in NULL pointer dereference.
> 
> ccdbs is used here just to get cpufreq policy, which can be obtained
> from cpufreq_cpu_get() as well. And so the reference to ccdbs can be
> avoided.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 0e4154e584bf..1e3cabfb2b57 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -119,12 +119,13 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_freqs *freq = data;
>  	struct cs_cpu_dbs_info_s *dbs_info =
>  					&per_cpu(cs_cpu_dbs_info, freq->cpu);
> -	struct cpufreq_policy *policy;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
> 
> -	if (!dbs_info->enable)
> +	if (!policy)
>  		return 0;
> 
> -	policy = dbs_info->cdbs.ccdbs->policy;
> +	if (!dbs_info->enable)
> +		goto policy_put;
> 
>  	/*
>  	 * we only care if our internally tracked freq moves outside the 'valid'
> @@ -134,6 +135,9 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  			|| dbs_info->requested_freq < policy->min)
>  		dbs_info->requested_freq = freq->new;
> 
> +policy_put:
> +	cpufreq_cpu_put(policy);
> +
>  	return 0;
>  }
> 

