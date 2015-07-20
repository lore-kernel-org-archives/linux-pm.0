From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: [PATCH] cpufreq: ia64: Fix a memory leak in acpi_cpufreq_cpu_exit
Date: Mon, 20 Jul 2015 14:24:36 +0800
Message-ID: <55AC9424.1070304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53787 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbbGTG11 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jul 2015 02:27:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

From: Pan Xinhui <xinhuix.pan@intel.com>

freq_table should be alloced in ->init and freed in ->exit. However it
does not be freed. Fix this memory leak in acpi_cpufreq_cpu_exit.

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 27cef0c..e02bd15 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -334,6 +334,7 @@ acpi_cpufreq_cpu_exit (
 		acpi_io_data[policy->cpu] = NULL;
 		acpi_processor_unregister_performance(&data->acpi_data,
 		                                      policy->cpu);
+		kfree(policy->freq_table);
 		kfree(data);
 	}
 
-- 
1.9.1
