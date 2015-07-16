From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH RFC] intel_pstate: play well with frequency limits set by
 acpi
Date: Thu, 16 Jul 2015 21:17:06 +0300
Message-ID: <20150716181706.6500.64386.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Ethan Zhao <ethan.zhao@oracle.com>
List-Id: linux-pm@vger.kernel.org

IPMI can control CPU P-states remotely: configuration is reported via
common ACPI interface (_PPC/_PSS/etc). This patch adds required minimal
support in intel_pstate to receive and use these P-state limits.

* ignore limit of top state in _PPC: it lower than turbo boost frequency
* register intel_pstate in acpi-processor to get states from _PSS
* link acpi_processor_get_bios_limit: this adds attribute "bios_limit"

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/acpi/processor_perflib.c |    3 +-
 drivers/cpufreq/intel_pstate.c   |   57 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index cfc8aba72f86..781e328c9d5f 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -98,7 +98,8 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
 
 	ppc = (unsigned int)pr->performance_platform_limit;
 
-	if (ppc >= pr->performance->state_count)
+	/* Ignore limit of top state: it lower than turbo boost frequency */
+	if (!ppc || ppc >= pr->performance->state_count)
 		goto out;
 
 	cpufreq_verify_within_limits(policy, 0,
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 15ada47bb720..4a34ddf4fa73 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <acpi/processor.h>
 #include <linux/vmalloc.h>
 #include <trace/events/power.h>
 
@@ -113,6 +114,9 @@ struct cpudata {
 	u64	prev_mperf;
 	u64	prev_tsc;
 	struct sample sample;
+#ifdef CONFIG_ACPI_PROCESSOR
+	struct acpi_processor_performance acpi_data;
+#endif
 };
 
 static struct cpudata **all_cpu_data;
@@ -145,6 +149,7 @@ static int hwp_active;
 
 struct perf_limits {
 	int no_turbo;
+	int no_acpi;
 	int turbo_disabled;
 	int max_perf_pct;
 	int min_perf_pct;
@@ -158,6 +163,7 @@ struct perf_limits {
 
 static struct perf_limits limits = {
 	.no_turbo = 0,
+	.no_acpi = !IS_ENABLED(CONFIG_ACPI_PROCESSOR),
 	.turbo_disabled = 0,
 	.max_perf_pct = 100,
 	.max_perf = int_tofp(1),
@@ -449,6 +455,18 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
+static ssize_t store_no_acpi(struct kobject *a, struct attribute *b,
+			     const char *buf, size_t count)
+{
+#ifdef CONFIG_ACPI_PROCESSOR
+	return kstrtouint(buf, 0, &limits.no_acpi) ?: count;
+#else
+	return -ENODEV;
+#endif
+}
+show_one(no_acpi, no_acpi);
+define_one_global_rw(no_acpi);
+
 show_one(max_perf_pct, max_perf_pct);
 show_one(min_perf_pct, min_perf_pct);
 
@@ -460,6 +478,7 @@ define_one_global_ro(num_pstates);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&no_turbo.attr,
+	&no_acpi.attr,
 	&max_perf_pct.attr,
 	&min_perf_pct.attr,
 	&turbo_pct.attr,
@@ -1049,6 +1068,38 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	cpumask_set_cpu(policy->cpu, policy->cpus);
 
+#ifdef CONFIG_ACPI_PROCESSOR
+	if (!limits.no_acpi) {
+		/*
+		 * Minimum necessary to get acpi_processor_ppc_notifier() and
+		 * acpi_processor_get_bios_limit() working.
+		 */
+		if (!zalloc_cpumask_var(&cpu->acpi_data.shared_cpu_map,
+					GFP_KERNEL))
+			rc = -ENOMEM;
+		else
+			rc = acpi_processor_register_performance(
+					&cpu->acpi_data, policy->cpu);
+		if (rc) {
+			pr_err("intel_pstate: acpi init failed: %d\n", rc);
+			free_cpumask_var(cpu->acpi_data.shared_cpu_map);
+			limits.no_acpi = 1;
+		}
+	}
+#endif
+	return 0;
+}
+
+static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
+{
+#ifdef CONFIG_ACPI_PROCESSOR
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
+	if (cpu->acpi_data.state_count)
+		acpi_processor_unregister_performance(&cpu->acpi_data,
+						      policy->cpu);
+	free_cpumask_var(cpu->acpi_data.shared_cpu_map);
+#endif
 	return 0;
 }
 
@@ -1057,7 +1108,11 @@ static struct cpufreq_driver intel_pstate_driver = {
 	.verify		= intel_pstate_verify_policy,
 	.setpolicy	= intel_pstate_set_policy,
 	.get		= intel_pstate_get,
+#ifdef CONFIG_ACPI_PROCESSOR
+	.bios_limit	= acpi_processor_get_bios_limit,
+#endif
 	.init		= intel_pstate_cpu_init,
+	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
 	.name		= "intel_pstate",
 };
@@ -1286,6 +1341,8 @@ static int __init intel_pstate_setup(char *str)
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
 		hwp_only = 1;
+	if (!strcmp(str, "no_acpi"))
+		limits.no_acpi = 1;
 	return 0;
 }
 early_param("intel_pstate", intel_pstate_setup);
