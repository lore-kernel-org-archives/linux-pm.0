From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/12] cpufreq: governor: Drop unused field 'cpu'
Date: Mon, 15 Jun 2015 08:42:12 +0530
Message-ID: <557E428C.8060101@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <df4228bfaeed49925a0aca4528852de2d1b3c44f.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:60936 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbFODMV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jun 2015 23:12:21 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Sun, 14 Jun 2015 23:12:20 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C937F38C8026
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 23:12:17 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F3CHaP58458354
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 03:12:17 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F3CGEC023542
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 23:12:17 -0400
In-Reply-To: <df4228bfaeed49925a0aca4528852de2d1b3c44f.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Its not used at all, drop it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 1 -
>  drivers/cpufreq/cpufreq_governor.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 6024bbc782c0..2149ba7d32a8 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -353,7 +353,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  		struct cpu_dbs_common_info *j_cdbs = cdata->get_cpu_cdbs(j);
>  		unsigned int prev_load;
> 
> -		j_cdbs->cpu = j;
>  		j_cdbs->cur_policy = policy;
>  		j_cdbs->prev_cpu_idle =
>  			get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 352eecaae789..1bbf8c87fdd5 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -130,7 +130,6 @@ static void *get_cpu_dbs_info_s(int cpu)				\
> 
>  /* Per cpu structures */
>  struct cpu_dbs_common_info {
> -	int cpu;
>  	u64 prev_cpu_idle;
>  	u64 prev_cpu_wall;
>  	u64 prev_cpu_nice;
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

