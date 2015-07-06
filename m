From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH] acpi-cpufreq.c: fix a memory leak in acpi_cpufreq_cpu_exit
Date: Mon, 06 Jul 2015 14:30:11 +0800
Message-ID: <559A2073.1000301@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1113 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbbGFGcm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Jul 2015 02:32:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>


policy->cpu in acpi_cpufreq_cpu_init/exit is the same cpu in most cases.
However during cpu hotplug,
cpufreq core might nominate a new cpu for policy->cpu.

Thar will cause a memory leak in acpi_cpufreq_cpu_exit.
To avoid this issue, use field *driver_data* to keep the the pointer
of acpi_cpufreq_data.

Add field *cpu* in acpi_cpufreq_data to do some proper cleanup work.

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0136dfc..1f3372a 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -70,6 +70,7 @@ struct acpi_cpufreq_data {
 	unsigned int resume;
 	unsigned int cpu_feature;
 	cpumask_var_t freqdomain_cpus;
+	unsigned int cpu;
 };
 
 static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
@@ -833,6 +834,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 */
 	data->resume = 1;
 
+	data->cpu = cpu;
+	policy->driver_data = data;
+
 	return result;
 
 err_freqfree:
@@ -850,14 +854,15 @@ err_free:
 
 static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
+	struct acpi_cpufreq_data *data = policy->driver_data;
 
 	pr_debug("acpi_cpufreq_cpu_exit\n");
 
 	if (data) {
-		per_cpu(acfreq_data, policy->cpu) = NULL;
+		policy->driver_data = NULL;
+		per_cpu(acfreq_data, data->cpu) = NULL;
 		acpi_processor_unregister_performance(data->acpi_data,
-						      policy->cpu);
+						      data->cpu);
 		free_cpumask_var(data->freqdomain_cpus);
 		kfree(data->freq_table);
 		kfree(data);
-- 
1.9.1
