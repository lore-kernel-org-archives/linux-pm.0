From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH] acpi-cpufreq: Fix an acpi perf unregister issue
Date: Fri, 10 Jul 2015 13:51:38 +0800
Message-ID: <559F5D6A.5090305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18434 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbGJFyO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jul 2015 01:54:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>


As policy->cpu may not be same in acpi_cpufreq_cpu_init and
acpi_cpufreq_cpu_exit. There is a risk that we use different *cpu* to
un/register acpi performance. So acpi_processor_unregister_performance
may not be able to do the cleanup work. That causes a memory leak. And
if there will be another acpi_processor_register_performance call, it
may also fail thanks to the internal check of pr->performace.

So we add a field *perf_cpu* to fix this issue.

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 314a19e..8cad583 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -69,6 +69,7 @@ struct acpi_cpufreq_data {
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int resume;
 	unsigned int cpu_feature;
+	unsigned int acpi_perf_cpu;
 	cpumask_var_t freqdomain_cpus;
 };
 
@@ -677,6 +678,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
+	data->acpi_perf_cpu = cpu;
 	policy->driver_data = data;
 
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
@@ -861,7 +863,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	if (data) {
 		policy->driver_data = NULL;
 		acpi_processor_unregister_performance(data->acpi_data,
-						      policy->cpu);
+						      data->acpi_perf_cpu);
 		free_cpumask_var(data->freqdomain_cpus);
 		kfree(data->freq_table);
 		kfree(data);
-- 
1.9.1
