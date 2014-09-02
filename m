From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable 'cpu_mask'
Date: Tue,  2 Sep 2014 09:11:25 +0530
Message-ID: <3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:63450 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbaIBDlr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Sep 2014 23:41:47 -0400
Received: by mail-pd0-f180.google.com with SMTP id p10so7432496pdj.25
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2014 20:41:47 -0700 (PDT)
In-Reply-To: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
In-Reply-To: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, yuantian.tang@freescale.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, hongbo.zhang@freescale.com, leoli@freescale.com, Viresh Kumar <viresh.kumar@linaro.org>

We are copying cpu_core_mask(cpu) in a per-cpu local variable: 'cpu_mask'. There
is no need of doing this and can be replaced by a call to cpu_core_mask().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index bee5df7..dbcac39 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -69,9 +69,6 @@ static const u32 *fmask;
 
 static DEFINE_PER_CPU(struct cpu_data *, cpu_data);
 
-/* cpumask in a cluster */
-static DEFINE_PER_CPU(cpumask_var_t, cpu_mask);
-
 #ifndef CONFIG_SMP
 static inline const struct cpumask *cpu_core_mask(int cpu)
 {
@@ -201,8 +198,8 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	data->table = table;
 
 	/* update ->cpus if we have cluster, no harm if not */
-	cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));
-	for_each_cpu(i, per_cpu(cpu_mask, cpu))
+	cpumask_copy(policy->cpus, cpu_core_mask(cpu));
+	for_each_cpu(i, cpu_core_mask(cpu))
 		per_cpu(cpu_data, i) = data;
 
 	/* Minimum transition latency is 12 platform clocks */
@@ -236,7 +233,7 @@ static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	kfree(data->table);
 	kfree(data);
 
-	for_each_cpu(cpu, per_cpu(cpu_mask, policy->cpu))
+	for_each_cpu(cpu, cpu_core_mask(policy->cpu))
 		per_cpu(cpu_data, cpu) = NULL;
 
 	return 0;
@@ -285,12 +282,6 @@ static int __init ppc_corenet_cpufreq_init(void)
 	if (!np)
 		return -ENODEV;
 
-	for_each_possible_cpu(cpu) {
-		if (!alloc_cpumask_var(&per_cpu(cpu_mask, cpu), GFP_KERNEL))
-			goto err_mask;
-		cpumask_copy(per_cpu(cpu_mask, cpu), cpu_core_mask(cpu));
-	}
-
 	match = of_match_node(node_matches, np);
 	data = match->data;
 	if (data) {
@@ -308,22 +299,11 @@ static int __init ppc_corenet_cpufreq_init(void)
 		pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
 
 	return ret;
-
-err_mask:
-	for_each_possible_cpu(cpu)
-		free_cpumask_var(per_cpu(cpu_mask, cpu));
-
-	return -ENOMEM;
 }
 module_init(ppc_corenet_cpufreq_init);
 
 static void __exit ppc_corenet_cpufreq_exit(void)
 {
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu)
-		free_cpumask_var(per_cpu(cpu_mask, cpu));
-
 	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
 }
 module_exit(ppc_corenet_cpufreq_exit);
-- 
2.0.3.693.g996b0fd

