From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.0+] cpufreq: Use struct kobj_attribute instead of struct global_attr
Date: Thu,  7 Mar 2019 16:53:33 +0530
Message-ID: <4f8ea1c92397b7d88aa8e0fe825b3e14b70ef85c.1551957797.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "4 . 0+" <stable@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

commit 625c85a62cb7d3c79f6e16de3cfa972033658250 upstream.

The cpufreq_global_kobject is created using kobject_create_and_add()
helper, which assigns the kobj_type as dynamic_kobj_ktype and show/store
routines are set to kobj_attr_show() and kobj_attr_store().

These routines pass struct kobj_attribute as an argument to the
show/store callbacks. But all the cpufreq files created using the
cpufreq_global_kobject expect the argument to be of type struct
attribute. Things work fine currently as no one accesses the "attr"
argument. We may not see issues even if the argument is used, as struct
kobj_attribute has struct attribute as its first element and so they
will both get same address.

But this is logically incorrect and we should rather use struct
kobj_attribute instead of struct global_attr in the cpufreq core and
drivers and the show/store callbacks should take struct kobj_attribute
as argument instead.

This bug is caught using CFI CLANG builds in android kernel which
catches mismatch in function prototypes for such callbacks.

Cc: 4.0+ <stable@vger.kernel.org> # 4.0+
Reported-by: Donghee Han <dh.han@samsung.com>
Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
This needs to be applied from v4.0 to v4.5 (including both).
---
 drivers/cpufreq/cpufreq.c          |  6 +++---
 drivers/cpufreq/cpufreq_governor.h | 10 +++++-----
 drivers/cpufreq/intel_pstate.c     | 14 +++++++-------
 include/linux/cpufreq.h            | 12 ++----------
 4 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8ae655c364f4..6c33b355c405 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -407,13 +407,13 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_transition_end);
  *                          SYSFS INTERFACE                          *
  *********************************************************************/
 static ssize_t show_boost(struct kobject *kobj,
-				 struct attribute *attr, char *buf)
+			  struct kobj_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
 }
 
-static ssize_t store_boost(struct kobject *kobj, struct attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
+			   const char *buf, size_t count)
 {
 	int ret, enable;
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index cc401d147e72..d4fadeb4c246 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -48,11 +48,11 @@ enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 
 /* Create attributes */
 #define gov_sys_attr_ro(_name)						\
-static struct global_attr _name##_gov_sys =				\
+static struct kobj_attribute _name##_gov_sys =				\
 __ATTR(_name, 0444, show_##_name##_gov_sys, NULL)
 
 #define gov_sys_attr_rw(_name)						\
-static struct global_attr _name##_gov_sys =				\
+static struct kobj_attribute _name##_gov_sys =				\
 __ATTR(_name, 0644, show_##_name##_gov_sys, store_##_name##_gov_sys)
 
 #define gov_pol_attr_ro(_name)						\
@@ -74,7 +74,7 @@ __ATTR(_name, 0644, show_##_name##_gov_pol, store_##_name##_gov_pol)
 /* Create show/store routines */
 #define show_one(_gov, file_name)					\
 static ssize_t show_##file_name##_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, char *buf)		\
+(struct kobject *kobj, struct kobj_attribute *attr, char *buf)		\
 {									\
 	struct _gov##_dbs_tuners *tuners = _gov##_dbs_cdata.gdbs_data->tuners; \
 	return sprintf(buf, "%u\n", tuners->file_name);			\
@@ -90,7 +90,7 @@ static ssize_t show_##file_name##_gov_pol				\
 
 #define store_one(_gov, file_name)					\
 static ssize_t store_##file_name##_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, const char *buf, size_t count) \
+(struct kobject *kobj, struct kobj_attribute *attr, const char *buf, size_t count) \
 {									\
 	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
 	return store_##file_name(dbs_data, buf, count);			\
@@ -251,7 +251,7 @@ static inline int delay_for_sampling_rate(unsigned int sampling_rate)
 
 #define declare_show_sampling_rate_min(_gov)				\
 static ssize_t show_sampling_rate_min_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, char *buf)		\
+(struct kobject *kobj, struct kobj_attribute *attr, char *buf)		\
 {									\
 	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
 	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 872c5772c5d3..cc3936a0cdf0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -337,13 +337,13 @@ static void __init intel_pstate_debug_expose_params(void)
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
-	(struct kobject *kobj, struct attribute *attr, char *buf)	\
+	(struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
 	{								\
 		return sprintf(buf, "%u\n", limits.object);		\
 	}
 
 static ssize_t show_turbo_pct(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total, no_turbo, turbo_pct;
@@ -359,7 +359,7 @@ static ssize_t show_turbo_pct(struct kobject *kobj,
 }
 
 static ssize_t show_num_pstates(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total;
@@ -370,7 +370,7 @@ static ssize_t show_num_pstates(struct kobject *kobj,
 }
 
 static ssize_t show_no_turbo(struct kobject *kobj,
-			     struct attribute *attr, char *buf)
+			     struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -383,7 +383,7 @@ static ssize_t show_no_turbo(struct kobject *kobj,
 	return ret;
 }
 
-static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
+static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 			      const char *buf, size_t count)
 {
 	unsigned int input;
@@ -407,7 +407,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -426,7 +426,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ee4888c1f47..5714d643dd4d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -200,20 +200,12 @@ __ATTR(_name, _perm, show_##_name, NULL)
 static struct freq_attr _name =			\
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
-struct global_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *kobj,
-			struct attribute *attr, char *buf);
-	ssize_t (*store)(struct kobject *a, struct attribute *b,
-			 const char *c, size_t count);
-};
-
 #define define_one_global_ro(_name)		\
-static struct global_attr _name =		\
+static struct kobj_attribute _name =		\
 __ATTR(_name, 0444, show_##_name, NULL)
 
 #define define_one_global_rw(_name)		\
-static struct global_attr _name =		\
+static struct kobj_attribute _name =		\
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
 
-- 
2.21.0.rc0.269.g1a574e7a288b
