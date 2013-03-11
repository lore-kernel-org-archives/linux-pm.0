From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3 2/2] Thermal: exynos: fix cooling state translation
Date: Mon, 11 Mar 2013 23:33:13 +0800
Message-ID: <1363015993-8113-3-git-send-email-rui.zhang@intel.com>
References: <1363015993-8113-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5756 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab3CKPdW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 11:33:22 -0400
In-Reply-To: <1363015993-8113-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c    |   11 +++++++++++
 drivers/thermal/exynos_thermal.c |   24 ++----------------------
 include/linux/cpu_cooling.h      |    7 +++++++
 include/linux/thermal.h          |    5 ++++-
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 9e208d3..e03891b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -196,6 +196,17 @@ static int get_property(unsigned int cpu, unsigned long input,
 	return -EINVAL;
 }
 
+unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
+{
+	unsigned int val;
+
+	if (get_property(cpu, (unsigned long)freq, &val, GET_LEVEL))
+		return THERMAL_CSTATE_INVALID;
+	return (unsigned long)val;
+}
+
+EXPORT_SYMBOL(cpufreq_cooling_get_level);
+
 /**
  * get_cpu_frequency - get the absolute value of frequency from level.
  * @cpu: cpu for which frequency is fetched.
diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 46568c0..5412578 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -242,26 +242,6 @@ static int exynos_get_crit_temp(struct thermal_zone_device *thermal,
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
@@ -288,8 +268,8 @@ static int exynos_bind(struct thermal_zone_device *thermal,
 	/* Bind the thermal zone to the cpufreq cooling device */
 	for (i = 0; i < tab_size; i++) {
 		clip_data = (struct freq_clip_table *)&(tab_ptr[i]);
-		level = exynos_get_frequency_level(0, clip_data->freq_clip_max);
-		if (level < 0)
+		level = cpufreq_cooling_get_level(0, clip_data->freq_clip_max);
+		if (level == THERMAL_CSTATE_INVALID)
 			return 0;
 		switch (GET_ZONE(i)) {
 		case MONITOR_ZONE:
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 40b4ef5..bc479b1 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -42,6 +42,8 @@ struct thermal_cooling_device *cpufreq_cooling_register(
  * @cdev: thermal cooling device pointer.
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
+
+unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int);
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *cpufreq_cooling_register(
 	const struct cpumask *clip_cpus)
@@ -53,6 +55,11 @@ static inline void cpufreq_cooling_unregister(
 {
 	return;
 }
+static inline unsigned long cpufreq_cooling_get_level(unsigned int,
+						 unsigned int)
+{
+	return THERMAL_CSTATE_INVALID;
+}
 #endif	/* CONFIG_CPU_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f0bd7f9..5a3b428 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -33,8 +33,11 @@
 #define THERMAL_MAX_TRIPS	12
 #define THERMAL_NAME_LENGTH	20
 
+/* invalid cooling state */
+#define THERMAL_CSTATE_INVALID -1UL
+
 /* No upper/lower limit requirement */
-#define THERMAL_NO_LIMIT	-1UL
+#define THERMAL_NO_LIMIT	THERMAL_CSTATE_INVALID
 
 /* Unit conversion macros */
 #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
-- 
1.7.9.5

