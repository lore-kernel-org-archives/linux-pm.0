From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/6+] cpufreq: Use struct kobj_attribute instead of
 struct global_attr
Date: Thu, 7 Mar 2019 19:38:07 +0530
Message-ID: <20190307140807.32th3altinvvv7dj@vireshk-i7>
References: <81e2be4499ef1a3c315c4c406f25ea12ea197ae5.1551957754.git.viresh.kumar@linaro.org>
 <20190307122115.GB21325@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p77q3pz6h4e3seiv"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307122115.GB21325@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "4 . 6+" <stable@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org


--p77q3pz6h4e3seiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07-03-19, 13:21, Greg KH wrote:
> On Thu, Mar 07, 2019 at 04:52:52PM +0530, Viresh Kumar wrote:
> > commit 625c85a62cb7d3c79f6e16de3cfa972033658250 upstream.
> > 
> > The cpufreq_global_kobject is created using kobject_create_and_add()
> > helper, which assigns the kobj_type as dynamic_kobj_ktype and show/store
> > routines are set to kobj_attr_show() and kobj_attr_store().
> > 
> > These routines pass struct kobj_attribute as an argument to the
> > show/store callbacks. But all the cpufreq files created using the
> > cpufreq_global_kobject expect the argument to be of type struct
> > attribute. Things work fine currently as no one accesses the "attr"
> > argument. We may not see issues even if the argument is used, as struct
> > kobj_attribute has struct attribute as its first element and so they
> > will both get same address.
> > 
> > But this is logically incorrect and we should rather use struct
> > kobj_attribute instead of struct global_attr in the cpufreq core and
> > drivers and the show/store callbacks should take struct kobj_attribute
> > as argument instead.
> > 
> > This bug is caught using CFI CLANG builds in android kernel which
> > catches mismatch in function prototypes for such callbacks.
> > 
> > Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
> > Reported-by: Donghee Han <dh.han@samsung.com>
> > Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > ---
> > This needs to be applied from v4.6 to v4.9 (including both).
> 
> Does not apply to the 4.9.y stable queue :(
> 
> Are you sure you backported this correctly?  No need to care about 4.6.

Same as 4.4, attached is the patch which I just now applied on
4.9.161. Git cherry-pick was able to figure it out just fine.

-- 
viresh

--p77q3pz6h4e3seiv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-cpufreq-Use-struct-kobj_attribute-instead-of-struct-.patch"

>From 19da10ba3bfdd8b3e5e7e64ef880903762437164 Mon Sep 17 00:00:00 2001
Message-Id: <19da10ba3bfdd8b3e5e7e64ef880903762437164.1551967645.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 25 Jan 2019 12:53:07 +0530
Subject: [PATCH] cpufreq: Use struct kobj_attribute instead of struct
 global_attr

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

Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
Reported-by: Donghee Han <dh.han@samsung.com>
Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
This needs to be applied from v4.6 to v4.9 (including both).
---
 drivers/cpufreq/cpufreq.c      |  6 +++---
 drivers/cpufreq/intel_pstate.c | 14 +++++++-------
 include/linux/cpufreq.h        | 12 ++----------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 61fe4bbc6dc0..a38a23f0b3f4 100644
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
index a59ae8e24d3d..f690085b1ad9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -659,13 +659,13 @@ static void __init intel_pstate_debug_expose_params(void)
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
@@ -681,7 +681,7 @@ static ssize_t show_turbo_pct(struct kobject *kobj,
 }
 
 static ssize_t show_num_pstates(struct kobject *kobj,
-				struct attribute *attr, char *buf)
+				struct kobj_attribute *attr, char *buf)
 {
 	struct cpudata *cpu;
 	int total;
@@ -692,7 +692,7 @@ static ssize_t show_num_pstates(struct kobject *kobj,
 }
 
 static ssize_t show_no_turbo(struct kobject *kobj,
-			     struct attribute *attr, char *buf)
+			     struct kobj_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -705,7 +705,7 @@ static ssize_t show_no_turbo(struct kobject *kobj,
 	return ret;
 }
 
-static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
+static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 			      const char *buf, size_t count)
 {
 	unsigned int input;
@@ -729,7 +729,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
@@ -753,7 +753,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
+static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
 	unsigned int input;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 32dc0cbd51ca..9d9e0b54f831 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -234,20 +234,12 @@ __ATTR(_name, _perm, show_##_name, NULL)
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


--p77q3pz6h4e3seiv--
