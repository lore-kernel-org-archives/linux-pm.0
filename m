From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v3 2/2] ACPI PID: Add frequency domain awareness.
Date: Wed, 19 Nov 2014 15:34:53 -0500
Message-ID: <1416429293-3798-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1416429293-3798-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:64973 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbaKSUfI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 15:35:08 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so1547600pdj.21
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2014 12:35:07 -0800 (PST)
In-Reply-To: <1416429293-3798-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: rwells@codeaurora.org, linda.knippers@hp.com, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, dirk.brandewie@gmail.com, patches@linaro.org, linaro-acpi@list.linaro.org, rjw@rjwysocki.net, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Previously the driver assumed each CPU to be in
its own frequency domain. But this may not be always
true in practice. Search for the PSD ACPI package for
each CPU and parse its domain information.

Once this information is known, the first CPU to wake
up from a timeout evaluates all other CPUs in its domain
and makes a collective vote for all. Each sibling CPUs
timeout is defferred as it is evaluated. There could be a
pending IRQ for such a CPU, in which case a spinlock
protects the sample data, and on spin_unlock, we let
it proceed and re-evaluate.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/acpi_pid.c | 112 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/acpi_pid.c b/drivers/cpufreq/acpi_pid.c
index f8d8376..ccaace9 100644
--- a/drivers/cpufreq/acpi_pid.c
+++ b/drivers/cpufreq/acpi_pid.c
@@ -60,6 +60,7 @@
 #include <linux/mailbox_client.h>
 #include <trace/events/power.h>
 
+#include <acpi/processor.h>
 #include <asm/div64.h>
 
 #define FRAC_BITS 8
@@ -114,6 +115,14 @@ struct cpudata {
 	u64	prev_reference;
 	u64	prev_delivered;
 	struct sample sample;
+	cpumask_var_t shared_cpus;
+	/*
+	 * This lock protects a CPU sample
+	 * from being overwritten while it
+	 * is being evaluated by another CPU
+	 * in the shared_cpu map.
+	 */
+	spinlock_t sample_lock;
 };
 
 static struct cpudata **all_cpu_data;
@@ -207,6 +216,7 @@ struct cpc_desc {
 };
 
 static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
+static struct acpi_processor_performance __percpu *acpi_perf_info;
 
 static int cpc_read64(u64 *val, struct cpc_register_resource *reg)
 {
@@ -535,6 +545,8 @@ static inline int acpi_pid_sample(struct cpudata *cpu)
 {
 	int ret = 0;
 
+	spin_lock(&cpu->sample_lock);
+
 	cpu->last_sample_time = cpu->sample.time;
 	cpu->sample.time = ktime_get();
 
@@ -545,6 +557,8 @@ static inline int acpi_pid_sample(struct cpudata *cpu)
 
 	acpi_pid_calc_busy(cpu);
 
+	spin_unlock(&cpu->sample_lock);
+
 	return ret;
 }
 
@@ -579,40 +593,51 @@ static inline int32_t acpi_pid_get_scaled_busy(struct cpudata *cpu)
 	return core_busy;
 }
 
-static inline int acpi_pid_adjust_busy_pstate(struct cpudata *cpu)
+static void acpi_pid_timer_func(unsigned long __data)
 {
-	int32_t busy_scaled;
+	struct cpudata *cpu = (struct cpudata *) __data;
+	struct sample *sample;
+	struct cpudata *sibling_cpu;
+	struct cpudata *max_busy_cpu = NULL;
 	struct _pid *pid;
 	signed int ctl;
+	int32_t max_busy = 0, busy, i;
 
-	pid = &cpu->pid;
-	busy_scaled = acpi_pid_get_scaled_busy(cpu);
+	for_each_cpu(i, cpu->shared_cpus) {
+		/* Get sibling cpu ptr. */
+		sibling_cpu = all_cpu_data[i];
 
-	ctl = pid_calc(pid, busy_scaled);
+		/* Get its sample data. */
+		acpi_pid_sample(sibling_cpu);
 
-	/* Negative values of ctl increase the pstate and vice versa */
-	return acpi_pid_set_pstate(cpu, cpu->pstate.current_pstate - ctl);
-}
+		/* Defer its timeout. */
+		acpi_pid_set_sample_time(sibling_cpu);
 
-static void acpi_pid_timer_func(unsigned long __data)
-{
-	struct cpudata *cpu = (struct cpudata *) __data;
-	struct sample *sample;
+		/* Calc how busy it was. */
+		busy = acpi_pid_get_scaled_busy(sibling_cpu);
 
-	acpi_pid_sample(cpu);
+		/* Was this the most busiest? */
+		if (busy >= max_busy) {
+			max_busy = busy;
+			max_busy_cpu = sibling_cpu;
+		}
+	}
 
-	sample = &cpu->sample;
+	sample = &max_busy_cpu->sample;
 
-	acpi_pid_adjust_busy_pstate(cpu);
+	pid = &max_busy_cpu->pid;
+	ctl = pid_calc(pid, max_busy);
+
+	/* XXX: This needs to change depending on SW_ANY/SW_ALL */
+	/* Negative values of ctl increase the pstate and vice versa */
+	acpi_pid_set_pstate(max_busy_cpu, max_busy_cpu->pstate.current_pstate - ctl);
 
 	trace_pstate_sample(fp_toint(sample->core_pct_busy),
 			fp_toint(acpi_pid_get_scaled_busy(cpu)),
 			cpu->pstate.current_pstate,
-			sample->delivered,
 			sample->reference,
+			sample->delivered,
 			sample->freq);
-
-	acpi_pid_set_sample_time(cpu);
 }
 
 static int acpi_pid_init_cpu(unsigned int cpunum)
@@ -627,6 +652,7 @@ static int acpi_pid_init_cpu(unsigned int cpunum)
 	cpu = all_cpu_data[cpunum];
 
 	cpu->cpu = cpunum;
+	spin_lock_init(&cpu->sample_lock);
 	ret = acpi_pid_get_cpu_pstates(cpu);
 
 	if (ret < 0)
@@ -712,6 +738,7 @@ static void acpi_pid_stop_cpu(struct cpufreq_policy *policy)
 static int acpi_pid_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
+	struct acpi_processor_performance *perf;
 	int rc;
 
 	rc = acpi_pid_init_cpu(policy->cpu);
@@ -732,7 +759,25 @@ static int acpi_pid_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * 100000;
 	policy->cpuinfo.max_freq = cpu->pstate.max_pstate * 100000;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+
+	if (!zalloc_cpumask_var_node(&cpu->shared_cpus,
+			GFP_KERNEL, cpu_to_node(policy->cpu))) {
+		pr_err("No mem for shared_cpus cpumask\n");
+		return -ENOMEM;
+	}
+
+	/* Parse the PSD info we acquired in acpi_cppc_init */
+	perf = per_cpu_ptr(acpi_perf_info, policy->cpu);
+	policy->shared_type = perf->shared_type;
+
+	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL ||
+	    policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
+		cpumask_copy(policy->cpus, perf->shared_cpu_map);
+		cpumask_copy(cpu->shared_cpus, perf->shared_cpu_map);
+	}
+
 	cpumask_set_cpu(policy->cpu, policy->cpus);
+	cpumask_set_cpu(policy->cpu, cpu->shared_cpus);
 
 	return 0;
 }
@@ -1103,8 +1148,20 @@ static struct cpu_defaults acpi_pid_cppc = {
 	},
 };
 
+static void free_acpi_perf_info(void)
+{
+	unsigned int i;
+
+	for_each_possible_cpu(i)
+		free_cpumask_var(per_cpu_ptr(acpi_perf_info, i)
+				 ->shared_cpu_map);
+	free_percpu(acpi_perf_info);
+}
+
 static int __init acpi_cppc_init(void)
 {
+	unsigned int i;
+
 	if (acpi_disabled || acpi_cppc_processor_probe()) {
 		pr_err("Err initializing CPC structures or ACPI is disabled\n");
 		return -ENODEV;
@@ -1113,7 +1170,24 @@ static int __init acpi_cppc_init(void)
 	copy_pid_params(&acpi_pid_cppc.pid_policy);
 	copy_cpu_funcs(&acpi_pid_cppc.funcs);
 
-	return 0;
+	acpi_perf_info = alloc_percpu(struct acpi_processor_performance);
+	if (!acpi_perf_info) {
+		pr_err("Out for mem for acpi_perf_info\n");
+		return -ENOMEM;
+	}
+
+	for_each_possible_cpu(i) {
+		if (!zalloc_cpumask_var_node(
+			&per_cpu_ptr(acpi_perf_info, i)->shared_cpu_map,
+			GFP_KERNEL, cpu_to_node(i))) {
+
+			free_acpi_perf_info();
+			return -ENOMEM;
+		}
+	}
+
+	/* Get _PSD info about CPUs and the freq domain they belong to. */
+	return acpi_processor_preregister_performance(acpi_perf_info);
 }
 
 static int __init acpi_pid_init(void)
-- 
1.9.1

