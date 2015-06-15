From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/12] cpufreq: conservative: remove 'enable' field
Date: Mon, 15 Jun 2015 16:10:56 +0530
Message-ID: <557EABB8.5090700@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <3af78d993ca7cea8c0b1dec4c7e4714ef21e09ce.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:35567 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbbFOKlF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 06:41:05 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 06:41:04 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5B72D38C8046
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 06:41:02 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5FAf2YE61014084
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 10:41:02 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5FAf0U7028413
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 06:41:02 -0400
In-Reply-To: <3af78d993ca7cea8c0b1dec4c7e4714ef21e09ce.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Conservative governor has its own 'enable' field to check in notifier if
> notification is required or not. The same functionality can now be
> achieved with 'ccdbs->enabled instead'. Lets get rid of 'enable'.

Since this is a policy wide value, is there a race possible between
switching to a new governor and checking of this value in the notifier ?
We don't want scenarios where we have switched from conservative to
ondemand and ccdbs->enabled = 1 while a parallel notifier thread is
running and thinks the conservative governor is enabled.

Regards
Preeti U Murthy
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 12 ++++++------
>  drivers/cpufreq/cpufreq_governor.c     | 13 +------------
>  drivers/cpufreq/cpufreq_governor.h     |  1 -
>  3 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 0e4154e584bf..e0b49729307d 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -21,6 +21,7 @@
>  #define DEF_SAMPLING_DOWN_FACTOR		(1)
>  #define MAX_SAMPLING_DOWN_FACTOR		(10)
> 
> +static struct common_dbs_data cs_dbs_cdata;
>  static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
> 
>  static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
> @@ -119,13 +120,13 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_freqs *freq = data;
>  	struct cs_cpu_dbs_info_s *dbs_info =
>  					&per_cpu(cs_cpu_dbs_info, freq->cpu);
> -	struct cpufreq_policy *policy;
> +	struct cpu_common_dbs_info *ccdbs = dbs_info->cdbs.ccdbs;
> +	struct cpufreq_policy *policy = ccdbs->policy;
> 
> -	if (!dbs_info->enable)
> +	mutex_lock(&cs_dbs_cdata.mutex);
> +	if (!ccdbs->enabled)
>  		return 0;
> 
> -	policy = dbs_info->cdbs.ccdbs->policy;
> -
>  	/*
>  	 * we only care if our internally tracked freq moves outside the 'valid'
>  	 * ranges of frequency available to us otherwise we do not change it
> @@ -133,6 +134,7 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  	if (dbs_info->requested_freq > policy->max
>  			|| dbs_info->requested_freq < policy->min)
>  		dbs_info->requested_freq = freq->new;
> +	mutex_unlock(&cs_dbs_cdata.mutex);
> 
>  	return 0;
>  }
> @@ -142,8 +144,6 @@ static struct notifier_block cs_cpufreq_notifier_block = {
>  };
> 
>  /************************** sysfs interface ************************/
> -static struct common_dbs_data cs_dbs_cdata;
> -
>  static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
>  		const char *buf, size_t count)
>  {
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index c26f535d3d91..7f348c3a4782 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -465,7 +465,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  			cdata->get_cpu_dbs_info_s(cpu);
> 
>  		cs_dbs_info->down_skip = 0;
> -		cs_dbs_info->enable = 1;
>  		cs_dbs_info->requested_freq = policy->cur;
>  	} else {
>  		struct od_ops *od_ops = cdata->gov_ops;
> @@ -485,9 +484,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  static int cpufreq_governor_stop(struct cpufreq_policy *policy,
>  				 struct dbs_data *dbs_data)
>  {
> -	struct common_dbs_data *cdata = dbs_data->cdata;
> -	unsigned int cpu = policy->cpu;
> -	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
> +	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
>  	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
> 
>  	/* Shouldn't be already stopped */
> @@ -496,14 +493,6 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
> 
>  	ccdbs->enabled = false;
>  	gov_cancel_work(dbs_data, policy);
> -
> -	if (cdata->governor == GOV_CONSERVATIVE) {
> -		struct cs_cpu_dbs_info_s *cs_dbs_info =
> -			cdata->get_cpu_dbs_info_s(cpu);
> -
> -		cs_dbs_info->enable = 0;
> -	}
> -
>  	return 0;
>  }
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 7da5aedb8174..7f651bdf43ae 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -165,7 +165,6 @@ struct cs_cpu_dbs_info_s {
>  	struct cpu_dbs_info cdbs;
>  	unsigned int down_skip;
>  	unsigned int requested_freq;
> -	unsigned int enable:1;
>  };
> 
>  /* Per policy Governors sysfs tunables */
> 

