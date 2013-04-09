From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH] thermal: cpu_cooling: fix handling of invalid frequency table entries
Date: Tue,  9 Apr 2013 14:56:56 -0700
Message-ID: <1365544616-10003-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f201.google.com ([209.85.223.201]:45089 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab3DIV5B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Apr 2013 17:57:01 -0400
Received: by mail-ie0-f201.google.com with SMTP id a11so1887407iee.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2013 14:57:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>

get_cpu_frequency() goes into an infinite loop if any of the entries
in the CPU frequency table are invalid.  This patch fixes that case
and, with a separate counter for frequency levels, ensures that the
n-th valid frequency level is returned.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/thermal/cpu_cooling.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 836828e..e6db441 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -124,14 +124,14 @@ static int is_cpufreq_valid(int cpu)
 static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 {
 	int ret = 0, i = 0;
-	unsigned long level_index;
+	unsigned long level_index = 0;
 	bool descend = false;
 	struct cpufreq_frequency_table *table =
 					cpufreq_frequency_get_table(cpu);
 	if (!table)
 		return ret;
 
-	while (table[i].frequency != CPUFREQ_TABLE_END) {
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
 
@@ -143,24 +143,25 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 		}
 
 		/*return if level matched and table in descending order*/
-		if (descend && i == level)
+		if (descend && level_index == level)
 			return table[i].frequency;
-		i++;
+		level_index++;
 	}
 	i--;
+	level_index--;
 
-	if (level > i || descend)
+	if (level > level_index || descend)
 		return ret;
-	level_index = i - level;
+	level = level_index - level;
 
 	/*Scan the table in reverse order and match the level*/
-	while (i >= 0) {
+	for (; i >= 0; i--) {
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
 		/*return if level matched*/
-		if (i == level_index)
+		if (level_index == level)
 			return table[i].frequency;
-		i--;
+		level_index--;
 	}
 	return ret;
 }
-- 
1.8.1.3

