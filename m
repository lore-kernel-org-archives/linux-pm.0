From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 25/26] cpu_cooling: Use cpufreq_dev->freq_table for finding level/freq
Date: Fri, 28 Nov 2014 15:14:19 +0530
Message-ID: <8c0412592bfd5524e638252a42edaf08f81f0976.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:61415 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaK1JqM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:46:12 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so6377510pdb.36
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:46:12 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

get_property() was an over complicated beast with BUGs. It used to believe that
cpufreq table is present in ascending or descending order, which might not
always be true.

Previous patch has created another freq table in descending order for us and we
better use it now. With that get_property() simply goes away and another helper
get_level() comes in.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 96 +++++++------------------------------------
 1 file changed, 14 insertions(+), 82 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 9a4a323..db4c001 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -80,85 +80,27 @@ static struct cpufreq_cooling_device *notify_device;
 
 /* Below code defines functions to be used for cpufreq as cooling device */
 
-enum cpufreq_cooling_property {
-	GET_LEVEL,
-	GET_FREQ,
-};
-
 /**
- * get_property - fetch a property of interest for a given cpu.
+ * get_level: Find the level for a particular frequency
  * @cpufreq_dev: cpufreq_dev for which the property is required
- * @input: query parameter
- * @output: query return
- * @property: type of query (frequency, level)
- *
- * This is the common function to
- * 1. translate frequency to cooling state
- * 2. translate cooling state to frequency
+ * @freq: Frequency
  *
- * Note that the code may be not in good shape
- * but it is written in this way in order to:
- * a) reduce duplicate code as most of the code can be shared.
- * b) make sure the logic is consistent when translating between
- *    cooling states and frequencies.
- *
- * Return: 0 on success, -EINVAL when invalid parameters are passed.
+ * Returns: level on success, THERMAL_CSTATE_INVALID on error.
  */
-static int get_property(struct cpufreq_cooling_device *cpufreq_dev,
-			unsigned long input, unsigned int *output,
-			enum cpufreq_cooling_property property)
+static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
+			       unsigned int freq)
 {
-	int i;
-	unsigned long level = 0;
-	unsigned int freq = CPUFREQ_ENTRY_INVALID;
-	int descend = -1;
-	struct cpufreq_frequency_table *pos, *table;
-
-	if (!output)
-		return -EINVAL;
+	unsigned long level;
 
-	table = cpufreq_frequency_get_table(cpumask_first(&cpufreq_dev->allowed_cpus));
-	if (!table)
-		return -EINVAL;
+	for (level = 0; level <= cpufreq_dev->max_level; level++) {
+		if (freq == cpufreq_dev->freq_table[level])
+			return level;
 
-	cpufreq_for_each_valid_entry(pos, table) {
-		/* ignore duplicate entry */
-		if (freq == pos->frequency)
-			continue;
-
-		/* get the frequency order */
-		if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
-			descend = freq > pos->frequency;
-
-		freq = pos->frequency;
+		if (freq > cpufreq_dev->freq_table[level])
+			break;
 	}
 
-	if (property == GET_FREQ)
-		level = descend ? input : (cpufreq_dev->max_level - input);
-
-	i = 0;
-	cpufreq_for_each_valid_entry(pos, table) {
-		/* ignore duplicate entry */
-		if (freq == pos->frequency)
-			continue;
-
-		/* now we have a valid frequency entry */
-		freq = pos->frequency;
-
-		if (property == GET_LEVEL && (unsigned int)input == freq) {
-			/* get level by frequency */
-			*output = descend ? i : (cpufreq_dev->max_level - i);
-			return 0;
-		}
-		if (property == GET_FREQ && level == i) {
-			/* get frequency by level */
-			*output = freq;
-			return 0;
-		}
-		i++;
-	}
-
-	return -EINVAL;
+	return THERMAL_CSTATE_INVALID;
 }
 
 /**
@@ -179,14 +121,8 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 	mutex_lock(&cooling_cpufreq_lock);
 	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, head) {
 		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
-			unsigned int val;
-
 			mutex_unlock(&cooling_cpufreq_lock);
-			if (get_property(cpufreq_dev, (unsigned long)freq, &val,
-					 GET_LEVEL))
-				return THERMAL_CSTATE_INVALID;
-
-			return (unsigned long)val;
+			return get_level(cpufreq_dev, freq);
 		}
 	}
 	mutex_unlock(&cooling_cpufreq_lock);
@@ -289,16 +225,12 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
 	unsigned int clip_freq;
-	int ret = 0;
 
 	/* Check if the old cooling action is same as new cooling action */
 	if (cpufreq_device->cpufreq_state == state)
 		return 0;
 
-	ret = get_property(cpufreq_device, state, &clip_freq, GET_FREQ);
-	if (ret)
-		return ret;
-
+	clip_freq = cpufreq_device->freq_table[state];
 	cpufreq_device->cpufreq_state = state;
 	cpufreq_device->cpufreq_val = clip_freq;
 	notify_device = cpufreq_device;
-- 
2.0.3.693.g996b0fd

