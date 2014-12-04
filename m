From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 23/26] thermal: cpu_cooling: Pass 'cpufreq_dev' to get_property()
Date: Thu,  4 Dec 2014 09:42:05 +0530
Message-ID: <97446fa591216a1c23f732d48294f550db8c0972.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:63582 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbaLDEOP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:14:15 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so16731268pde.5
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:14:14 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

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
 drivers/thermal/cpu_cooling.c | 50 +++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 32ff6dc..7687922 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -118,7 +118,7 @@ enum cpufreq_cooling_property {
 
 /**
  * get_property - fetch a property of interest for a given cpu.
- * @cpu: cpu for which the property is required
+ * @cpufreq_dev: cpufreq_dev for which the property is required
  * @input: query parameter
  * @output: query return
  * @property: type of query (frequency, level)
@@ -135,20 +135,20 @@ enum cpufreq_cooling_property {
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
 
@@ -162,18 +162,10 @@ static int get_property(unsigned int cpu, unsigned long input,
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
@@ -186,7 +178,7 @@ static int get_property(unsigned int cpu, unsigned long input,
 
 		if (property == GET_LEVEL && (unsigned int)input == freq) {
 			/* get level by frequency */
-			*output = descend ? i : (max_level - i);
+			*output = descend ? i : (cpufreq_dev->max_level - i);
 			return 0;
 		}
 		if (property == GET_FREQ && level == i) {
@@ -213,12 +205,25 @@ static int get_property(unsigned int cpu, unsigned long input,
  */
 unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 {
-	unsigned int val;
+	struct cpufreq_cooling_device *cpufreq_dev;
 
-	if (get_property(cpu, (unsigned long)freq, &val, GET_LEVEL))
-		return THERMAL_CSTATE_INVALID;
+	mutex_lock(&cooling_cpufreq_lock);
+	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
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
 
@@ -323,7 +328,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	if (cpufreq_device->cpufreq_state == state)
 		return 0;
 
-	ret = get_property(cpu, state, &clip_freq, GET_FREQ);
+	ret = get_property(cpufreq_device, state, &clip_freq, GET_FREQ);
 	if (ret)
 		return ret;
 
@@ -381,8 +386,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
 
-	ret = get_property(cpumask_any(clip_cpus), 0, &cpufreq_dev->cpufreq_val,
-			   GET_FREQ);
+	ret = get_property(cpufreq_dev, 0, &cpufreq_dev->cpufreq_val, GET_FREQ);
 	if (ret) {
 		pr_err("%s: Failed to get frequency: %d", __func__, ret);
 		cool_dev = ERR_PTR(ret);
-- 
2.0.3.693.g996b0fd

