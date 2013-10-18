From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 3/5] ARM: vexpress/TC2: add cpu clock support
Date: Fri, 18 Oct 2013 14:53:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310181442410.1951@syhkavp.arg>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1381931563-16785-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:54531 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab3JRSxc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2013 14:53:32 -0400
Received: by mail-qc0-f170.google.com with SMTP id n9so2989674qcw.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2013 11:53:31 -0700 (PDT)
In-Reply-To: <1381931563-16785-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Pawel Moll <Pawel.Moll@arm.com>

On Wed, 16 Oct 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> On TC2, the cpu clocks are controlled by the external M3 microcontroller
> and SPC provides the interface between the CPU and the power controller.
> 
> The generic cpufreq drivers use the clock APIs to get the cpu clocks.
> This patch add virtual spc clocks for all the cpus to control the cpu
> operating frequency via the clock framework.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Cc: Pawel Moll <Pawel.Moll@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Ninor comment below.


> ---
>  arch/arm/mach-vexpress/spc.c | 119 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index ef7e652..a8b8310 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -17,6 +17,9 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/cpu.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> @@ -416,3 +419,119 @@ int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid, int irq)
>  
>  	return 0;
>  }
> +
> +struct clk_spc {
> +	struct clk_hw hw;
> +	int cluster;
> +};
> +
> +#define to_clk_spc(spc) container_of(spc, struct clk_spc, hw)
> +static unsigned long spc_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct clk_spc *spc = to_clk_spc(hw);
> +	u32 freq;
> +
> +	if (ve_spc_get_performance(spc->cluster, &freq))
> +		return -EIO;
> +
> +	return freq * 1000;
> +}
> +
> +static long spc_round_rate(struct clk_hw *hw, unsigned long drate,
> +		unsigned long *parent_rate)
> +{
> +	struct clk_spc *spc = to_clk_spc(hw);
> +
> +	return ve_spc_round_performance(spc->cluster, drate);
> +}
> +
> +static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
> +		unsigned long parent_rate)
> +{
> +	struct clk_spc *spc = to_clk_spc(hw);
> +
> +	return ve_spc_set_performance(spc->cluster, rate / 1000);
> +}
> +
> +static struct clk_ops clk_spc_ops = {
> +	.recalc_rate = spc_recalc_rate,
> +	.round_rate = spc_round_rate,
> +	.set_rate = spc_set_rate,
> +};
> +
> +static struct clk *ve_spc_clk_register(struct device *cpu_dev)
> +{
> +	struct clk_init_data init;
> +	struct clk_spc *spc;
> +
> +	spc = kzalloc(sizeof(*spc), GFP_KERNEL);
> +	if (!spc) {
> +		pr_err("could not allocate spc clk\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	spc->hw.init = &init;
> +	spc->cluster = topology_physical_package_id(cpu_dev->id);
> +
> +	init.name = dev_name(cpu_dev);
> +	init.ops = &clk_spc_ops;
> +	init.flags = CLK_IS_ROOT | CLK_GET_RATE_NOCACHE;
> +	init.num_parents = 0;
> +
> +	return devm_clk_register(cpu_dev, &spc->hw);
> +}
> +
> +static int ve_init_opp_table(struct device *cpu_dev)
> +{
> +	int cluster = topology_physical_package_id(cpu_dev->id);
> +	int idx, ret = 0, max_opp = info->num_opps[cluster];
> +	struct ve_spc_opp *opps = info->opps[cluster];
> +
> +	for (idx = 0; idx < max_opp; idx++, opps++) {
> +		ret = opp_add(cpu_dev, opps->freq * 1000, opps->u_volt);
> +		if (ret) {
> +			dev_warn(cpu_dev, "failed to add opp %lu %lu\n",
> +				 opps->freq, opps->u_volt);
> +			return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int __init ve_spc_clk_init(void)
> +{
> +	int cpu;
> +	struct clk *clk;
> +
> +	if (!info)
> +		return 0; /* Continue only if SPC is initialised */
> +
> +	if (ve_spc_populate_opps(0) || ve_spc_populate_opps(1)) {
> +		pr_err("failed to build OPP table\n");
> +		return -ENODEV;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev) {
> +			pr_warn("failed to get cpu%d device\n", cpu);
> +			continue;
> +		}
> +		clk = ve_spc_clk_register(cpu_dev);
> +		if (IS_ERR(clk)) {
> +			pr_warn("failed to register cpu%d clock\n", cpu);
> +			continue;
> +		}
> +		if (clk_register_clkdev(clk, NULL, dev_name(cpu_dev))) {
> +			pr_warn("failed to register cpu%d clock lookup\n", cpu);
> +			continue;
> +		}
> +
> +		if (ve_init_opp_table(cpu_dev))
> +			pr_warn("failed to initialise cpu%d opp table\n", cpu);
> +	}
> +
> +	return 0;
> +}
> +module_init(ve_spc_clk_init);

This file is not compilable as a module as it is needed to start up 
secondary CPUs during boot.  In that case the module_init() is converted 
to device_initcall() which is the same level as used by ve_spc_cpufreq 
when both are compiled in.  To avoid possible unordered init calls, I'd 
suggest making this into a higher priority init call such as 
subsys_initcall(() ... unless this one is already used by or earlier 
than the clock infrastructure initialization (I didn't check).  Despite 
the name fs_initcall() ought to do the job.

With that change, you may add

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
