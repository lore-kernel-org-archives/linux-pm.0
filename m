From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/7] cpufreq: governor: Drop unused macros for creating governor tunable attributes
Date: Wed,  3 Feb 2016 19:32:19 +0530
Message-ID: <5c470e56bd2dbaec62624fb70e321c1d3f084ad2.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

"The previous commit introduced a new set of macros for creating sysfs
attributes that represent governor tunables and the old macros used for
this purpose are not needed any more, so drop them."

[ Rafael: Written changelog ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.h | 68 --------------------------------------
 1 file changed, 68 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 45a6ac1ecfb0..ed328a39c4ac 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -40,74 +40,6 @@
 /* Ondemand Sampling types */
 enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
-/*
- * Macro for creating governors sysfs routines
- *
- * - gov_sys: One governor instance per whole system
- * - gov_pol: One governor instance per policy
- */
-
-/* Create attributes */
-#define gov_sys_attr_ro(_name)						\
-static struct global_attr _name##_gov_sys =				\
-__ATTR(_name, 0444, show_##_name##_gov_sys, NULL)
-
-#define gov_sys_attr_rw(_name)						\
-static struct global_attr _name##_gov_sys =				\
-__ATTR(_name, 0644, show_##_name##_gov_sys, store_##_name##_gov_sys)
-
-#define gov_pol_attr_ro(_name)						\
-static struct freq_attr _name##_gov_pol =				\
-__ATTR(_name, 0444, show_##_name##_gov_pol, NULL)
-
-#define gov_pol_attr_rw(_name)						\
-static struct freq_attr _name##_gov_pol =				\
-__ATTR(_name, 0644, show_##_name##_gov_pol, store_##_name##_gov_pol)
-
-#define gov_sys_pol_attr_rw(_name)					\
-	gov_sys_attr_rw(_name);						\
-	gov_pol_attr_rw(_name)
-
-#define gov_sys_pol_attr_ro(_name)					\
-	gov_sys_attr_ro(_name);						\
-	gov_pol_attr_ro(_name)
-
-/* Create show/store routines */
-#define show_one(_gov, file_name)					\
-static ssize_t show_##file_name##_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, char *buf)		\
-{									\
-	struct _gov##_dbs_tuners *tuners = _gov##_dbs_cdata.gdbs_data->tuners; \
-	return sprintf(buf, "%u\n", tuners->file_name);			\
-}									\
-									\
-static ssize_t show_##file_name##_gov_pol				\
-(struct cpufreq_policy *policy, char *buf)				\
-{									\
-	struct dbs_data *dbs_data = policy->governor_data;		\
-	struct _gov##_dbs_tuners *tuners = dbs_data->tuners;		\
-	return sprintf(buf, "%u\n", tuners->file_name);			\
-}
-
-#define store_one(_gov, file_name)					\
-static ssize_t store_##file_name##_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, const char *buf, size_t count) \
-{									\
-	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
-	return store_##file_name(dbs_data, buf, count);			\
-}									\
-									\
-static ssize_t store_##file_name##_gov_pol				\
-(struct cpufreq_policy *policy, const char *buf, size_t count)		\
-{									\
-	struct dbs_data *dbs_data = policy->governor_data;		\
-	return store_##file_name(dbs_data, buf, count);			\
-}
-
-#define show_store_one(_gov, file_name)					\
-show_one(_gov, file_name);						\
-store_one(_gov, file_name)
-
 /* Governor's specific attributes */
 struct dbs_data;
 struct governor_attr {
-- 
2.7.0.79.gdc08a19
