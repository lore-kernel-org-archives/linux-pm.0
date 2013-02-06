From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/5] Thermal: Get cooling state via cpu cooling table
Date: Wed,  6 Feb 2013 12:30:06 +0800
Message-ID: <1360125006-25018-6-git-send-email-rui.zhang@intel.com>
References: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19511 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000Ab3BFEaV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 23:30:21 -0500
In-Reply-To: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c    |   22 ++++++++++++++++++++++
 drivers/thermal/exynos_thermal.c |   24 ++----------------------
 include/linux/cpu_cooling.h      |    6 ++++++
 include/linux/thermal.h          |    4 +++-
 4 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 784be30..9dbcbc1 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -178,6 +178,28 @@ get_cpu_cooling_table(unsigned int cpu)
 	return new;
 }
 
+unsigned long cpufreq_cooling_get_level(unsigned int cpu,
+			unsigned int freq)
+{
+	struct cpufreq_frequency_table *table;
+	int i;
+	unsigned long level = THERMAL_COOLING_STATE_INVALID;
+
+	table = get_cpu_cooling_table(cpu);
+	if (IS_ERR(table))
+		return -EINVAL;
+
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++)
+		if (freq == table[i].frequency) {
+			level = (unsigned long)i;
+			break;
+		}
+
+	kfree(table);
+	return level;
+}
+EXPORT_SYMBOL(cpufreq_cooling_get_level);
+
 /**
  * get_cpu_frequency - get the absolute value of frequency from level.
  * @cpu: cpu for which frequency is fetched.
diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index cd71e24..2fea7a9 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -239,26 +239,6 @@ static int exynos_get_crit_temp(struct thermal_zone_device *thermal,
 	return ret;
 }
 
-static int exynos_get_frequency_level(unsigned int cpu, unsigned int freq)
-{
-	int i = 0, ret = -EINVAL;
-	struct cpufreq_frequency_table *table = NULL;
-#ifdef CONFIG_CPU_FREQ
-	table = cpufreq_frequency_get_table(cpu);
-#endif
-	if (!table)
-		return ret;
-
-	while (table[i].frequency != CPUFREQ_TABLE_END) {
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-		if (table[i].frequency == freq)
-			return i;
-		i++;
-	}
-	return ret;
-}
-
 /* Bind callback functions for thermal zone */
 static int exynos_bind(struct thermal_zone_device *thermal,
 			struct thermal_cooling_device *cdev)
@@ -285,8 +265,8 @@ static int exynos_bind(struct thermal_zone_device *thermal,
 	/* Bind the thermal zone to the cpufreq cooling device */
 	for (i = 0; i < tab_size; i++) {
 		clip_data = (struct freq_clip_table *)&(tab_ptr[i]);
-		level = exynos_get_frequency_level(0, clip_data->freq_clip_max);
-		if (level < 0)
+		level = cpufreq_cooling_get_level(0, clip_data->freq_clip_max);
+		if (level == THERMAL_COOLING_STATE_INVALID)
 			return 0;
 		switch (GET_ZONE(i)) {
 		case MONITOR_ZONE:
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 40b4ef5..0a4a05d 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -42,6 +42,7 @@ struct thermal_cooling_device *cpufreq_cooling_register(
  * @cdev: thermal cooling device pointer.
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
+unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int);
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *cpufreq_cooling_register(
 	const struct cpumask *clip_cpus)
@@ -53,6 +54,11 @@ static inline void cpufreq_cooling_unregister(
 {
 	return;
 }
+static inline unsigned long cpufreq_cooling_get_level(
+		unsigned int cpu, unsigned int freq)
+{
+	return THERMAL_COOLING_STATE_INVALID;
+}
 #endif	/* CONFIG_CPU_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f0bd7f9..03bdaa4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -33,8 +33,10 @@
 #define THERMAL_MAX_TRIPS	12
 #define THERMAL_NAME_LENGTH	20
 
+#define THERMAL_COOLING_STATE_INVALID -1UL
+
 /* No upper/lower limit requirement */
-#define THERMAL_NO_LIMIT	-1UL
+#define THERMAL_NO_LIMIT THERMAL_COOLING_STATE_INVALID
 
 /* Unit conversion macros */
 #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
-- 
1.7.9.5

