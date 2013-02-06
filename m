From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/5] Thermal: Get max cpu cooling states via cpu cooling table
Date: Wed,  6 Feb 2013 12:30:05 +0800
Message-ID: <1360125006-25018-5-git-send-email-rui.zhang@intel.com>
References: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19511 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000Ab3BFEaT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 23:30:19 -0500
In-Reply-To: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 57bb669..784be30 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -277,26 +277,22 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 {
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 	struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
-	unsigned int cpu;
 	struct cpufreq_frequency_table *table;
-	unsigned long count = 0;
+	unsigned int cpu;
 	int i = 0;
 
 	cpu = cpumask_any(maskPtr);
-	table = cpufreq_frequency_get_table(cpu);
-	if (!table) {
-		*state = 0;
-		return 0;
-	}
+	table = get_cpu_cooling_table(cpu);
+	if (IS_ERR(table))
+		return -EINVAL;
 
-	for (i = 0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-		count++;
-	}
+	while (table[i].frequency != CPUFREQ_TABLE_END)
+		i++;
+
+	kfree(table);
 
-	if (count > 0) {
-		*state = --count;
+	if (i > 0) {
+		*state = --i;
 		return 0;
 	}
 
-- 
1.7.9.5

