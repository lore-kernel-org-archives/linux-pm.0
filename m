From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/5] powernv,cpufreq:Add per-core locking to serialize
 frequency transitions
Date: Fri, 21 Mar 2014 11:54:10 +0530
Message-ID: <20140321062410.GB27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:44127 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaCUGYS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Mar 2014 02:24:18 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 02:24:17 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 42F2E6E803F
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 02:24:09 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2L6OFC07471430
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 06:24:15 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2L6OEoV003946
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 02:24:14 -0400
Content-Disposition: inline
In-Reply-To: <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pm@vger.kernel.org, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>

On Thu, Mar 20, 2014 at 05:40:57PM +0530, Gautham R. Shenoy wrote:
> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> 
> On POWER systems, the CPU frequency is controlled at a core-level and
> hence we need to serialize so that only one of the threads in the core
> switches the core's frequency at a time.
> 
> Using a global mutex lock would needlessly serialize _all_ frequency
> transitions in the system (across all cores). So introduce per-core
> locking to enable finer-grained synchronization and thereby enhance
> the speed and responsiveness of the cpufreq driver to varying workload
> demands.
> 
> The design of per-core locking is very simple and straight-forward: we
> first define a Per-CPU lock and use the ones that belongs to the first
> thread sibling of the core.
> 
> cpu_first_thread_sibling() macro is used to find the *common* lock for
> all thread siblings belonging to a core.
> 

Forgot to add the following line.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index ab1551f..66dae0d 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -24,8 +24,15 @@
>  #include <linux/of.h>
>  #include <asm/cputhreads.h>
> 
> -/* FIXME: Make this per-core */
> -static DEFINE_MUTEX(freq_switch_mutex);
> +/* Per-Core locking for frequency transitions */
> +static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
> +
> +#define lock_core_freq(cpu)				\
> +			mutex_lock(&per_cpu(freq_switch_lock,\
> +				cpu_first_thread_sibling(cpu)));
> +#define unlock_core_freq(cpu)				\
> +			mutex_unlock(&per_cpu(freq_switch_lock,\
> +				cpu_first_thread_sibling(cpu)));
> 
>  #define POWERNV_MAX_PSTATES	256
> 
> @@ -221,7 +228,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  	freqs.new = powernv_freqs[new_index].frequency;
>  	freqs.cpu = policy->cpu;
> 
> -	mutex_lock(&freq_switch_mutex);
> +	lock_core_freq(policy->cpu);
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> 
>  	pr_debug("setting frequency for cpu %d to %d kHz index %d pstate %d",
> @@ -233,7 +240,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  	rc = powernv_set_freq(policy->cpus, new_index);
> 
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> -	mutex_unlock(&freq_switch_mutex);
> +	unlock_core_freq(policy->cpu);
> 
>  	return rc;
>  }
> @@ -250,7 +257,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
> 
>  static int __init powernv_cpufreq_init(void)
>  {
> -	int rc = 0;
> +	int cpu, rc = 0;
> 
>  	/* Discover pstates from device tree and init */
> 
> @@ -260,6 +267,10 @@ static int __init powernv_cpufreq_init(void)
>  		pr_info("powernv-cpufreq disabled\n");
>  		return rc;
>  	}
> +	/* Init per-core mutex */
> +	for_each_possible_cpu(cpu) {
> +		mutex_init(&per_cpu(freq_switch_lock, cpu));
> +	}
> 
>  	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
>  	return rc;
> -- 
> 1.8.3.1
> 

