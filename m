From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 5/8] arm64: parse cpu capacity from DT
Date: Thu, 10 Dec 2015 14:15:00 +0000
Message-ID: <566988E4.1000003@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-6-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:36378 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752749AbbLJOPL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 09:15:11 -0500
In-Reply-To: <1448288921-30307-6-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, Mark Brown <broonie@linaro.org>

On 23/11/15 14:28, Juri Lelli wrote:
> With the introduction of cpu capacity bindings, CPU capacities can now be
> extracted from DT. Add parsing of such information at boot time. Also,
> store such information using per CPU variables, as we do for arm.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Brown <broonie@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

A lot of code disappears if you get rid of capacity-scale.

> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 694f6de..4423cc5 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -23,6 +23,45 @@
>  #include <asm/cputype.h>
>  #include <asm/topology.h>
>  
> +static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> +
> +unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> +{
> +	return per_cpu(cpu_scale, cpu);
> +}
> +
> +static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> +{
> +	per_cpu(cpu_scale, cpu) = capacity;
> +}
> +
> +static u32 capacity_scale = SCHED_CAPACITY_SCALE;
> +
> +static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> +{
> +	int ret;
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
> +		pr_info("CPU%d: DT cpu_capacity %lu\n",
> +			cpu, arch_scale_cpu_capacity(NULL, cpu));
> +	}
> +}
> +
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
>  	struct device_node *cpu_node;
> @@ -34,6 +73,7 @@ static int __init get_cpu_for_node(struct device_node *node)
>  
>  	for_each_possible_cpu(cpu) {
>  		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
> +			parse_cpu_capacity(cpu_node, cpu);
>  			of_node_put(cpu_node);
>  			return cpu;
>  		}
> @@ -173,6 +213,12 @@ static int __init parse_dt_topology(void)
>  		return 0;
>  	}
>  
> +	if (!of_property_read_u32(cn, "capacity-scale", &capacity_scale))
> +		pr_info("DT cpus capacity-scale %u\n", capacity_scale);
> +	else
> +		pr_debug("DT cpus capacity-scale not found: assuming %u\n",
> +			capacity_scale);
> +
>  	/*
>  	 * When topology is provided cpu-map is essentially a root
>  	 * cluster with restricted subnodes.
> 

