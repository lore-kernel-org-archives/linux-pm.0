From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable
 'cpu_mask'
Date: Tue, 2 Sep 2014 06:46:08 +0000
Message-ID: <6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
 <3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:32004
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750751AbaIBGqL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 02:46:11 -0400
In-Reply-To: <3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, "LeoLi@freescale.com" <LeoLi@freescale.com>

Hello Viresh:

Probably it is not right considering the CPU cluster and CPU hotplug case.

Hongtao:
Please verify it on t4240 platform which have cluster.

Thanks,
Yuantian

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Tuesday, September 02, 2014 11:41 AM
> To: Rafael Wysocki; Tang Yuantian-B29983
> Cc: linaro-kernel@lists.linaro.org; linux-pm@vger.kernel.org; Zhang
> Hongbo-B45939; Li Yang-Leo-R58472; Viresh Kumar
> Subject: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
> 
> We are copying cpu_core_mask(cpu) in a per-cpu local variable: 'cpu_mask'.
> There is no need of doing this and can be replaced by a call to cpu_core_mask().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c
> b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index bee5df7..dbcac39 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -69,9 +69,6 @@ static const u32 *fmask;
> 
>  static DEFINE_PER_CPU(struct cpu_data *, cpu_data);
> 
> -/* cpumask in a cluster */
> -static DEFINE_PER_CPU(cpumask_var_t, cpu_mask);
> -
>  #ifndef CONFIG_SMP
>  static inline const struct cpumask *cpu_core_mask(int cpu)  { @@ -201,8
> +198,8 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	data->table = table;
> 
>  	/* update ->cpus if we have cluster, no harm if not */
> -	cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));
> -	for_each_cpu(i, per_cpu(cpu_mask, cpu))
> +	cpumask_copy(policy->cpus, cpu_core_mask(cpu));
> +	for_each_cpu(i, cpu_core_mask(cpu))
>  		per_cpu(cpu_data, i) = data;
> 
>  	/* Minimum transition latency is 12 platform clocks */ @@ -236,7 +233,7
> @@ static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  	kfree(data->table);
>  	kfree(data);
> 
> -	for_each_cpu(cpu, per_cpu(cpu_mask, policy->cpu))
> +	for_each_cpu(cpu, cpu_core_mask(policy->cpu))
>  		per_cpu(cpu_data, cpu) = NULL;
> 
>  	return 0;
> @@ -285,12 +282,6 @@ static int __init ppc_corenet_cpufreq_init(void)
>  	if (!np)
>  		return -ENODEV;
> 
> -	for_each_possible_cpu(cpu) {
> -		if (!alloc_cpumask_var(&per_cpu(cpu_mask, cpu), GFP_KERNEL))
> -			goto err_mask;
> -		cpumask_copy(per_cpu(cpu_mask, cpu), cpu_core_mask(cpu));
> -	}
> -
>  	match = of_match_node(node_matches, np);
>  	data = match->data;
>  	if (data) {
> @@ -308,22 +299,11 @@ static int __init ppc_corenet_cpufreq_init(void)
>  		pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
> 
>  	return ret;
> -
> -err_mask:
> -	for_each_possible_cpu(cpu)
> -		free_cpumask_var(per_cpu(cpu_mask, cpu));
> -
> -	return -ENOMEM;
>  }
>  module_init(ppc_corenet_cpufreq_init);
> 
>  static void __exit ppc_corenet_cpufreq_exit(void)  {
> -	unsigned int cpu;
> -
> -	for_each_possible_cpu(cpu)
> -		free_cpumask_var(per_cpu(cpu_mask, cpu));
> -
>  	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
>  }
>  module_exit(ppc_corenet_cpufreq_exit);
> --
> 2.0.3.693.g996b0fd

