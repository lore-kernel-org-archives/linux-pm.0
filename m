From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6/12] cpufreq: governor: Fix CPU load information updates via ->store
Date: Thu, 18 Feb 2016 02:26:55 +0100
Message-ID: <1474960.ULEHzzY9qD@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ->store() callbacks of some tunable sysfs attributes of the
ondemand and conservative governors trigger immediate updates of
the CPU load information for all CPUs "governed" by the given
dbs_data by walking the cpu_dbs_info structures for all online
CPUs in the system and updating them.

This is questionable for two reasons.  First, it may lead to a lot of
extra overhead on a system with many CPUs if the given dbs_data is
only associated with a few of them.  Second, if governor tunables are
per-policy, the CPUs associated with the other sets of governor
tunables should not be updated.

To address this issue, use the observation that in all of the places
in question the update operation may be carried out in the same way
(because all of the tunables involved are now located in struct
dbs_data and readily available to the common code) and make the
code in those places invoke the same (new) helper function that
will carry out the update correctly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |   15 +++++----------
 drivers/cpufreq/cpufreq_governor.c     |   30 ++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq_governor.h     |    1 +
 drivers/cpufreq/cpufreq_ondemand.c     |   22 ++++------------------
 4 files changed, 40 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -80,6 +80,36 @@ ssize_t store_sampling_rate(struct dbs_d
 }
 EXPORT_SYMBOL_GPL(store_sampling_rate);
 
+/**
+ * gov_update_cpu_data - Update CPU load data.
+ * @gov: Governor whose data is to be updated.
+ * @dbs_data: Top-level governor data pointer.
+ *
+ * Update CPU load data for all CPUs in the domain governed by @dbs_data
+ * (that may be a single policy or a bunch of them if governor tunables are
+ * system-wide).
+ *
+ * Call under the @dbs_data mutex.
+ */
+void gov_update_cpu_data(struct dbs_governor *gov, struct dbs_data *dbs_data)
+{
+	struct policy_dbs_info *policy_dbs;
+
+	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
+		unsigned int j;
+
+		for_each_cpu(j, policy_dbs->policy->cpus) {
+			struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
+
+			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall,
+								  dbs_data->io_is_busy);
+			if (dbs_data->ignore_nice_load)
+				j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(gov_update_cpu_data);
+
 static inline struct dbs_data *to_dbs_data(struct kobject *kobj)
 {
 	return container_of(kobj, struct dbs_data, kobj);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -218,4 +218,5 @@ void od_register_powersave_bias_handler(
 void od_unregister_powersave_bias_handler(void);
 ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 			    size_t count);
+void gov_update_cpu_data(struct dbs_governor *gov, struct dbs_data *dbs_data);
 #endif /* _CPUFREQ_GOVERNOR_H */
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -29,6 +29,7 @@
 
 static DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);
 
+static struct dbs_governor od_dbs_gov;
 static struct od_ops od_ops;
 
 static unsigned int default_powersave_bias;
@@ -222,7 +223,6 @@ static ssize_t store_io_is_busy(struct d
 {
 	unsigned int input;
 	int ret;
-	unsigned int j;
 
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
@@ -230,12 +230,8 @@ static ssize_t store_io_is_busy(struct d
 	dbs_data->io_is_busy = !!input;
 
 	/* we need to re-evaluate prev_cpu_idle */
-	for_each_online_cpu(j) {
-		struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
-									j);
-		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
-			&dbs_info->cdbs.prev_cpu_wall, dbs_data->io_is_busy);
-	}
+	gov_update_cpu_data(&od_dbs_gov, dbs_data);
+
 	return count;
 }
 
@@ -288,8 +284,6 @@ static ssize_t store_ignore_nice_load(st
 	unsigned int input;
 	int ret;
 
-	unsigned int j;
-
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
@@ -303,16 +297,8 @@ static ssize_t store_ignore_nice_load(st
 	dbs_data->ignore_nice_load = input;
 
 	/* we need to re-evaluate prev_cpu_idle */
-	for_each_online_cpu(j) {
-		struct od_cpu_dbs_info_s *dbs_info;
-		dbs_info = &per_cpu(od_cpu_dbs_info, j);
-		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
-			&dbs_info->cdbs.prev_cpu_wall, dbs_data->io_is_busy);
-		if (dbs_data->ignore_nice_load)
-			dbs_info->cdbs.prev_cpu_nice =
-				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+	gov_update_cpu_data(&od_dbs_gov, dbs_data);
 
-	}
 	return count;
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -23,6 +23,8 @@
 
 static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
 
+static struct dbs_governor cs_dbs_gov;
+
 static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 					   struct cpufreq_policy *policy)
 {
@@ -164,7 +166,7 @@ static ssize_t store_down_threshold(stru
 static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 		const char *buf, size_t count)
 {
-	unsigned int input, j;
+	unsigned int input;
 	int ret;
 
 	ret = sscanf(buf, "%u", &input);
@@ -180,15 +182,8 @@ static ssize_t store_ignore_nice_load(st
 	dbs_data->ignore_nice_load = input;
 
 	/* we need to re-evaluate prev_cpu_idle */
-	for_each_online_cpu(j) {
-		struct cs_cpu_dbs_info_s *dbs_info;
-		dbs_info = &per_cpu(cs_cpu_dbs_info, j);
-		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
-					&dbs_info->cdbs.prev_cpu_wall, 0);
-		if (dbs_data->ignore_nice_load)
-			dbs_info->cdbs.prev_cpu_nice =
-				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
-	}
+	gov_update_cpu_data(&cs_dbs_gov, dbs_data);
+
 	return count;
 }
 
