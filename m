From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get()
 method
Date: Fri, 21 Mar 2014 11:55:23 +0530
Message-ID: <20140321062523.GD27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:42928 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaCUGZ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 02:25:29 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 00:25:28 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DBA9438C803D
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 02:25:26 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2L6PQFr4325634
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 06:25:26 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2L6PQm3018045
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 02:25:26 -0400
Content-Disposition: inline
In-Reply-To: <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pm@vger.kernel.org, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, Preeti U Murthy <preeti@linux.vnet.ibm.com>

On Thu, Mar 20, 2014 at 05:41:00PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The current frequency of a cpu is reported through the sysfs file
> cpuinfo_cur_freq. This requires the driver to implement a
> "->get(unsigned int cpu)" method which will return the current
> operating frequency.
> 
> Implement a function named powernv_cpufreq_get() which reads the local
> pstate from the PMSR and returns the corresponding frequency.
> 
> Set the powernv_cpufreq_driver.get hook to powernv_cpufreq_get().

Forgot to add 

  Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 46bee8a..ef6ed8c 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -206,6 +206,43 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
>  	BUG();
>  }
> 
> +/*
> + * Computes the current frequency on this cpu
> + * and stores the result in *ret_freq.
> + */
> +static void powernv_read_cpu_freq(void *ret_freq)
> +{
> +	unsigned long pmspr_val;
> +	s8 local_pstate_id;
> +	int *cur_freq, freq, pstate_id;
> +
> +	cur_freq = (int *)ret_freq;
> +	pmspr_val = get_pmspr(SPRN_PMSR);
> +
> +	/* The local pstate id corresponds bits 48..55 in the PMSR.
> +         * Note: Watch out for the sign! */
> +	local_pstate_id = (pmspr_val >> 48) & 0xFF;
> +	pstate_id = local_pstate_id;
> +
> +	freq = pstate_id_to_freq(pstate_id);
> +	pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d \n",
> +		smp_processor_id(), pmspr_val, pstate_id, freq);
> +	*cur_freq = freq;
> +}
> +
> +/*
> + * Returns the cpu frequency as reported by the firmware for 'cpu'.
> + * This value is reported through the sysfs file cpuinfo_cur_freq.
> + */
> +unsigned int powernv_cpufreq_get(unsigned int cpu)
> +{
> +	int ret_freq;
> +
> +	smp_call_function_any(cpu_sibling_mask(cpu), powernv_read_cpu_freq,
> +			&ret_freq, 1);
> +	return ret_freq;
> +}
> +
>  static void set_pstate(void *pstate)
>  {
>  	unsigned long val;
> @@ -297,6 +334,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  static struct cpufreq_driver powernv_cpufreq_driver = {
>  	.verify		= powernv_cpufreq_verify,
>  	.target		= powernv_cpufreq_target,
> +	.get		= powernv_cpufreq_get,
>  	.init		= powernv_cpufreq_cpu_init,
>  	.exit		= powernv_cpufreq_cpu_exit,
>  	.name		= "powernv-cpufreq",
> -- 
> 1.8.3.1
> 

