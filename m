From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 73/92] cpufreq: create cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:07 +0530
Message-ID: <1acdd71070c71508c3595162864c944cc6f1f912.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many CPUFreq drivers for SMP system (where all cores share same clock lines), do
similar stuff in their ->init() part.

This patch creates a generic routine in cpufreq core which can be used by these
so that we can remove some redundant code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig   |  1 +
 drivers/cpufreq/cpufreq.c | 31 +++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 534fcb8..2d06754 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -2,6 +2,7 @@ menu "CPU Frequency scaling"
 
 config CPU_FREQ
 	bool "CPU Frequency scaling"
+	select CPU_FREQ_TABLE
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
 	  CPUs on the fly. This is a nice method to save power, because 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1a944f7..ff70e0b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -183,6 +183,37 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time);
 
+/*
+ * This is a generic cpufreq init() routine which can be used by cpufreq
+ * drivers of SMP systems. It will do following:
+ * - validate & show freq table passed
+ * - set policies transition latency
+ * - policy->cpus with all possible CPUs
+ */
+int cpufreq_generic_init(struct cpufreq_policy *policy,
+		struct cpufreq_frequency_table *table,
+		unsigned int transition_latency)
+{
+	int ret;
+
+	ret = cpufreq_table_validate_and_show(policy, table);
+	if (ret) {
+		pr_err("%s: invalid frequency table: %d\n", __func__, ret);
+		return ret;
+	}
+
+	policy->cpuinfo.transition_latency = transition_latency;
+
+	/*
+	 * The driver only supports the SMP configuartion where all processors
+	 * share the clock and voltage and clock.
+	 */
+	cpumask_setall(policy->cpus);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_generic_init);
+
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = NULL;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c808809..d0d0b50 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -415,6 +415,9 @@ void cpufreq_frequency_table_put_attr(unsigned int cpu);
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
 
+int cpufreq_generic_init(struct cpufreq_policy *policy,
+		struct cpufreq_frequency_table *table,
+		unsigned int transition_latency);
 static inline int cpufreq_generic_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_put_attr(policy->cpu);
-- 
1.7.12.rc2.18.g61b472e

