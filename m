From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 8/9] arm64: topology: Enable ACPI/PPTT based CPU
 topology.
Date: Wed, 13 Dec 2017 18:22:19 +0000
Message-ID: <20171213182219.GC4060@red-moon>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-9-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753811AbdLMSVk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 13:21:40 -0500
Content-Disposition: inline
In-Reply-To: <20171201222330.18863-9-jeremy.linton@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org

Nit: remove the period in $SUBJECT and capitalize with a coherent
policy for the patches touching the same code.

On Fri, Dec 01, 2017 at 04:23:29PM -0600, Jeremy Linton wrote:
> Propagate the topology information from the PPTT tree to the
> cpu_topology array. We can get the thread id, core_id and
> cluster_id by assuming certain levels of the PPTT tree correspond
> to those concepts. The package_id is flagged in the tree and can be
> found by calling find_acpi_cpu_topology_package() which terminates
> its search when it finds an ACPI node flagged as the physical
> package. If the tree doesn't contain enough levels to represent
> all of the requested levels then the root node will be returned
> for all subsequent levels.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/topology.h     |  2 ++
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 74a8a5173a35..198714aca9e8 100644
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
> @@ -300,6 +302,47 @@ static void __init reset_cpu_topology(void)
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

Nit: a bool would be preferable.

> +	int cpu;
> +	int topology_id;

int cpu, topology_id;

> +	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;

> +	for_each_possible_cpu(cpu) {
> +		topology_id = find_acpi_cpu_topology(cpu, 0);
> +		if (topology_id < 0)
> +			return topology_id;
> +
> +		if (is_threaded) {
> +			cpu_topology[cpu].thread_id = topology_id;
> +			topology_id = find_acpi_cpu_topology(cpu, 1);
> +			cpu_topology[cpu].core_id   = topology_id;
> +			topology_id = find_acpi_cpu_topology_package(cpu);
> +			cpu_topology[cpu].physical_id = topology_id;
> +		} else {
> +			cpu_topology[cpu].thread_id  = -1;
> +			cpu_topology[cpu].core_id    = topology_id;
> +			topology_id = find_acpi_cpu_topology_package(cpu);
> +			cpu_topology[cpu].physical_id = topology_id;
> +		}
> +	}

Add a space.

It is probably my fault so apologies if that's the case. The

find_acpi_cpu_topology()

API is a bit strange since it behaves differently according to the
level passed in.

I think it is better to define two calls (it might well have been like
that in one of the previous series versions):

- find_acpi_cpu_package_level() (returns: package level if success, <0 on
  failure)
- acpi_cpu_topology_id()

It would even be better to lump the two calls together but you do not
know how many topology levels are there so it becomes a bit complicated
to handle.

> +	return 0;
> +}
> +
> +#else
> +static int __init parse_acpi_topology(void)

static inline ?

> +{
> +	/*ACPI kernels should be built with PPTT support*/

I think you can remove this comment.

> +	return -EINVAL;
> +}
> +#endif
>  
>  void __init init_cpu_topology(void)
>  {
> @@ -309,6 +352,8 @@ void __init init_cpu_topology(void)
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
> index cb0775e1ee4b..170ce87edd88 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -43,6 +43,8 @@
>  		if (nr_cpus_node(node))
>  
>  int arch_update_cpu_topology(void);
> +int find_acpi_cpu_topology(unsigned int cpu, int level);
> +int find_acpi_cpu_topology_package(unsigned int cpu);

I do not think these two declarations:

a) belong in this patch
b) belong in include/linux/topology.h (should be acpi.h)

Lorenzo
