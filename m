From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 2/4] PM / devfreq: cache the last call to get_dev_status()
Date: Fri,  3 Jul 2015 13:58:28 +0100
Message-ID: <1435928310-15938-3-git-send-email-javi.merino@arm.com>
References: <1435928310-15938-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53240 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbbGCM7W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Jul 2015 08:59:22 -0400
In-Reply-To: <1435928310-15938-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

The return value of get_dev_status() can be reused.  Cache it so that
other parts of the kernel can reuse it instead of having to call the
same function again.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/devfreq/devfreq.c                 |  5 +++++
 drivers/devfreq/governor_simpleondemand.c | 33 +++++++++++++++++--------------
 include/linux/devfreq.h                   |  7 +++++++
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6390d5db6816..d253a73f2b86 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -810,6 +810,11 @@ unlock:
 }
 EXPORT_SYMBOL(devfreq_qos_set_min);
 
+int devfreq_update_stats(struct devfreq *df)
+{
+	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
+}
+
 static ssize_t governor_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 0720ba84ca92..ae72ba5e78df 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -21,17 +21,20 @@
 static int devfreq_simple_ondemand_func(struct devfreq *df,
 					unsigned long *freq)
 {
-	struct devfreq_dev_status stat;
-	int err = df->profile->get_dev_status(df->dev.parent, &stat);
+	int err;
+	struct devfreq_dev_status *stat;
 	unsigned long long a, b;
 	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
 	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
 	struct devfreq_simple_ondemand_data *data = df->data;
 	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
 
+	err = devfreq_update_stats(df);
 	if (err)
 		return err;
 
+	stat = &df->last_status;
+
 	if (data) {
 		if (data->upthreshold)
 			dfso_upthreshold = data->upthreshold;
@@ -43,41 +46,41 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 		return -EINVAL;
 
 	/* Assume MAX if it is going to be divided by zero */
-	if (stat.total_time == 0) {
+	if (stat->total_time == 0) {
 		*freq = max;
 		return 0;
 	}
 
 	/* Prevent overflow */
-	if (stat.busy_time >= (1 << 24) || stat.total_time >= (1 << 24)) {
-		stat.busy_time >>= 7;
-		stat.total_time >>= 7;
+	if (stat->busy_time >= (1 << 24) || stat->total_time >= (1 << 24)) {
+		stat->busy_time >>= 7;
+		stat->total_time >>= 7;
 	}
 
 	/* Set MAX if it's busy enough */
-	if (stat.busy_time * 100 >
-	    stat.total_time * dfso_upthreshold) {
+	if (stat->busy_time * 100 >
+	    stat->total_time * dfso_upthreshold) {
 		*freq = max;
 		return 0;
 	}
 
 	/* Set MAX if we do not know the initial frequency */
-	if (stat.current_frequency == 0) {
+	if (stat->current_frequency == 0) {
 		*freq = max;
 		return 0;
 	}
 
 	/* Keep the current frequency */
-	if (stat.busy_time * 100 >
-	    stat.total_time * (dfso_upthreshold - dfso_downdifferential)) {
-		*freq = stat.current_frequency;
+	if (stat->busy_time * 100 >
+	    stat->total_time * (dfso_upthreshold - dfso_downdifferential)) {
+		*freq = stat->current_frequency;
 		return 0;
 	}
 
 	/* Set the desired frequency based on the load */
-	a = stat.busy_time;
-	a *= stat.current_frequency;
-	b = div_u64(a, stat.total_time);
+	a = stat->busy_time;
+	a *= stat->current_frequency;
+	b = div_u64(a, stat->total_time);
 	b *= 100;
 	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
 	*freq = (unsigned long) b;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index ffbe1f62ec2c..be351cfacec8 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -161,6 +161,7 @@ struct devfreq {
 	struct delayed_work work;
 
 	unsigned long previous_freq;
+	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
 
@@ -206,6 +207,7 @@ extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 
 int devfreq_qos_set_min(struct devfreq *df, unsigned long value);
 int devfreq_qos_set_max(struct devfreq *df, unsigned long value);
+int devfreq_update_stats(struct devfreq *df);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
@@ -302,6 +304,11 @@ static inline int devfreq_qos_set_max(struct devfreq *df, unsigned long value)
 {
 	return -EINVAL;
 }
+
+static inline int devfreq_update_stats(struct devfreq *df)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
1.9.1

