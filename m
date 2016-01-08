From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH v2 2/4] drivers/cpufreq: implement init_cpu_capacity_default()
Date: Fri,  8 Jan 2016 14:09:30 +0000
Message-ID: <1452262172-31861-3-git-send-email-juri.lelli@arm.com>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

To get default values for CPUs capacity we profile a simple (bogus)
integer benchmark on such CPUs; then we normalize results to 1024
(highest capacity in the system).

Architectures that want this during boot have to register a cpufreq
driver callback and call this function from there (as we require
cpufreq to be up and running).

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c         |   2 +-
 arch/arm64/kernel/topology.c       |  12 +++
 drivers/cpufreq/Makefile           |   2 +-
 drivers/cpufreq/cpufreq.c          |   1 +
 drivers/cpufreq/cpufreq_capacity.c | 161 +++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h            |   2 +
 6 files changed, 178 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq_capacity.c

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ec279d1..c9c87a5 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -47,7 +47,7 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 	return per_cpu(cpu_scale, cpu);
 }
 
-static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
+void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 {
 	per_cpu(cpu_scale, cpu) = capacity;
 }
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 694f6de..3b75d63 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -23,6 +23,18 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
+static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+
+unsigned long arm_arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
+
+void set_capacity_scale(unsigned int cpu, unsigned long capacity)
+{
+	per_cpu(cpu_scale, cpu) = capacity;
+}
+
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	struct device_node *cpu_node;
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c0af1a1..ca47aea 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -1,5 +1,5 @@
 # CPUfreq core
-obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_table.o
+obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_table.o cpufreq_capacity.o
 
 # CPUfreq stats
 obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8412ce5..8720228 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2452,6 +2452,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	}
 
 	register_hotcpu_notifier(&cpufreq_cpu_notifier);
+	cpufreq_init_cpu_capacity();
 	pr_debug("driver %s up and running\n", driver_data->name);
 
 out:
diff --git a/drivers/cpufreq/cpufreq_capacity.c b/drivers/cpufreq/cpufreq_capacity.c
new file mode 100644
index 0000000..2fd5248
--- /dev/null
+++ b/drivers/cpufreq/cpufreq_capacity.c
@@ -0,0 +1,161 @@
+/*
+ * Default CPU capacity calculation for u-arch invariance
+ *
+ * Copyright (C) 2015 ARM Ltd.
+ * Juri Lelli <juri.lelli@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#include <linux/cpufreq.h>
+#include <linux/sched.h>
+
+static unsigned long long elapsed[NR_CPUS];
+
+/*
+ * Don't let compiler optimize following two functions;
+ * otherwise we might loose u-arch differences.
+ * Also, my_int_sqrt is cut-and-paste from lib/int_sqrt.c.
+ */
+static unsigned long __attribute__((optimize("O0")))
+my_int_sqrt(unsigned long x)
+{
+	unsigned long b, m, y = 0;
+
+	if (x <= 1)
+		return x;
+
+	m = 1UL << (BITS_PER_LONG - 2);
+	while (m != 0) {
+		b = y + m;
+		y >>= 1;
+
+		if (x >= b) {
+			x -= b;
+			y += m;
+		}
+		m >>= 2;
+	}
+
+	return y;
+}
+
+static unsigned long __attribute__((optimize("O0")))
+bogus_bench(void)
+{
+	unsigned long i, res;
+
+	for (i = 0; i < 100000; i++)
+		res = my_int_sqrt(i);
+
+	return res;
+}
+
+static int run_bogus_benchmark(int cpu)
+{
+	int ret, trials = 25;
+	u64 begin, end, diff, diff_avg = 0, count = 0;
+	unsigned long res;
+
+	ret = set_cpus_allowed_ptr(current, cpumask_of(cpu));
+	if (ret) {
+		pr_warn("%s: failed to set allowed ptr\n", __func__);
+		return -EINVAL;
+	}
+
+	while (trials--) {
+		begin = local_clock();
+		res = bogus_bench();
+		end = local_clock();
+		diff = end - begin;
+		diff_avg = diff_avg * count + diff;
+		diff_avg = div64_u64(diff_avg, ++count);
+		pr_debug("%s: cpu=%d begin=%llu end=%llu"
+			 " diff=%llu diff_avg=%llu count=%llu res=%lu\n",
+			__func__, cpu, begin, end, diff,
+			diff_avg, count, res);
+	}
+	elapsed[cpu] = diff_avg;
+
+	ret = set_cpus_allowed_ptr(current, cpu_active_mask);
+	if (ret) {
+		pr_warn("%s: failed to set allowed ptr\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+bool __weak arch_wants_init_cpu_capacity(void)
+{
+	return false;
+}
+
+void __weak set_capacity_scale(int cpu, unsigned long capacity) { }
+
+void cpufreq_init_cpu_capacity(void)
+{
+	int cpu, fcpu;
+	unsigned long long elapsed_min = ULLONG_MAX;
+	unsigned int curr_min, curr_max;
+	struct cpufreq_policy *policy;
+
+	if (!arch_wants_init_cpu_capacity())
+		return;
+
+	for_each_possible_cpu(cpu) {
+		policy = cpufreq_cpu_get(cpu);
+		if (IS_ERR_OR_NULL(policy))
+			return;
+
+		/*
+		 * We profile only first CPU of each frequency domain;
+		 * and use that value as capacity of every CPU in the domain.
+		 */
+		fcpu = cpumask_first(policy->related_cpus);
+		if (cpu != fcpu) {
+			elapsed[cpu] = elapsed[fcpu];
+			cpufreq_cpu_put(policy);
+			continue;
+		}
+
+		down_write(&policy->rwsem);
+		curr_min = policy->user_policy.min;
+		curr_max = policy->user_policy.max;
+		policy->user_policy.min = policy->cpuinfo.max_freq;
+		policy->user_policy.max = policy->cpuinfo.max_freq;
+		up_write(&policy->rwsem);
+		cpufreq_cpu_put(policy);
+		cpufreq_update_policy(cpu);
+
+		run_bogus_benchmark(cpu);
+		if (elapsed[cpu] < elapsed_min)
+			elapsed_min = elapsed[cpu];
+		pr_debug("%s: cpu=%d elapsed=%llu (min=%llu)\n",
+				__func__, cpu, elapsed[cpu], elapsed_min);
+
+		policy = cpufreq_cpu_get(cpu);
+		down_write(&policy->rwsem);
+		policy->user_policy.min = curr_min;
+		policy->user_policy.max = curr_max;
+		up_write(&policy->rwsem);
+		cpufreq_cpu_put(policy);
+		cpufreq_update_policy(cpu);
+	}
+
+	for_each_possible_cpu(cpu) {
+		unsigned long capacity;
+
+		capacity = div64_u64((elapsed_min << 10), elapsed[cpu]);
+		pr_debug("%s: CPU%d capacity=%lu\n", __func__, cpu, capacity);
+		set_capacity_scale(cpu, capacity);
+	}
+
+	pr_info("dynamic CPUs capacity installed\n");
+}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 177c768..968be47 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -420,6 +420,8 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
 #endif
 }
 
+void cpufreq_init_cpu_capacity(void);
+
 /*********************************************************************
  *                          CPUFREQ GOVERNORS                        *
  *********************************************************************/
-- 
2.2.2
