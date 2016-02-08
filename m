From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 13/13] cpufreq: conservative: Update sample_delay_ns immediately
Date: Mon,  8 Feb 2016 17:09:27 +0530
Message-ID: <6758a7bf2d6facc288bef632c5d47e7e2c5ba05b.1454931189.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35251 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbcBHLlE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 06:41:04 -0500
Received: by mail-pa0-f54.google.com with SMTP id ho8so72607334pac.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 03:41:04 -0800 (PST)
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Ondemand governor already updates sample_delay_ns immediately on updates
to sampling rate, but conservative isn't doing that.

It was left out earlier as the code has been really complex to get that
done easily. But now things are sorted out very well, and we can follow
the same for conservative governor as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 30 +++++++++++++++++++++++++++---
 drivers/cpufreq/cpufreq_governor.h |  1 -
 drivers/cpufreq/cpufreq_ondemand.c | 38 --------------------------------------
 3 files changed, 27 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index e267acc67067..3f4338bdb3aa 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -29,7 +29,7 @@ EXPORT_SYMBOL_GPL(dbs_data_mutex);
 static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 				   size_t count)
 {
-	struct dbs_governor *gov = dbs_data->gov;
+	struct policy_dbs_info *policy_dbs;
 	unsigned int rate;
 	int ret;
 	ret = sscanf(buf, "%u", &rate);
@@ -38,8 +38,32 @@ static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 
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
index b740633c2fbe..127982f6d869 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -212,7 +212,6 @@ struct dbs_governor {
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
 	bool (*invalid_up_threshold)(struct dbs_data *dbs_data, unsigned int threshold);
 	bool (*invalid_sampling_down_factor)(unsigned int factor);
-	void (*update_sampling_rate)(struct dbs_data *dbs_data);
 	void (*update_sampling_down_factor)(struct dbs_data *dbs_data);
 	void (*update_ignore_nice_load)(struct dbs_data *dbs_data);
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index f72087bc8302..1e17f6ffdf42 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -221,43 +221,6 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 /************************** sysfs interface ************************/
 static struct dbs_governor od_dbs_gov;
 
-/**
- * update_sampling_rate - update sampling rate effective immediately if needed.
- * @new_rate: new sampling rate
- */
-static void update_sampling_rate(struct dbs_data *dbs_data)
-{
-	struct policy_dbs_info *policy_dbs;
-	unsigned int new_rate = dbs_data->sampling_rate;
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
 static bool invalid_up_threshold(struct dbs_data *dbs_data,
 				 unsigned int threshold)
 {
@@ -425,7 +388,6 @@ static struct dbs_governor od_dbs_gov = {
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
 	.gov_check_cpu = od_check_cpu,
-	.update_sampling_rate = update_sampling_rate,
 	.invalid_up_threshold = invalid_up_threshold,
 	.invalid_sampling_down_factor = invalid_sampling_down_factor,
 	.update_sampling_down_factor = update_sampling_down_factor,
-- 
2.7.1.370.gb2aa7f8

