From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V2 4/4] cpufreq: Get rid of "struct global_attr"
Date: Mon, 11 Feb 2013 13:20:03 +0530
Message-ID: <ef1aad61936c1ceaa7319953563825534daa7a32.1360568193.git.viresh.kumar@linaro.org>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1360568193.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1360568193.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1360568193.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, charles.garcia-tobin-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

We don't need to keep two structures for file attributes, global_attr and
freq_attr. Lets use freq_attr only for cpufreq core and drivers.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/acpi-cpufreq.c |  9 ++++-----
 drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++---------------
 include/linux/cpufreq.h        | 16 ----------------
 3 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 937bc28..14219c3 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -160,19 +160,18 @@ static ssize_t _store_boost(const char *buf, size_t count)
 	return count;
 }
 
-static ssize_t store_global_boost(struct kobject *kobj, struct attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t store_global_boost(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
 {
 	return _store_boost(buf, count);
 }
 
-static ssize_t show_global_boost(struct kobject *kobj,
-				 struct attribute *attr, char *buf)
+static ssize_t show_global_boost(struct cpufreq_policy *policy, char *buf)
 {
 	return sprintf(buf, "%u\n", boost_enabled);
 }
 
-static struct global_attr global_boost = __ATTR(boost, 0644,
+static struct freq_attr global_boost = __ATTR(boost, 0644,
 						show_global_boost,
 						store_global_boost);
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 86ad482..0f2d6a0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -273,15 +273,15 @@ static void intel_pstate_debug_expose_params(void)
 /************************** debugfs end ************************/
 
 /************************** sysfs begin ************************/
-#define show_one(file_name, object)					\
-	static ssize_t show_##file_name					\
-	(struct kobject *kobj, struct attribute *attr, char *buf)	\
-	{								\
-		return sprintf(buf, "%u\n", limits.object);		\
-	}
+#define show_one(file_name, object)				\
+static ssize_t show_##file_name					\
+(struct cpufreq_policy *policy, char *buf)			\
+{								\
+	return sprintf(buf, "%u\n", limits.object);		\
+}
 
-static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
-				const char *buf, size_t count)
+static ssize_t store_no_turbo(struct cpufreq_policy *policy, const char *buf,
+		size_t count)
 {
 	unsigned int input;
 	int ret;
@@ -293,8 +293,8 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
-				const char *buf, size_t count)
+static ssize_t store_max_perf_pct(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
 {
 	unsigned int input;
 	int ret;
@@ -307,8 +307,8 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
-static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
-				const char *buf, size_t count)
+static ssize_t store_min_perf_pct(struct cpufreq_policy *policy,
+		const char *buf, size_t count)
 {
 	unsigned int input;
 	int ret;
@@ -325,9 +325,9 @@ show_one(no_turbo, no_turbo);
 show_one(max_perf_pct, max_perf_pct);
 show_one(min_perf_pct, min_perf_pct);
 
-define_one_global_rw(no_turbo);
-define_one_global_rw(max_perf_pct);
-define_one_global_rw(min_perf_pct);
+cpufreq_freq_attr_rw(no_turbo);
+cpufreq_freq_attr_rw(max_perf_pct);
+cpufreq_freq_attr_rw(min_perf_pct);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&no_turbo.attr,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0d84bfa..a092fcb 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -324,22 +324,6 @@ __ATTR(_name, _perm, show_##_name, NULL)
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
-#define define_one_global_ro(_name)		\
-static struct global_attr _name =		\
-__ATTR(_name, 0444, show_##_name, NULL)
-
-#define define_one_global_rw(_name)		\
-static struct global_attr _name =		\
-__ATTR(_name, 0644, show_##_name, store_##_name)
-
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
 void cpufreq_cpu_put(struct cpufreq_policy *data);
 const char *cpufreq_get_current_driver(void);
-- 
1.7.12.rc2.18.g61b472e
