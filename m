From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 3/8] arm: parse cpu capacity from DT
Date: Thu, 10 Dec 2015 14:14:53 +0000
Message-ID: <566988DD.9080005@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-4-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448288921-30307-4-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

On 23/11/15 14:28, Juri Lelli wrote:
> With the introduction of cpu capacity bindings, CPU capacities can now be
> extracted from DT. Add parsing of such information at boot time. We keep
> code that can produce same information, based on different DT properties
> and hard-coded values, as fall-back for backward compatibility.

This patch-set should define _one_ way to be able to specify
heterogeneous cpu capacity values for all arm and arm64 systems. So I
would really like that we can agree on this solution ('capacity'
property) and delete the old (cortex-a[15,7] only) solution based on
struct cpu_efficiency table_efficiency[] and 'clock-frequency' property
in arch/arm/kernel/topology.c. The appropriate code in
arch/arm[,64]/kernel/topology.c should be the same. Everything else is
highly confusing.

> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index ec279d1..ecbff03 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -78,6 +78,35 @@ static unsigned long *__cpu_capacity;
>  #define cpu_capacity(cpu)	__cpu_capacity[cpu]
>  
>  static unsigned long middle_capacity = 1;
> +static bool capacity_from_dt = true;
> +static u32 capacity_scale = SCHED_CAPACITY_SCALE;
> +
> +static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> +{
> +	int ret = 1;
> +	u32 cpu_capacity;
> +
> +	ret = of_property_read_u32(cpu_node,
> +				   "capacity",
> +				   &cpu_capacity);
> +	if (!ret) {
> +		u64 capacity;
> +
> +		/*
> +		 * Enforce capacity <= capacity-scale.
> +		 */
> +		cpu_capacity = cpu_capacity <= capacity_scale ? cpu_capacity :
> +			capacity_scale;
> +		capacity = (cpu_capacity << SCHED_CAPACITY_SHIFT) /
> +			capacity_scale;
> +
> +		set_capacity_scale(cpu, capacity);
> +		pr_info("CPU%d: DT cpu capacity %lu\n",
> +			cpu, arch_scale_cpu_capacity(NULL, cpu));
> +	}
> +
> +	return !ret;
> +}
>  
>  /*
>   * Iterate all CPUs' descriptor in DT and compute the efficiency
> @@ -99,6 +128,18 @@ static void __init parse_dt_topology(void)
>  	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
>  				 GFP_NOWAIT);
>  
> +	cn = of_find_node_by_path("/cpus");
> +	if (!cn) {
> +		pr_err("No CPU information found in DT\n");
> +		return;
> +	}
> +
> +	if (!of_property_read_u32(cn, "capacity-scale", &capacity_scale))
> +		pr_info("DT cpus capacity-scale %u\n", capacity_scale);
> +	else
> +		pr_debug("DT cpus capacity-scale not found: assuming %u\n",
> +			capacity_scale);
> +
>  	for_each_possible_cpu(cpu) {
>  		const u32 *rate;
>  		int len;
> @@ -110,6 +151,13 @@ static void __init parse_dt_topology(void)
>  			continue;
>  		}
>  
> +		if (parse_cpu_capacity(cn, cpu)) {
> +			of_node_put(cn);
> +			continue;
> +		}
> +
> +		capacity_from_dt = false;
> +
>  		for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
>  			if (of_device_is_compatible(cn, cpu_eff->compatible))
>  				break;
> @@ -160,7 +208,7 @@ static void __init parse_dt_topology(void)
>   */
>  static void update_cpu_capacity(unsigned int cpu)
>  {
> -	if (!cpu_capacity(cpu))
> +	if (!cpu_capacity(cpu) || capacity_from_dt)
>  		return;
>  
>  	set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
> 
