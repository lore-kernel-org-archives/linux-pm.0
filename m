From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] cpufreq: governor: register notifier from cs_init()
Date: Thu, 04 Jun 2015 11:08:18 +0530
Message-ID: <556FE44A.8080806@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <7c79b6ede0407a940da2076f562360990ef0061a.1433326032.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:56759 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbFDFih (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 01:38:37 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 01:38:37 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9F55238C803B
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 01:38:34 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t545cYkL46792818
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 05:38:34 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t545cWps019704
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 01:38:34 -0400
In-Reply-To: <7c79b6ede0407a940da2076f562360990ef0061a.1433326032.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/03/2015 03:57 PM, Viresh Kumar wrote:
> Notifiers are required only for conservative governor and the common
> governor code is unnecessarily polluted with that. Handle that from
> cs_init/exit() instead of cpufreq_governor_dbs().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 26 +++++++++++++++-----------
>  drivers/cpufreq/cpufreq_governor.c     | 22 +++-------------------
>  drivers/cpufreq/cpufreq_governor.h     |  8 ++------
>  drivers/cpufreq/cpufreq_ondemand.c     |  4 ++--
>  4 files changed, 22 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 25a70d06c5bf..75f875bb155e 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -148,6 +148,10 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  	return 0;
>  }
> 
> +static struct notifier_block cs_cpufreq_notifier_block = {
> +	.notifier_call = dbs_cpufreq_notifier,
> +};
> +
>  /************************** sysfs interface ************************/
>  static struct common_dbs_data cs_dbs_cdata;
> 
> @@ -317,7 +321,7 @@ static struct attribute_group cs_attr_group_gov_pol = {
> 
>  /************************** sysfs end ************************/
> 
> -static int cs_init(struct dbs_data *dbs_data)
> +static int cs_init(struct dbs_data *dbs_data, bool notify)
>  {
>  	struct cs_dbs_tuners *tuners;
> 
> @@ -336,25 +340,26 @@ static int cs_init(struct dbs_data *dbs_data)
>  	dbs_data->tuners = tuners;
>  	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
>  		jiffies_to_usecs(10);
> +
> +	if (notify)
> +		cpufreq_register_notifier(&cs_cpufreq_notifier_block,
> +					  CPUFREQ_TRANSITION_NOTIFIER);
> +
>  	mutex_init(&dbs_data->mutex);
>  	return 0;
>  }
> 
> -static void cs_exit(struct dbs_data *dbs_data)
> +static void cs_exit(struct dbs_data *dbs_data, bool notify)
>  {
> +	if (notify)
> +		cpufreq_unregister_notifier(&cs_cpufreq_notifier_block,
> +					    CPUFREQ_TRANSITION_NOTIFIER);
> +
>  	kfree(dbs_data->tuners);
>  }
> 
>  define_get_cpu_dbs_routines(cs_cpu_dbs_info);
> 
> -static struct notifier_block cs_cpufreq_notifier_block = {
> -	.notifier_call = dbs_cpufreq_notifier,
> -};
> -
> -static struct cs_ops cs_ops = {
> -	.notifier_block = &cs_cpufreq_notifier_block,
> -};
> -
>  static struct common_dbs_data cs_dbs_cdata = {
>  	.governor = GOV_CONSERVATIVE,
>  	.attr_group_gov_sys = &cs_attr_group_gov_sys,
> @@ -363,7 +368,6 @@ static struct common_dbs_data cs_dbs_cdata = {
>  	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
>  	.gov_dbs_timer = cs_dbs_timer,
>  	.gov_check_cpu = cs_check_cpu,
> -	.gov_ops = &cs_ops,
>  	.init = cs_init,
>  	.exit = cs_exit,
>  };
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 1b44496b2d2b..d64a82e6481a 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -278,7 +278,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
> 
>  		dbs_data->cdata = cdata;
>  		dbs_data->usage_count = 1;
> -		rc = cdata->init(dbs_data);
> +		rc = cdata->init(dbs_data, !policy->governor->initialized);
>  		if (rc) {
>  			pr_err("%s: POLICY_INIT: init() failed\n", __func__);
>  			kfree(dbs_data);
> @@ -291,7 +291,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>  		rc = sysfs_create_group(get_governor_parent_kobj(policy),
>  				get_sysfs_attr(dbs_data));
>  		if (rc) {
> -			cdata->exit(dbs_data);
> +			cdata->exit(dbs_data, !policy->governor->initialized);
>  			kfree(dbs_data);
>  			return rc;
>  		}
> @@ -309,14 +309,6 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>  		set_sampling_rate(dbs_data, max(dbs_data->min_sampling_rate,
>  					latency * LATENCY_MULTIPLIER));
> 
> -		if ((cdata->governor == GOV_CONSERVATIVE) &&
> -				(!policy->governor->initialized)) {
> -			struct cs_ops *cs_ops = dbs_data->cdata->gov_ops;
> -
> -			cpufreq_register_notifier(cs_ops->notifier_block,
> -					CPUFREQ_TRANSITION_NOTIFIER);
> -		}
> -
>  		if (!have_governor_per_policy())
>  			cdata->gdbs_data = dbs_data;
> 
> @@ -329,15 +321,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>  			if (!have_governor_per_policy())
>  				cpufreq_put_global_kobject();
> 
> -			if ((dbs_data->cdata->governor == GOV_CONSERVATIVE) &&
> -				(policy->governor->initialized == 1)) {
> -				struct cs_ops *cs_ops = dbs_data->cdata->gov_ops;
> -
> -				cpufreq_unregister_notifier(cs_ops->notifier_block,
> -						CPUFREQ_TRANSITION_NOTIFIER);
> -			}
> -
> -			cdata->exit(dbs_data);
> +			cdata->exit(dbs_data, policy->governor->initialized == 1);
>  			kfree(dbs_data);
>  			cdata->gdbs_data = NULL;

I don't see why we need the check on policy->governor->initialized
because we call cdata->init() and cdata->exit(), *only* when the first
and last references to the governor are being made respectively
(filtered by dbs_data->usage_count), which is precisely what the
initialized flag checks. So passing policy->governor->initialized seems
to be redundant? And this is the case for both gov_per_policy and otherwise.

Regards
Preeti U Murthy

