From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH] cpufreq: ia64: remove redundant freq_table of acpi_cpufreq_data
Date: Mon, 20 Jul 2015 14:22:46 +0800
Message-ID: <55AC93B6.7030305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5461 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416AbbGTGZa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jul 2015 02:25:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

From: Pan Xinhui <xinhuix.pan@intel.com>

freq_table is now stored as policy->freq_table, so drop the redundant
freq_table from struct cpufreq_acpi_io.

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index c30aaa6..e02bd15 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -29,7 +29,6 @@ MODULE_LICENSE("GPL");
 
 struct cpufreq_acpi_io {
 	struct acpi_processor_performance	acpi_data;
-	struct cpufreq_frequency_table		*freq_table;
 	unsigned int				resume;
 };
 
@@ -221,6 +220,7 @@ acpi_cpufreq_cpu_init (
 	unsigned int		cpu = policy->cpu;
 	struct cpufreq_acpi_io	*data;
 	unsigned int		result = 0;
+	struct cpufreq_frequency_table *freq_table;
 
 	pr_debug("acpi_cpufreq_cpu_init\n");
 
@@ -254,10 +254,10 @@ acpi_cpufreq_cpu_init (
 	}
 
 	/* alloc freq_table */
-	data->freq_table = kzalloc(sizeof(*data->freq_table) *
+	freq_table = kzalloc(sizeof(*freq_table) *
 	                           (data->acpi_data.state_count + 1),
 	                           GFP_KERNEL);
-	if (!data->freq_table) {
+	if (!freq_table) {
 		result = -ENOMEM;
 		goto err_unreg;
 	}
@@ -276,14 +276,14 @@ acpi_cpufreq_cpu_init (
 	for (i = 0; i <= data->acpi_data.state_count; i++)
 	{
 		if (i < data->acpi_data.state_count) {
-			data->freq_table[i].frequency =
+			freq_table[i].frequency =
 			      data->acpi_data.states[i].core_frequency * 1000;
 		} else {
-			data->freq_table[i].frequency = CPUFREQ_TABLE_END;
+			freq_table[i].frequency = CPUFREQ_TABLE_END;
 		}
 	}
 
-	result = cpufreq_table_validate_and_show(policy, data->freq_table);
+	result = cpufreq_table_validate_and_show(policy, freq_table);
 	if (result) {
 		goto err_freqfree;
 	}
@@ -311,7 +311,7 @@ acpi_cpufreq_cpu_init (
 	return (result);
 
  err_freqfree:
-	kfree(data->freq_table);
+	kfree(freq_table);
  err_unreg:
 	acpi_processor_unregister_performance(&data->acpi_data, cpu);
  err_free:
-- 
1.9.1
