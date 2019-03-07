From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.18+] cpufreq: Use struct kobj_attribute instead of struct global_attr
Date: Thu,  7 Mar 2019 16:50:48 +0530
Message-ID: <03b2be9ff971da005978fe5fab6181c6bcbbee1e.1551957547.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "4 . 18+" <stable@vger.kernel.org>
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

Cc: 4.18+ <stable@vger.kernel.org> # 4.18+
Reported-by: Donghee Han <dh.han@samsung.com>
Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
This needs to be applied to all kernels past v4.18.
---
 drivers/cpufreq/cpufreq.c      |  6 +++---
 drivers/cpufreq/intel_pstate.c | 23 ++++++++++++-----------
 include/linux/cpufreq.h        | 12 ++----------
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd3222013..8f9cef1ccad8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -545,13 +545,13 @@ EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
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
index d4ed0022b0dd..1d133df9cb99 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -836,7 +836,7 @@ static void intel_pstate_update_policies(void)
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
-	(struct kobject *kobj, struct attribute *attr, char *buf)	\
+	(struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
 	{								\
 		return sprintf(buf, "%u\n", global.object);		\
 	}
@@ -845,7 +845,7 @@ static ssize_t intel_pstate_show_status(char *buf);
 static int intel_pstate_update_status(const char *buf, size_t size);
 
 static ssize_t show_status(struct kobject *kobj,
-			   struct attribute *attr, char *buf)
+			   struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -856,7 +856,7 @@ static ssize_t show_status(struct kobject *kobj,
 	return ret;
 }
 
-static ssize_t store_status(struct kobject *a, struct attribute *b,
+static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
 			    const char *buf, size_t count)
 {
 	char *p = memchr(buf, '\n', count);
@@ -870,7 +870,7 @@ static ssize_t store_status(struct kobject *a, struct attribute *b,
 }
 
 static ssize_t show_turbo_pct(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total, no_turbo, turbo_pct;
@@ -896,7 +896,7 @@ static ssize_t show_turbo_pct(struct kobject *kobj,
 }
 
 static ssize_t show_num_pstates(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total;
@@ -917,7 +917,7 @@ static ssize_t show_num_pstates(struct kobject *kobj,
 }
 
 static ssize_t show_no_turbo(struct kobject *kobj,
-			     struct attribute *attr, char *buf)
+			     struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -939,7 +939,7 @@ static ssize_t show_no_turbo(struct kobject *kobj,
 	return ret;
 }
 
-static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
+static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 			      const char *buf, size_t count)
 {
 	unsigned int input;
@@ -986,7 +986,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -1016,7 +1016,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -1048,12 +1048,13 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 }
 
 static ssize_t show_hwp_dynamic_boost(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%u\n", hwp_boost);
 }
 
-static ssize_t store_hwp_dynamic_boost(struct kobject *a, struct attribute *b,
+static ssize_t store_hwp_dynamic_boost(struct kobject *a,
+				       struct kobj_attribute *b,
 				       const char *buf, size_t count)
 {
 	unsigned int input;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..72f59e8321e7 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -254,20 +254,12 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
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
