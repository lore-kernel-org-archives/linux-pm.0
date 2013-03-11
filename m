From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3 1/2] Thermal: cpufreq cooling: fix parsing per_cpu cpufreq_frequency_table
Date: Mon, 11 Mar 2013 23:33:12 +0800
Message-ID: <1363015993-8113-2-git-send-email-rui.zhang@intel.com>
References: <1363015993-8113-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5756 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968Ab3CKPdU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 11:33:20 -0400
In-Reply-To: <1363015993-8113-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

cpufreq cooling uses different frequencies as different cooling states.

But the per_cpu cpufreq_frequency_table may contain duplicate,
invalid entries, and it may be in either ascending or descending order.
And currently, code for parsing the per_cpu cpufreq_frequency_table
is used in several places and inconsistent.

Now introduce new code to
1. get the maximum cooling states
2. translate cooling state to cpu frequency
3. translate cpu frequency to cooling state
in one place,
with the correct logic of handling per_cpu cpufreq_frequency_table.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |  143 +++++++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 50 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 8dc44cb..9e208d3 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -108,54 +108,109 @@ static int is_cpufreq_valid(int cpu)
 	return !cpufreq_get_policy(&policy, cpu);
 }
 
-/**
- * get_cpu_frequency - get the absolute value of frequency from level.
- * @cpu: cpu for which frequency is fetched.
- * @level: level of frequency, equals cooling state of cpu cooling device
- *	e.g level=0 --> 1st MAX FREQ, level=1 ---> 2nd MAX FREQ, .... etc
- */
-static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
+enum cpufreq_cooling_property {
+	GET_LEVEL,
+	GET_FREQ,
+	GET_MAXL,
+};
+
+/*
+ * this is the common function to
+ * 1. get maximum cpu cooling states
+ * 2. translate frequency to cooling state
+ * 3. translate cooling state to frequency
+ * Note that the code may be not in good shape
+ * but it is written in this way in order to:
+ * a) reduce duplicate code as most of the code can be shared.
+ * b) make sure the logic is consistent when translating between
+ *    cooling states and frequencies.
+*/
+static int get_property(unsigned int cpu, unsigned long input,
+	unsigned int* output, enum cpufreq_cooling_property property)
 {
-	int ret = 0, i = 0;
-	unsigned long level_index;
-	bool descend = false;
+	int i, j;
+	unsigned long max_level = 0, level;
+	unsigned int freq = CPUFREQ_ENTRY_INVALID;
+	int descend = -1;
 	struct cpufreq_frequency_table *table =
 					cpufreq_frequency_get_table(cpu);
+	
+	if (!output)
+		return -EINVAL;
+
 	if (!table)
-		return ret;
+		return -EINVAL;
 
-	while (table[i].frequency != CPUFREQ_TABLE_END) {
+	
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		/* ignore invalid entries */
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
 
-		/*check if table in ascending or descending order*/
-		if ((table[i + 1].frequency != CPUFREQ_TABLE_END) &&
-			(table[i + 1].frequency < table[i].frequency)
-			&& !descend) {
-			descend = true;
-		}
+		/* ignore duplicate entry */
+		if (freq == table[i].frequency)
+			continue;
+
+		/* get the frequency order */
+		if (freq != CPUFREQ_ENTRY_INVALID && descend != -1)
+			descend = !!(freq > table[i].frequency);
 
-		/*return if level matched and table in descending order*/
-		if (descend && i == level)
-			return table[i].frequency;
-		i++;
+		freq = table[i].frequency;
+		max_level++;
 	}
-	i--;
 
-	if (level > i || descend)
-		return ret;
-	level_index = i - level;
+	/* get max level */
+	if (property == GET_MAXL) {
+		*output = (unsigned int)max_level;
+		return 0;
+	}
 
-	/*Scan the table in reverse order and match the level*/
-	while (i >= 0) {
+	if (property == GET_FREQ)
+		level = descend ? input : (max_level - input -1);
+
+
+	for (i = 0, j = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		/* ignore invalid entry */
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
-		/*return if level matched*/
-		if (i == level_index)
-			return table[i].frequency;
-		i--;
+
+		/* ignore duplicate entry */
+		if (freq == table[i].frequency)
+			continue;
+
+		/* now we have a valid frequency entry */
+		freq = table[i].frequency;
+
+		if (property == GET_LEVEL && (unsigned int)input == freq) {
+			/* get level by frequency */
+			*output = descend ? j : (max_level - j - 1);
+			return 0;
+		}
+		if (property == GET_FREQ && level == j) {
+			/* get frequency by level */
+			*output = freq;
+			return 0;
+		}
+		j++;
 	}
-	return ret;
+	return -EINVAL;
+}
+
+/**
+ * get_cpu_frequency - get the absolute value of frequency from level.
+ * @cpu: cpu for which frequency is fetched.
+ * @level: level of frequency, equals cooling state of cpu cooling device
+ *	e.g level=0 --> 1st MAX FREQ, level=1 ---> 2nd MAX FREQ, .... etc
+ */
+static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
+{
+	int ret = 0;
+	unsigned int freq;
+
+	ret = get_property(cpu, level, &freq, GET_FREQ);
+	if (ret)
+		return 0;
+	return freq;
 }
 
 /**
@@ -237,29 +292,17 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 	struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
 	unsigned int cpu;
-	struct cpufreq_frequency_table *table;
 	unsigned long count = 0;
-	int i = 0;
+	int ret;
 
 	cpu = cpumask_any(maskPtr);
-	table = cpufreq_frequency_get_table(cpu);
-	if (!table) {
-		*state = 0;
-		return 0;
-	}
 
-	for (i = 0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-		count++;
-	}
+	ret = get_property(cpu, 0, (unsigned int *)&count, GET_MAXL);
 
-	if (count > 0) {
-		*state = --count;
-		return 0;
-	}
+	if (count > 0)
+		*state = count;
 
-	return -EINVAL;
+	return ret;
 }
 
 /**
-- 
1.7.9.5

