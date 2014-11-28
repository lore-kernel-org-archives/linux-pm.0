From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 23/26] cpu_cooling: Pass 'cpufreq_dev' to get_property()
Date: Fri, 28 Nov 2014 15:14:17 +0530
Message-ID: <54fc6ebea71dda145d9631330e6760ab845796b9.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:50004 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaK1JqF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:46:05 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so6529131pad.15
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:46:04 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

We already know the value of 'cpufreq_dev->max_level' and so there is no need
calculating that once again. For this, we need to send 'cpufreq_dev' to
get_property().

Make all necessary changes for this change. Because cpufreq_cooling_get_level()
doesn't have access to 'cpufreq_dev', it is updated to iterate over the list of
cpufreq_cooling_devices to get cooling device for the cpu number passed to it.
This also makes it robust to return levels only for the CPU registered via a
cooling device. We don't have to support anything that isn't registered yet.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 4965a55..07414c5 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -86,7 +86,7 @@ enum cpufreq_cooling_property {
 
 /**
  * get_property - fetch a property of interest for a given cpu.
- * @cpu: cpu for which the property is required
+ * @cpufreq_dev: cpufreq_dev for which the property is required
  * @input: query parameter
  * @output: query return
  * @property: type of query (frequency, level)
@@ -103,20 +103,20 @@ enum cpufreq_cooling_property {
  *
  * Return: 0 on success, -EINVAL when invalid parameters are passed.
  */
-static int get_property(unsigned int cpu, unsigned long input,
-			unsigned int *output,
+static int get_property(struct cpufreq_cooling_device *cpufreq_dev,
+			unsigned long input, unsigned int *output,
 			enum cpufreq_cooling_property property)
 {
 	int i;
-	unsigned long max_level = 0, level = 0;
+	unsigned long level = 0;
 	unsigned int freq = CPUFREQ_ENTRY_INVALID;
 	int descend = -1;
-	struct cpufreq_frequency_table *pos, *table =
-					cpufreq_frequency_get_table(cpu);
+	struct cpufreq_frequency_table *pos, *table;
 
 	if (!output)
 		return -EINVAL;
 
+	table = cpufreq_frequency_get_table(cpumask_first(&cpufreq_dev->allowed_cpus));
 	if (!table)
 		return -EINVAL;
 
@@ -130,18 +130,10 @@ static int get_property(unsigned int cpu, unsigned long input,
 			descend = freq > pos->frequency;
 
 		freq = pos->frequency;
-		max_level++;
 	}
 
-	/* No valid cpu frequency entry */
-	if (max_level == 0)
-		return -EINVAL;
-
-	/* max_level is an index, not a counter */
-	max_level--;
-
 	if (property == GET_FREQ)
-		level = descend ? input : (max_level - input);
+		level = descend ? input : (cpufreq_dev->max_level - input);
 
 	i = 0;
 	cpufreq_for_each_valid_entry(pos, table) {
@@ -154,7 +146,7 @@ static int get_property(unsigned int cpu, unsigned long input,
 
 		if (property == GET_LEVEL && (unsigned int)input == freq) {
 			/* get level by frequency */
-			*output = descend ? i : (max_level - i);
+			*output = descend ? i : (cpufreq_dev->max_level - i);
 			return 0;
 		}
 		if (property == GET_FREQ && level == i) {
@@ -181,12 +173,25 @@ static int get_property(unsigned int cpu, unsigned long input,
  */
 unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 {
-	unsigned int val;
+	struct cpufreq_cooling_device *cpufreq_dev;
 
-	if (get_property(cpu, (unsigned long)freq, &val, GET_LEVEL))
-		return THERMAL_CSTATE_INVALID;
+	mutex_lock(&cooling_cpufreq_lock);
+	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, head) {
+		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
+			unsigned int val;
+
+			mutex_unlock(&cooling_cpufreq_lock);
+			if (get_property(cpufreq_dev, (unsigned long)freq, &val,
+					 GET_LEVEL))
+				return THERMAL_CSTATE_INVALID;
+
+			return (unsigned long)val;
+		}
+	}
+	mutex_unlock(&cooling_cpufreq_lock);
 
-	return (unsigned long)val;
+	pr_err("%s: cpu:%d not part of any cooling device\n", __func__, cpu);
+	return THERMAL_CSTATE_INVALID;
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
 
@@ -289,7 +294,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	if (cpufreq_device->cpufreq_state == state)
 		return 0;
 
-	ret = get_property(cpu, state, &clip_freq, GET_FREQ);
+	ret = get_property(cpufreq_device, state, &clip_freq, GET_FREQ);
 	if (ret)
 		return ret;
 
-- 
2.0.3.693.g996b0fd

