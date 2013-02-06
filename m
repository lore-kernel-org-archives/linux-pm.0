From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/5] Thermal: Get cpu frequency via cpu cooling table
Date: Wed,  6 Feb 2013 12:30:04 +0800
Message-ID: <1360125006-25018-4-git-send-email-rui.zhang@intel.com>
References: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19511 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756977Ab3BFEaR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 23:30:17 -0500
In-Reply-To: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |   45 ++++++++---------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 08f12c7..57bb669 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -186,46 +186,17 @@ get_cpu_cooling_table(unsigned int cpu)
  */
 static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 {
-	int ret = 0, i = 0;
-	unsigned long level_index;
-	bool descend = false;
-	struct cpufreq_frequency_table *table =
-					cpufreq_frequency_get_table(cpu);
-	if (!table)
-		return ret;
-
-	while (table[i].frequency != CPUFREQ_TABLE_END) {
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-
-		/*check if table in ascending or descending order*/
-		if ((table[i + 1].frequency != CPUFREQ_TABLE_END) &&
-			(table[i + 1].frequency < table[i].frequency)
-			&& !descend) {
-			descend = true;
-		}
+	struct cpufreq_frequency_table *table;
+	unsigned int freq;
 
-		/*return if level matched and table in descending order*/
-		if (descend && i == level)
-			return table[i].frequency;
-		i++;
-	}
-	i--;
+	table = get_cpu_cooling_table(cpu);
+	if (IS_ERR(table))
+		return -EINVAL;
 
-	if (level > i || descend)
-		return ret;
-	level_index = i - level;
+	freq = table[level].frequency;
 
-	/*Scan the table in reverse order and match the level*/
-	while (i >= 0) {
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-		/*return if level matched*/
-		if (i == level_index)
-			return table[i].frequency;
-		i--;
-	}
-	return ret;
+	kfree(table);
+	return 0;
 }
 
 /**
-- 
1.7.9.5

