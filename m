From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 23/34] Thermal: fix bug of counting cpu frequencies.
Date: Sun,  2 Dec 2012 22:44:57 +0800
Message-ID: <1354459508-3707-23-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab2LBOpp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:45 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "hongbo.zhang" <hongbo.zhang@linaro.com>, Zhang Rui <rui.zhang@intel.com>

From: "hongbo.zhang" <hongbo.zhang@linaro.com>

In the while loop for counting cpu frequencies, if table[i].frequency equals
CPUFREQ_ENTRY_INVALID, index i won't be increased, so this leads to an endless
loop, what's more the index i cannot be referred as cpu frequencies number if
there is CPUFREQ_ENTRY_INVALID case.

Signed-off-by: hongbo.zhang <hongbo.zhang@linaro.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index b6b4c2a..bfd62b7 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -245,6 +245,7 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 	struct cpumask *maskPtr;
 	unsigned int cpu;
 	struct cpufreq_frequency_table *table;
+	unsigned long count = 0;
 
 	mutex_lock(&cooling_cpufreq_lock);
 	list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
@@ -263,13 +264,14 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 		goto return_get_max_state;
 	}
 
-	while (table[i].frequency != CPUFREQ_TABLE_END) {
+	for (i = 0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
-		i++;
+		count++;
 	}
-	if (i > 0) {
-		*state = --i;
+
+	if (count > 0) {
+		*state = --count;
 		ret = 0;
 	}
 
-- 
1.7.7.6

