From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH] acpi-cpufreq: use same acpi_cpufreq_data if policy is shared
Date: Fri, 03 Jul 2015 16:01:16 +0800
Message-ID: <5596414C.4090106@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org


cpufreq core will mark all cpus in policy->cpus as initialized
by setting percpu cpufreq_cpu_data = policy.
However in acpi-cpufreq, we did not set percpu acpi_cpufreq_data for
all cpus in policy->cpus.
That will cause a issue that when we call get_cur_freq_on_cpu for a
cpu, it returns zero instead of a correct value.

So we shared acpi_cpufreq_data for all those cpus in policy->cpus.

Signed-off-by: xinhuix.pan <xinhuix.pan@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0136dfc..6c6dc97 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -673,6 +673,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
+	cpumask_copy(policy->cpus, cpumask_of(cpu));
 	per_cpu(acfreq_data, cpu) = data;
 
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
@@ -712,6 +713,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 #endif
 
+	for_each_cpu(i, policy->cpus) {
+		per_cpu(acfreq_data, i) = data;
+	}
+
 	/* capability check */
 	if (perf->state_count <= 1) {
 		pr_debug("No P-States\n");
@@ -843,7 +848,9 @@ err_free_mask:
 	free_cpumask_var(data->freqdomain_cpus);
 err_free:
 	kfree(data);
-	per_cpu(acfreq_data, cpu) = NULL;
+	for_each_cpu(i, policy->cpus) {
+		per_cpu(acfreq_data, i) = NULL;
+	}
 
 	return result;
 }
@@ -851,11 +858,14 @@ err_free:
 static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
+	int i;
 
 	pr_debug("acpi_cpufreq_cpu_exit\n");
 
 	if (data) {
-		per_cpu(acfreq_data, policy->cpu) = NULL;
+		for_each_cpu(i, policy->cpus) {
+			per_cpu(acfreq_data, i) = NULL;
+		}
 		acpi_processor_unregister_performance(data->acpi_data,
 						      policy->cpu);
 		free_cpumask_var(data->freqdomain_cpus);
-- 
1.9.1
