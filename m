From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 5/8] sched,x86: Enable Turbo Boost Max Technology
Date: Sat, 10 Sep 2016 18:21:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609101546130.2804@nanos>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1473373615-51427-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1473373615-51427-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, 8 Sep 2016, Srinivas Pandruvada wrote:
> +
> +DEFINE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
> +static DEFINE_MUTEX(itmt_update_mutex);
> +
> +static unsigned int zero;
> +static unsigned int one = 1;

Please stick that close to the ctl_table so it gets obvious why we need
this. My first reaction to this was: WTF!

> +/*
> + * Boolean to control whether we want to move processes to cpu capable
> + * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
> + * Technology 3.0.
> + *
> + * It can be set via /proc/sys/kernel/sched_itmt_enabled
> + */
> +unsigned int __read_mostly sysctl_sched_itmt_enabled;

Please put the sysctl into a seperate patch and document the sysctl at the
proper place.

> +
> +/*
> + * The pstate_driver calls set_sched_itmt to indicate if the system
> + * is ITMT capable.
> + */
> +static bool __read_mostly sched_itmt_capable;
> +
> +int arch_asym_cpu_priority(int cpu)
> +{
> +	return per_cpu(sched_core_priority, cpu);
> +}
> +

The ordering or your functions is completely random and makes not sense
whatsoever.

> +/* Called with itmt_update_mutex lock held */
> +static void enable_sched_itmt(bool enable_itmt)
> +{
> +	sysctl_sched_itmt_enabled = enable_itmt;
> +	x86_topology_update = true;
> +	rebuild_sched_domains();

So you rebuild that even if the state of the sysctl did not change,

> +}
> +
> +static int sched_itmt_update_handler(struct ctl_table *table, int write,
> +			      void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +
> +	mutex_lock(&itmt_update_mutex);
> +
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	if (ret || !write) {
> +		mutex_unlock(&itmt_update_mutex);
> +		return ret;
> +	}
> +
> +	enable_sched_itmt(sysctl_sched_itmt_enabled);

So you hand in sysctl_sched_itmt_enabled so that enable_sched_itmt() can
store that value in sysctl_sched_itmt_enabled. Brilliant stuff that.

> +static struct ctl_table_header *itmt_sysctl_header;
> +
> +/*
> + * The boot code will find out the max boost frequency
> + * and call this function to set a priority proportional
> + * to the max boost frequency. CPU with higher boost
> + * frequency will receive higher priority.
> + */
> +void sched_set_itmt_core_prio(int prio, int core_cpu)
> +{
> +	int cpu, i = 1;
> +
> +	for_each_cpu(cpu, topology_sibling_cpumask(core_cpu)) {
> +		int smt_prio;
> +
> +		/*
> +		 * Discount the priority of sibling so that we don't
> +		 * pack all loads to the same core before using other cores.

-EMAKESNOSENSE

Is this a winter or summer sale where we get a discount? 10% or 50% or what?

The math here is:

      smt_prio = prio * num_siblings / sibling_idx;

The purpose of this is to ensure that the siblings are moved to the end of
the priority chain and therefor only used when all other high priority
cpus are out of capacity.

> +		 */
> +		smt_prio = prio * smp_num_siblings / i;
> +		i++;
> +		per_cpu(sched_core_priority, cpu) = smt_prio;
> +	}
> +}
> +
> +/*
> + * During boot up, boot code will detect if the system
> + * is ITMT capable and call set_sched_itmt.

Groan. In the comment above the declaration of sched_itmt_capable you
write:

> + * The pstate_driver calls set_sched_itmt to indicate if the system
> + * is ITMT capable.

So what is calling this? Boot code or pstate driver or something else?

> + *
> + * This should be called after sched_set_itmt_core_prio
> + * has been called to set the cpus' priorities.

should? So the call order is optional and this is just a recommendation.

> + *
> + * This function should be called without cpu hot plug lock
> + * as we need to acquire the lock to rebuild sched domains
> + * later.

Ditto. Must not be called with cpu hotplug lock held.

> + */
> +void set_sched_itmt(bool itmt_capable)

This function can be called more than once and it can be called to
anable and disable the feature, right?

So again: instead of incoherent comments above the function describe the
calling conventions and what the function does proper.

> +{
> +	mutex_lock(&itmt_update_mutex);
> +
> +	if (itmt_capable != sched_itmt_capable) {

If you use a goto out_unlock here, then you spare one indentation level and
the annoying line breaks.

> +
> +		if (itmt_capable) {
> +			itmt_sysctl_header =
> +				register_sysctl_table(itmt_root_table);

What if this fails? Error handling is overrated ...

> +			/*
> +			 * ITMT capability automatically enables ITMT
> +			 * scheduling for client systems (single node).

Why? Just because it can and just because something thinks that it's a good
idea? There are server systems with single node as well....

> +			 */
> +			if (topology_num_packages() == 1)
> +				sysctl_sched_itmt_enabled = 1;
> +		} else {
> +			if (itmt_sysctl_header)
> +				unregister_sysctl_table(itmt_sysctl_header);

And what clears imt_sysctl_header ?

> +			sysctl_sched_itmt_enabled = 0;
> +		}
> +
> +		sched_itmt_capable = itmt_capable;
> +		x86_topology_update = true;
> +		rebuild_sched_domains();

So another place where you call that unconditionally. If the sysctl is
disabled then this is completely pointless.

What about a single function which is called from the sysctl write and from
this code, which does the update and rebuild only if something has changed?

> +	}
> +
> +	mutex_unlock(&itmt_update_mutex);
> +}
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 737b9edf..17f3ac7 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -109,7 +109,6 @@ static bool logical_packages_frozen __read_mostly;
>  /* Maximum number of SMT threads on any online core */
>  int __max_smt_threads __read_mostly;
>  
> -unsigned int __read_mostly sysctl_sched_itmt_enabled;

So if you wouldn't have added this in the first place then you would not
have to remove it.

Thanks,

	tglx


