From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/8] sched, x86: Add SD_ASYM_PACKING flags to x86 cpu
 topology for ITMT
Date: Sat, 10 Sep 2016 15:10:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609101505290.2804@nanos>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1473373615-51427-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51148 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbcIJNNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2016 09:13:14 -0400
In-Reply-To: <1473373615-51427-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com

On Thu, 8 Sep 2016, Srinivas Pandruvada wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> We uses ASYM_PACKING feature in the scheduler to move tasks to more
> capable cpus that can be boosted to higher frequency. This is enabled by
> Intel Turbo Boost Max Technology 3.0 (ITMT).  We mark the sched domain
> topology level with SD_ASYM_PACKING flag for such systems to indicate
> scheduler can use the ASYM_PACKING feature to move load to the
> more capable cpus.

Sigh. This changelog does not tell anything about the nature of the patch,
the rationale for it etc. It's just a meaningless blurb.


> +unsigned int __read_mostly sysctl_sched_itmt_enabled;
> +
>  static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
>  {
>  	unsigned long flags;
> @@ -471,31 +473,57 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>  	return false;
>  }
>  
> -static struct sched_domain_topology_level numa_inside_package_topology[] = {
> +#ifdef CONFIG_SCHED_ITMT
> +static int x86_core_flags(void)
> +{
> +	int flags = cpu_core_flags();
> +
> +	if (sysctl_sched_itmt_enabled)
> +		flags |= SD_ASYM_PACKING;
> +
> +	return flags;
> +}
> +
> +static int x86_smt_flags(void)
> +{
> +	int flags = cpu_smt_flags();
> +
> +	if (sysctl_sched_itmt_enabled)
> +		flags |= SD_ASYM_PACKING;
> +
> +	return flags;
> +}
> +#else
> +#define x86_core_flags cpu_core_flags
> +#define x86_smt_flags cpu_smt_flags
> +#endif

No. We first rework the code so that the IMT stuff can be added in a later
patch easily.

Thanks,

	tglx




