From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v3 1/4] arm: Frequency invariant scheduler load-tracking support
Date: Fri, 26 Jun 2015 16:53:41 -0700
Message-ID: <1435362824-26734-2-git-send-email-mturquette@linaro.org>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33061 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbFZXyI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 19:54:08 -0400
Received: by padev16 with SMTP id ev16so75747836pad.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 16:54:07 -0700 (PDT)
In-Reply-To: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl, Russell King <linux@arm.linux.org.uk>, Morten Rasmussen <morten.rasmussen@arm.com>, Michael Turquette <mturquette@baylibre.com>

From: Morten Rasmussen <Morten.Rasmussen@arm.com>

Implements arch-specific function to provide the scheduler with a
frequency scaling correction factor for more accurate load-tracking. The
factor is:

	current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_freq(cpu)

This implementation only provides frequency invariance. No
micro-architecture invariance yet.

Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 arch/arm/include/asm/topology.h |  7 ++++++
 arch/arm/kernel/smp.c           | 53 +++++++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/topology.c      | 17 +++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 2fe85ff..4b985dc 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -24,6 +24,13 @@ void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 
+#define arch_scale_freq_capacity arm_arch_scale_freq_capacity
+struct sched_domain;
+extern
+unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu);
+
+DECLARE_PER_CPU(atomic_long_t, cpu_freq_capacity);
+
 #else
 
 static inline void init_cpu_topology(void) { }
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 86ef244..297ce1b 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -672,12 +672,34 @@ static DEFINE_PER_CPU(unsigned long, l_p_j_ref);
 static DEFINE_PER_CPU(unsigned long, l_p_j_ref_freq);
 static unsigned long global_l_p_j_ref;
 static unsigned long global_l_p_j_ref_freq;
+static DEFINE_PER_CPU(atomic_long_t, cpu_max_freq);
+DEFINE_PER_CPU(atomic_long_t, cpu_freq_capacity);
+
+/*
+ * Scheduler load-tracking scale-invariance
+ *
+ * Provides the scheduler with a scale-invariance correction factor that
+ * compensates for frequency scaling through arch_scale_freq_capacity()
+ * (implemented in topology.c).
+ */
+static inline
+void scale_freq_capacity(int cpu, unsigned long curr, unsigned long max)
+{
+	unsigned long capacity;
+
+	if (!max)
+		return;
+
+	capacity = (curr << SCHED_CAPACITY_SHIFT) / max;
+	atomic_long_set(&per_cpu(cpu_freq_capacity, cpu), capacity);
+}
 
 static int cpufreq_callback(struct notifier_block *nb,
 					unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
 	int cpu = freq->cpu;
+	unsigned long max = atomic_long_read(&per_cpu(cpu_max_freq, cpu));
 
 	if (freq->flags & CPUFREQ_CONST_LOOPS)
 		return NOTIFY_OK;
@@ -702,6 +724,9 @@ static int cpufreq_callback(struct notifier_block *nb,
 					per_cpu(l_p_j_ref_freq, cpu),
 					freq->new);
 	}
+
+	scale_freq_capacity(cpu, freq->new, max);
+
 	return NOTIFY_OK;
 }
 
@@ -709,11 +734,35 @@ static struct notifier_block cpufreq_notifier = {
 	.notifier_call  = cpufreq_callback,
 };
 
+static int cpufreq_policy_callback(struct notifier_block *nb,
+						unsigned long val, void *data)
+{
+	struct cpufreq_policy *policy = data;
+	int i;
+
+	for_each_cpu(i, policy->cpus) {
+		scale_freq_capacity(i, policy->cur, policy->max);
+		atomic_long_set(&per_cpu(cpu_max_freq, i), policy->max);
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpufreq_policy_notifier = {
+	.notifier_call	= cpufreq_policy_callback,
+};
+
 static int __init register_cpufreq_notifier(void)
 {
-	return cpufreq_register_notifier(&cpufreq_notifier,
+	int ret;
+
+	ret = cpufreq_register_notifier(&cpufreq_notifier,
 						CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret)
+		return ret;
+
+	return cpufreq_register_notifier(&cpufreq_policy_notifier,
+						CPUFREQ_POLICY_NOTIFIER);
 }
 core_initcall(register_cpufreq_notifier);
-
 #endif
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 08b7847..9c09e6e 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -169,6 +169,23 @@ static void update_cpu_capacity(unsigned int cpu)
 		cpu, arch_scale_cpu_capacity(NULL, cpu));
 }
 
+/*
+ * Scheduler load-tracking scale-invariance
+ *
+ * Provides the scheduler with a scale-invariance correction factor that
+ * compensates for frequency scaling (arch_scale_freq_capacity()). The scaling
+ * factor is updated in smp.c
+ */
+unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
+{
+	unsigned long curr = atomic_long_read(&per_cpu(cpu_freq_capacity, cpu));
+
+	if (!curr)
+		return SCHED_CAPACITY_SCALE;
+
+	return curr;
+}
+
 #else
 static inline void parse_dt_topology(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
-- 
1.9.1

