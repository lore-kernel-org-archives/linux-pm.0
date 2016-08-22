From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 01/11] sched, cpuset: Add regenerate_sched_domains
 function to rebuild all sched domains
Date: Mon, 22 Aug 2016 14:52:48 +0100
Message-ID: <20160822135247.GD25262@e105550-lin.cambridge.arm.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471559812-19967-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 18, 2016 at 03:36:42PM -0700, Srinivas Pandruvada wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> The current rebuild_sched_domains will only rebuild the sched domains
> unless the cpumask changes.  However, in some scenarios when the
> topology flag value changes, it will not rebuild the sched domain.
> 
> We create a regenerate_sched_domains function that will always
> rebuild all the sched domains to take care of this scenario.

[...]

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7081,7 +7082,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  	unregister_sched_domain_sysctl();
>  
>  	/* Let architecture update cpu core mappings. */
> -	new_topology = arch_update_cpu_topology();
> +	new_topology = arch_update_cpu_topology() | need_domain_rebuild;

You can force rebuild_sched_domains() to rebuild the sched_domain
hierarchy by just implementing arch_update_cpu_topology(). Make it
return 1 when you want the hierarchy to be updated.

Implementing another forcing mechanism seems redundant. I must be
missing something?

I just did exactly that to set the SD_ASYM_CPUCAPACITY flag for
big.LITTLE platforms on arm/arm64 as we don't know if the flag should be
set until cpufreq has initialized.

Morten
