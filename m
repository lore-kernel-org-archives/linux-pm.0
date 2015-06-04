From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] cpufreq: governor: split cpufreq_governor_dbs()
Date: Thu, 04 Jun 2015 15:34:15 +0530
Message-ID: <5570229F.3080808@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <6880bd7b6e6e7968f008d6328ab15353d99ccd57.1433326032.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:44650 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbbFDKEc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 06:04:32 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 06:04:31 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 73D85C9003C
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 05:55:36 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t54A4Tm749741978
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 10:04:29 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t54A4RuT025718
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 06:04:28 -0400
In-Reply-To: <6880bd7b6e6e7968f008d6328ab15353d99ccd57.1433326032.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/03/2015 03:57 PM, Viresh Kumar wrote:
> cpufreq_governor_dbs() is hardly readable, it is just too big and
> complicated. Lets make it more readable by splitting out event specific
> routines.
> 
> Order of statements is changed at few places, but that shouldn't bring
> any functional change.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Best way to verify the changes here is to keep both copies of code side
> by side and comparing it event wise.
> 
>  drivers/cpufreq/cpufreq_governor.c | 326 +++++++++++++++++++++----------------
>  1 file changed, 185 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index d64a82e6481a..dc382a5a2158 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -239,195 +239,239 @@ static void set_sampling_rate(struct dbs_data *dbs_data,
>  	}
>  }
> 
> -int cpufreq_governor_dbs(struct cpufreq_policy *policy,
> -		struct common_dbs_data *cdata, unsigned int event)
> +static int cpufreq_governor_init(struct cpufreq_policy *policy,
> +				 struct dbs_data *dbs_data,
> +				 struct common_dbs_data *cdata)
>  {
> -	struct dbs_data *dbs_data;
> -	struct od_cpu_dbs_info_s *od_dbs_info = NULL;
> -	struct cs_cpu_dbs_info_s *cs_dbs_info = NULL;
> -	struct od_ops *od_ops = NULL;
> -	struct od_dbs_tuners *od_tuners = NULL;
> -	struct cs_dbs_tuners *cs_tuners = NULL;
> -	struct cpu_dbs_common_info *cpu_cdbs;
> -	unsigned int sampling_rate, latency, ignore_nice, j, cpu = policy->cpu;
> -	int io_busy = 0;
> -	int rc;
> +	unsigned int latency;
> +	int ret;
> 
> -	if (have_governor_per_policy())
> -		dbs_data = policy->governor_data;
> -	else
> -		dbs_data = cdata->gdbs_data;
> +	if (dbs_data) {
> +		WARN_ON(have_governor_per_policy());

Shouldn't this be outside this loop ? We warn here and allocate dbs_dta
freshly in the current code for the case where governor is per policy.

> +		dbs_data->usage_count++;

Besides, in the case where a governor exists per policy, we will end up
incrementing the usage_count to more than 1 under this condition, which
does not make sense.

> +		policy->governor_data = dbs_data;
> +		return 0;
> +	}

Regards
Preeti U Murthy

