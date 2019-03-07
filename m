From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4.10] cpufreq: Use struct kobj_attribute instead of struct global_attr
Date: Thu,  7 Mar 2019 16:52:20 +0530
Message-ID: <a77cd87e1c27367cee2cbdf10d775ad59af9e554.1551957712.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "4 . 10" <stable@vger.kernel.org>
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

Cc: 4.10 <stable@vger.kernel.org> # 4.10
Reported-by: Donghee Han <dh.han@samsung.com>
Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
This needs to be applied to v4.10 only.
---
 drivers/cpufreq/cpufreq.c      |  6 +++---
 drivers/cpufreq/intel_pstate.c | 14 +++++++-------
 include/linux/cpufreq.h        | 12 ++----------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cc475eff90b3..984ad3857622 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -528,13 +528,13 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
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
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 50bd6d987fc3..8685a4caab2c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1043,13 +1043,13 @@ static void __init intel_pstate_debug_expose_params(void)
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
-	(struct kobject *kobj, struct attribute *attr, char *buf)	\
+	(struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
 	{								\
 		return sprintf(buf, "%u\n", limits->object);		\
 	}
 
 static ssize_t show_turbo_pct(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total, no_turbo, turbo_pct;
@@ -1065,7 +1065,7 @@ static ssize_t show_turbo_pct(struct kobject *kobj,
 }
 
 static ssize_t show_num_pstates(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total;
@@ -1076,7 +1076,7 @@ static ssize_t show_num_pstates(struct kobject *kobj,
 }
 
 static ssize_t show_no_turbo(struct kobject *kobj,
-			     struct attribute *attr, char *buf)
+			     struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -1089,7 +1089,7 @@ static ssize_t show_no_turbo(struct kobject *kobj,
 	return ret;
 }
 
-static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
+static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 			      const char *buf, size_t count)
 {
 	unsigned int input;
@@ -1117,7 +1117,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -1145,7 +1145,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7e05c5e4e45c..21eb84c2ad1c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -238,20 +238,12 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
 static struct freq_attr _name =			\
 __ATTR(_name, 0200, NULL, store_##_name)
 
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
