From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 1/6] cpufreq: governor: Create generic macro for global tuners
Date: Tue,  9 Feb 2016 09:01:31 +0530
Message-ID: <293251f6ccbed038e2211684c4ae8d49941a78ef.1454988295.git.viresh.kumar@linaro.org>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454988295.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988295.git.viresh.kumar@linaro.org>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some tunables are present in governor specific structures, whereas one
(min_sampling_rate) is present in global 'struct dbs_data'.

The macro for that is pretty much specific to sampling_rate_min for now.
Next patch would be moving few more tunables to the 'struct dbs_data',
then it would be useful to create a generic macro for such cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq_conservative.c |  8 ++++----
 drivers/cpufreq/cpufreq_governor.h     | 36 +++++++++++++++++++---------------
 drivers/cpufreq/cpufreq_ondemand.c     |  8 ++++----
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 1a899bb7d1a4..a69eb7eae7ec 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -245,7 +245,7 @@ show_store_one(cs, up_threshold);
 show_store_one(cs, down_threshold);
 show_store_one(cs, ignore_nice_load);
 show_store_one(cs, freq_step);
-declare_show_sampling_rate_min(cs);
+show_one_common(cs, min_sampling_rate);
 
 gov_sys_pol_attr_rw(sampling_rate);
 gov_sys_pol_attr_rw(sampling_down_factor);
@@ -253,10 +253,10 @@ gov_sys_pol_attr_rw(up_threshold);
 gov_sys_pol_attr_rw(down_threshold);
 gov_sys_pol_attr_rw(ignore_nice_load);
 gov_sys_pol_attr_rw(freq_step);
-gov_sys_pol_attr_ro(sampling_rate_min);
+gov_sys_pol_attr_ro(min_sampling_rate);
 
 static struct attribute *dbs_attributes_gov_sys[] = {
-	&sampling_rate_min_gov_sys.attr,
+	&min_sampling_rate_gov_sys.attr,
 	&sampling_rate_gov_sys.attr,
 	&sampling_down_factor_gov_sys.attr,
 	&up_threshold_gov_sys.attr,
@@ -272,7 +272,7 @@ static struct attribute_group cs_attr_group_gov_sys = {
 };
 
 static struct attribute *dbs_attributes_gov_pol[] = {
-	&sampling_rate_min_gov_pol.attr,
+	&min_sampling_rate_gov_pol.attr,
 	&sampling_rate_gov_pol.attr,
 	&sampling_down_factor_gov_pol.attr,
 	&up_threshold_gov_pol.attr,
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 95e6834d36a8..62bafac5798b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -110,6 +110,26 @@ static ssize_t store_##file_name##_gov_pol				\
 show_one(_gov, file_name);						\
 store_one(_gov, file_name)
 
+#define show_one_common(_gov, file_name)				\
+static ssize_t show_##file_name##_gov_sys				\
+(struct kobject *kobj, struct attribute *attr, char *buf)		\
+{									\
+	struct dbs_data *dbs_data = _gov##_dbs_gov.gdbs_data;		\
+	return sprintf(buf, "%u\n", dbs_data->file_name);		\
+}									\
+									\
+static ssize_t show_##file_name##_gov_pol				\
+(struct cpufreq_policy *policy, char *buf)				\
+{									\
+	struct policy_dbs_info *policy_dbs = policy->governor_data;	\
+	struct dbs_data *dbs_data = policy_dbs->dbs_data;		\
+	return sprintf(buf, "%u\n", dbs_data->file_name);		\
+}
+
+#define show_store_one_common(_gov, file_name)				\
+show_one_common(_gov, file_name);					\
+store_one(_gov, file_name)
+
 /* create helper routines */
 #define define_get_cpu_dbs_routines(_dbs_info)				\
 static struct cpu_dbs_info *get_cpu_cdbs(int cpu)			\
@@ -264,22 +284,6 @@ static inline int delay_for_sampling_rate(unsigned int sampling_rate)
 	return delay;
 }
 
-#define declare_show_sampling_rate_min(_gov)				\
-static ssize_t show_sampling_rate_min_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, char *buf)		\
-{									\
-	struct dbs_data *dbs_data = _gov##_dbs_gov.gdbs_data;		\
-	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
-}									\
-									\
-static ssize_t show_sampling_rate_min_gov_pol				\
-(struct cpufreq_policy *policy, char *buf)				\
-{									\
-	struct policy_dbs_info *policy_dbs = policy->governor_data;	\
-	struct dbs_data *dbs_data = policy_dbs->dbs_data;		\
-	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
-}
-
 extern struct mutex dbs_data_mutex;
 extern struct mutex cpufreq_governor_lock;
 void dbs_check_cpu(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index b7ef2e7f4d4a..8c44bc3fffc5 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -443,7 +443,7 @@ show_store_one(od, up_threshold);
 show_store_one(od, sampling_down_factor);
 show_store_one(od, ignore_nice_load);
 show_store_one(od, powersave_bias);
-declare_show_sampling_rate_min(od);
+show_one_common(od, min_sampling_rate);
 
 gov_sys_pol_attr_rw(sampling_rate);
 gov_sys_pol_attr_rw(io_is_busy);
@@ -451,10 +451,10 @@ gov_sys_pol_attr_rw(up_threshold);
 gov_sys_pol_attr_rw(sampling_down_factor);
 gov_sys_pol_attr_rw(ignore_nice_load);
 gov_sys_pol_attr_rw(powersave_bias);
-gov_sys_pol_attr_ro(sampling_rate_min);
+gov_sys_pol_attr_ro(min_sampling_rate);
 
 static struct attribute *dbs_attributes_gov_sys[] = {
-	&sampling_rate_min_gov_sys.attr,
+	&min_sampling_rate_gov_sys.attr,
 	&sampling_rate_gov_sys.attr,
 	&up_threshold_gov_sys.attr,
 	&sampling_down_factor_gov_sys.attr,
@@ -470,7 +470,7 @@ static struct attribute_group od_attr_group_gov_sys = {
 };
 
 static struct attribute *dbs_attributes_gov_pol[] = {
-	&sampling_rate_min_gov_pol.attr,
+	&min_sampling_rate_gov_pol.attr,
 	&sampling_rate_gov_pol.attr,
 	&up_threshold_gov_pol.attr,
 	&sampling_down_factor_gov_pol.attr,
-- 
2.7.1.370.gb2aa7f8
