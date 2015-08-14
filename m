From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v4 1/5] PM / devfreq: cache the last call to get_dev_status()
Date: Fri, 14 Aug 2015 18:56:56 +0100
Message-ID: <1439575020-3447-2-git-send-email-javi.merino@arm.com>
References: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439575020-3447-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, Javi Merino <javi.merino@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

The return value of get_dev_status() can be reused.  Cache it so that
other parts of the kernel can reuse it instead of having to call the
same function again.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/devfreq/governor_simpleondemand.c | 33 +++++++++++++++++--------------
 include/linux/devfreq.h                   | 15 ++++++++++++++
 2 files changed, 33 insertions(+), 15 deletions(-)

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
index ce447f0f1bad..70a1c60ddda4 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -161,6 +161,7 @@ struct devfreq {
 	struct delayed_work work;
 
 	unsigned long previous_freq;
+	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
 
@@ -204,6 +205,15 @@ extern int devm_devfreq_register_opp_notifier(struct device *dev,
 extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 						struct devfreq *devfreq);
 
+/**
+ * devfreq_update_stats() - update the last_status pointer in struct devfreq
+ * @df:		the devfreq instance whose status needs updating
+ */
+static inline int devfreq_update_stats(struct devfreq *df)
+{
+	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
+}
+
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
  * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
@@ -289,6 +299,11 @@ static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
 							struct devfreq *devfreq)
 {
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
