From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 5/6] cpufreq: conservative: Update sample_delay_ns immediately
Date: Thu, 11 Feb 2016 17:31:15 +0530
Message-ID: <bc883de639e29f0c576392b722be8281672b57bf.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Ondemand governor already updates sample_delay_ns immediately on updates
to sampling rate, but conservative isn't doing that.

It was left out earlier as the code has been really complex to get that
done easily. But now things are sorted out very well, and we can follow
the same for conservative governor as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 14 -------
 drivers/cpufreq/cpufreq_governor.c     | 63 +++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq_governor.h     |  2 +
 drivers/cpufreq/cpufreq_ondemand.c     | 69 ----------------------------------
 4 files changed, 65 insertions(+), 83 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index ed081dbce00c..6243502ce24d 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -136,20 +136,6 @@ static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
 	return count;
 }
 
-static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
-{
-	unsigned int input;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-
-	if (ret != 1)
-		return -EINVAL;
-
-	dbs_data->sampling_rate = max(input, dbs_data->min_sampling_rate);
-	return count;
-}
-
 static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
 		size_t count)
 {
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 481585611097..17c51bca2df1 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -25,6 +25,69 @@
 DEFINE_MUTEX(dbs_data_mutex);
 EXPORT_SYMBOL_GPL(dbs_data_mutex);
 
+/* Common sysfs tunables */
+/**
+ * store_sampling_rate - update sampling rate effective immediately if needed.
+ *
+ * If new rate is smaller than the old, simply updating
+ * dbs.sampling_rate might not be appropriate. For example, if the
+ * original sampling_rate was 1 second and the requested new sampling rate is 10
+ * ms because the user needs immediate reaction from ondemand governor, but not
+ * sure if higher frequency will be required or not, then, the governor may
+ * change the sampling rate too late; up to 1 second later. Thus, if we are
+ * reducing the sampling rate, we need to make the new value effective
+ * immediately.
+ *
+ * On the other hand, if new rate is larger than the old, then we may evaluate
+ * the load too soon, and it might we worth updating sample_delay_ns then as
+ * well.
+ *
+ * This must be called with dbs_data->mutex held, otherwise traversing
+ * policy_dbs_list isn't safe.
+ */
+ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
+			    size_t count)
+{
+	struct policy_dbs_info *policy_dbs;
+	unsigned int rate;
+	int ret;
+	ret = sscanf(buf, "%u", &rate);
+	if (ret != 1)
+		return -EINVAL;
+
+	dbs_data->sampling_rate = max(rate, dbs_data->min_sampling_rate);
+
+	/*
+	 * We are operating under dbs_data->mutex and so the list and its
+	 * entries can't be freed concurrently.
+	 */
+	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
+		mutex_lock(&policy_dbs->timer_mutex);
+		/*
+		 * On 32-bit architectures this may race with the
+		 * sample_delay_ns read in dbs_update_util_handler(), but that
+		 * really doesn't matter.  If the read returns a value that's
+		 * too big, the sample will be skipped, but the next invocation
+		 * of dbs_update_util_handler() (when the update has been
+		 * completed) will take a sample.  If the returned value is too
+		 * small, the sample will be taken immediately, but that isn't a
+		 * problem, as we want the new rate to take effect immediately
+		 * anyway.
+		 *
+		 * If this runs in parallel with dbs_work_handler(), we may end
+		 * up overwriting the sample_delay_ns value that it has just
+		 * written, but the difference should not be too big and it will
+		 * be corrected next time a sample is taken, so it shouldn't be
+		 * significant.
+		 */
+		gov_update_sample_delay(policy_dbs, dbs_data->sampling_rate);
+		mutex_unlock(&policy_dbs->timer_mutex);
+	}
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(store_sampling_rate);
+
 static inline struct dbs_data *to_dbs_data(struct kobject *kobj)
 {
 	return container_of(kobj, struct dbs_data, kobj);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 02885e353dfc..2f5ca7393653 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -238,4 +238,6 @@ void od_register_powersave_bias_handler(unsigned int (*f)
 		(struct cpufreq_policy *, unsigned int, unsigned int),
 		unsigned int powersave_bias);
 void od_unregister_powersave_bias_handler(void);
+ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
+			    size_t count);
 #endif /* _CPUFREQ_GOVERNOR_H */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 38301c6b31c7..12213823cc93 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -221,75 +221,6 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 /************************** sysfs interface ************************/
 static struct dbs_governor od_dbs_gov;
 
-/**
- * update_sampling_rate - update sampling rate effective immediately if needed.
- * @new_rate: new sampling rate
- *
- * If new rate is smaller than the old, simply updating
- * dbs.sampling_rate might not be appropriate. For example, if the
- * original sampling_rate was 1 second and the requested new sampling rate is 10
- * ms because the user needs immediate reaction from ondemand governor, but not
- * sure if higher frequency will be required or not, then, the governor may
- * change the sampling rate too late; up to 1 second later. Thus, if we are
- * reducing the sampling rate, we need to make the new value effective
- * immediately.
- *
- * On the other hand, if new rate is larger than the old, then we may evaluate
- * the load too soon, and it might we worth updating sample_delay_ns then as
- * well.
- *
- * This must be called with dbs_data->mutex held, otherwise traversing
- * policy_dbs_list isn't safe.
- */
-static void update_sampling_rate(struct dbs_data *dbs_data,
-		unsigned int new_rate)
-{
-	struct policy_dbs_info *policy_dbs;
-
-	dbs_data->sampling_rate = new_rate = max(new_rate,
-			dbs_data->min_sampling_rate);
-
-	/*
-	 * We are operating under dbs_data->mutex and so the list and its
-	 * entries can't be freed concurrently.
-	 */
-	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
-		mutex_lock(&policy_dbs->timer_mutex);
-		/*
-		 * On 32-bit architectures this may race with the
-		 * sample_delay_ns read in dbs_update_util_handler(), but that
-		 * really doesn't matter.  If the read returns a value that's
-		 * too big, the sample will be skipped, but the next invocation
-		 * of dbs_update_util_handler() (when the update has been
-		 * completed) will take a sample.  If the returned value is too
-		 * small, the sample will be taken immediately, but that isn't a
-		 * problem, as we want the new rate to take effect immediately
-		 * anyway.
-		 *
-		 * If this runs in parallel with dbs_work_handler(), we may end
-		 * up overwriting the sample_delay_ns value that it has just
-		 * written, but the difference should not be too big and it will
-		 * be corrected next time a sample is taken, so it shouldn't be
-		 * significant.
-		 */
-		gov_update_sample_delay(policy_dbs, new_rate);
-		mutex_unlock(&policy_dbs->timer_mutex);
-	}
-}
-
-static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
-{
-	unsigned int input;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-	if (ret != 1)
-		return -EINVAL;
-
-	update_sampling_rate(dbs_data, input);
-	return count;
-}
-
 static ssize_t store_io_is_busy(struct dbs_data *dbs_data, const char *buf,
 		size_t count)
 {
-- 
2.7.1.370.gb2aa7f8
