From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 6/7] arm64: topology: Enable ACPI/PPTT based CPU
 topology.
Date: Thu, 19 Oct 2017 16:56:22 +0100
Message-ID: <20171019155622.GC18883@red-moon>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-7-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171012194856.13844-7-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 12, 2017 at 02:48:55PM -0500, Jeremy Linton wrote:
> Propagate the topology information from the PPTT tree to the
> cpu_topology array. We can get the thread id, core_id and
> cluster_id by assuming certain levels of the PPTT tree correspond
> to those concepts. The package_id is flagged in the tree and can be
> found by passing an arbitrary large level to setup_acpi_cpu_topology()
> which terminates its search when it finds an ACPI node flagged
> as the physical package. If the tree doesn't contain enough
> levels to represent all of thread/core/cod/package then the package
> id will be used for the missing levels.
> 
> Since server/ACPI machines are more likely to be multisocket and NUMA,

I think this stuff is vague enough already so to start with I would drop
patch 4 and 5 and stop assuming what machines are more likely to ship
with ACPI than DT.

I am just saying, for the umpteenth time, that these levels have no
architectural meaning _whatsoever_, level is a hierarchy concept
with no architectural meaning attached.

The only consistent thing PPTT is bringing about is the hierarchy
levels/grouping (and _possibly_ - what a package boundary is), let's
stick to that for the time being.

> this patch also modifies the default clusters=sockets behavior
> for ACPI machines to sockets=sockets. DT machines continue to
> represent sockets as clusters. For ACPI machines, this results in a
> more normalized view of the topology. Cluster level scheduler decisions
> are still being made due to the "MC" level in the scheduler which has
> knowledge of cache sharing domains.
> 
> This code is loosely based on a combination of code from:
> Xiongfeng Wang <wangxiongfeng2@huawei.com>
> John Garry <john.garry@huawei.com>
> Jeffrey Hugo <jhugo@codeaurora.org>
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 54 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/topology.h     |  1 +
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 9147e5b6326d..42f3e7f28b2b 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -11,6 +11,7 @@
>   * for more details.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/arch_topology.h>
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
> @@ -22,6 +23,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/topology.h>
>  #include <linux/slab.h>
> +#include <linux/smp.h>
>  #include <linux/string.h>
>  
>  #include <asm/cpu.h>
> @@ -304,6 +306,54 @@ static void __init reset_cpu_topology(void)
>  	}
>  }
>  
> +#ifdef CONFIG_ACPI
> +/*
> + * Propagate the topology information of the processor_topology_node tree to the
> + * cpu_topology array.
> + */
> +static int __init parse_acpi_topology(void)
> +{
> +	u64 is_threaded;
> +	int cpu;
> +	int topology_id;
> +	/* set a large depth, to hit ACPI_PPTT_PHYSICAL_PACKAGE if one exists */
> +	const int max_topo = 0xFF;
> +
> +	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
> +
> +	for_each_possible_cpu(cpu) {
> +		topology_id = setup_acpi_cpu_topology(cpu, 0);
> +		if (topology_id < 0)
> +			return topology_id;
> +
> +		if (is_threaded) {
> +			cpu_topology[cpu].thread_id = topology_id;
> +			topology_id = setup_acpi_cpu_topology(cpu, 1);

Nit: you can move setup_acpi_cpu_topology() to include/linux/acpi.h,
provide an empty inline function for the !ACPI case and remove
this function ACPI ifdeffery.

> +			cpu_topology[cpu].core_id   = topology_id;
> +			topology_id = setup_acpi_cpu_topology(cpu, 2);
> +			cpu_topology[cpu].cluster_id = topology_id;
> +			topology_id = setup_acpi_cpu_topology(cpu, max_topo);

If you want a package id (that's just a package tag to group cores), you
should not use a large level because you know how setup_acpi_cpu_topology()works, you should add an API that allows you to retrieve the package id
(so that you can use th ACPI_PPTT_PHYSICAL_PACKAGE flag consistenly,
whatever it represents).

Lorenzo

> +			cpu_topology[cpu].package_id = topology_id;
> +		} else {
> +			cpu_topology[cpu].thread_id  = -1;
> +			cpu_topology[cpu].core_id    = topology_id;
> +			topology_id = setup_acpi_cpu_topology(cpu, 1);
> +			cpu_topology[cpu].cluster_id = topology_id;
> +			topology_id = setup_acpi_cpu_topology(cpu, max_topo);
> +			cpu_topology[cpu].package_id = topology_id;
> +		}
> +	}
> +	return 0;
> +}
> +
> +#else
> +static int __init parse_acpi_topology(void)
> +{
> +	/*ACPI kernels should be built with PPTT support*/
> +	return -EINVAL;
> +}
> +#endif
> +
>  void __init init_cpu_topology(void)
>  {
>  	reset_cpu_topology();
> @@ -312,6 +362,8 @@ void __init init_cpu_topology(void)
>  	 * Discard anything that was parsed if we hit an error so we
>  	 * don't use partial information.
>  	 */
> -	if (of_have_populated_dt() && parse_dt_topology())
> +	if ((!acpi_disabled) && parse_acpi_topology())
> +		reset_cpu_topology();
> +	else if (of_have_populated_dt() && parse_dt_topology())
>  		reset_cpu_topology();
>  }
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 4660749a7303..cbf2fb13bf92 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -43,6 +43,7 @@
>  		if (nr_cpus_node(node))
>  
>  int arch_update_cpu_topology(void);
> +int setup_acpi_cpu_topology(unsigned int cpu, int level);
>  
>  /* Conform to ACPI 2.0 SLIT distance definitions */
>  #define LOCAL_DISTANCE		10
> -- 
> 2.13.5
> 
