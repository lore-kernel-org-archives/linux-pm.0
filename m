From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 3/6 v3] cpufreq: tolerate inexact values when collecting stats
Date: Tue,  6 Nov 2012 14:18:05 -0600
Message-ID: <1352233089-22586-4-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352233089-22586-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352233089-22586-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, mark.langsdorf@calxeda.com
List-Id: linux-pm@vger.kernel.org

Allow frequency values to vary by +/-5000 Hz when collecting stats.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
Changes from v2:
	None
Changes from v1:
        Implemented a simple round-up algorithm instead of the over/under
method that could cause errors on Intel processors with boost mode.

 drivers/cpufreq/cpufreq_stats.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 3998316..4e2ea7e 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -158,9 +158,11 @@ static struct attribute_group stats_attr_group = {
 static int freq_table_get_index(struct cpufreq_stats *stat, unsigned int freq)
 {
 	int index;
-	for (index = 0; index < stat->max_state; index++)
-		if (stat->freq_table[index] == freq)
+	for (index = 0; index < stat->max_state; index++) {
+		if ((stat->freq_table[index] < (freq + 5000)) &&
+		    (stat->freq_table[index] > (freq - 5000)))
 			return index;
+	}
 	return -1;
 }
 
@@ -251,6 +253,8 @@ static int cpufreq_stats_create_table(struct cpufreq_policy *policy,
 	spin_lock(&cpufreq_stats_lock);
 	stat->last_time = get_jiffies_64();
 	stat->last_index = freq_table_get_index(stat, policy->cur);
+	if (stat->last_index > stat->max_state)
+		stat->last_index = stat->max_state - 1;
 	spin_unlock(&cpufreq_stats_lock);
 	cpufreq_cpu_put(data);
 	return 0;
-- 
1.7.11.7
