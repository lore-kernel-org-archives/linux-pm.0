From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 6/7] cpufreq: conservative: Update sample_delay_ns immediately
Date: Tue,  9 Feb 2016 09:16:18 +0530
Message-ID: <c86eb62a0d18cedefc20d05de57fd8480179de48.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq_governor.c | 49 ++++++++++++++++++++++++++++++++---
 drivers/cpufreq/cpufreq_governor.h |  1 -
 drivers/cpufreq/cpufreq_ondemand.c | 52 --------------------------------------
 3 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 464f346815e0..c0f9151e1045 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -26,10 +26,29 @@ DEFINE_MUTEX(dbs_data_mutex);
 EXPORT_SYMBOL_GPL(dbs_data_mutex);
 
 /* Common sysfs tunables */
+/**
+ * update_sampling_rate - update sampling rate effective immediately if needed.
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
 static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 				   size_t count)
 {
-	struct dbs_governor *gov = dbs_data->gov;
+	struct policy_dbs_info *policy_dbs;
 	unsigned int rate;
 	int ret;
 	ret = sscanf(buf, "%u", &rate);
@@ -38,8 +57,32 @@ static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 
 	dbs_data->sampling_rate = max(rate, dbs_data->min_sampling_rate);
 
-	if (gov->update_sampling_rate)
-		gov->update_sampling_rate(dbs_data);
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
 
 	return count;
 }
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 8aff218f73a4..9ab1a05712d8 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -211,7 +211,6 @@ struct dbs_governor {
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
 	bool (*invalid_up_threshold)(struct dbs_data *dbs_data, unsigned int threshold);
 	bool (*invalid_sampling_down_factor)(unsigned int factor);
-	void (*update_sampling_rate)(struct dbs_data *dbs_data);
 	void (*update_sampling_down_factor)(struct dbs_data *dbs_data);
 	void (*update_ignore_nice_load)(struct dbs_data *dbs_data);
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index caef7c9f631d..d9f323f150c4 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -221,57 +221,6 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 /************************** sysfs interface ************************/
 static struct dbs_governor od_dbs_gov;
 
-/**
- * update_sampling_rate - update sampling rate effective immediately if needed.
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
-static void update_sampling_rate(struct dbs_data *dbs_data)
-{
-	struct policy_dbs_info *policy_dbs;
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
-		gov_update_sample_delay(policy_dbs, dbs_data->sampling_rate);
-		mutex_unlock(&policy_dbs->timer_mutex);
-	}
-}
-
 static bool invalid_up_threshold(struct dbs_data *dbs_data,
 				 unsigned int threshold)
 {
@@ -438,7 +387,6 @@ static struct dbs_governor od_dbs_gov = {
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
 	.gov_check_cpu = od_check_cpu,
-	.update_sampling_rate = update_sampling_rate,
 	.invalid_up_threshold = invalid_up_threshold,
 	.invalid_sampling_down_factor = invalid_sampling_down_factor,
 	.update_sampling_down_factor = update_sampling_down_factor,
-- 
2.7.1.370.gb2aa7f8
