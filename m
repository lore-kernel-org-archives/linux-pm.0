From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH] ACPI / CPPC: Add module support for cppc_cpufreq driver
Date: Thu, 14 Apr 2016 20:45:53 -0400
Message-ID: <1460681153-14671-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34098 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbcDOAp7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 20:45:59 -0400
Received: by mail-yw0-f172.google.com with SMTP id d68so121885882ywe.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2016 17:45:59 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Add a function to cleanup at module exit and export
appropriate GPL string to enable moduler support
for the cppc_cpufreq driver.

Reported-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7c0bdfb..8882b8e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -173,4 +173,25 @@ out:
 	return -ENODEV;
 }
 
+static void __exit cppc_cpufreq_exit(void)
+{
+	struct cpudata *cpu;
+	int i;
+
+	cpufreq_unregister_driver(&cppc_cpufreq_driver);
+
+	for_each_possible_cpu(i) {
+		cpu = all_cpu_data[i];
+		free_cpumask_var(cpu->shared_cpu_map);
+		kfree(cpu);
+	}
+
+	kfree(all_cpu_data);
+}
+
+module_exit(cppc_cpufreq_exit);
+MODULE_AUTHOR("Ashwin Chaugule");
+MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
+MODULE_LICENSE("GPL");
+
 late_initcall(cppc_cpufreq_init);
-- 
1.9.1

