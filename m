From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v5] PM/devfreq: add suspend frequency support
Date: Tue,  8 Nov 2016 18:06:38 +0800
Message-ID: <1478599598-26015-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add suspend frequency support and if needed set it to
the frequency obtained from the suspend opp (can be defined
using opp-v2 bindings and is optional).

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- use update_devfreq() instead devfreq_update_status()
Changes in v3:
- fix build error
Changes in v4:
- move dev_pm_opp_get_suspend_opp() to devfreq_add_device()
Changes in v5:
- delete devfreq_opp_get_suspend_opp() in devfreq.h

 drivers/devfreq/devfreq.c                 | 15 +++++++++++++--
 drivers/devfreq/governor_simpleondemand.c |  9 +++++++++
 include/linux/devfreq.h                   |  2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index da72d97..af06891 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -359,7 +359,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 		mutex_unlock(&devfreq->lock);
 		return;
 	}
-
+	if (devfreq->suspend_freq) {
+		update_devfreq(devfreq);
+		devfreq->suspend_flag = true;
+	}
 	devfreq_update_status(devfreq, devfreq->previous_freq);
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
@@ -390,7 +393,8 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 
 	devfreq->last_stat_updated = jiffies;
 	devfreq->stop_polling = false;
-
+	if (devfreq->suspend_freq)
+		devfreq->suspend_flag = false;
 	if (devfreq->profile->get_cur_freq &&
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
 		devfreq->previous_freq = freq;
@@ -524,6 +528,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
 	int err = 0;
+	struct dev_pm_opp *suspend_opp;
 
 	if (!dev || !profile || !governor_name) {
 		dev_err(dev, "%s: Invalid parameters.\n", __func__);
@@ -558,6 +563,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
+	rcu_read_lock();
+	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
+	if (suspend_opp)
+		devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
+	rcu_read_unlock();
+
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
 		devfreq_set_freq_table(devfreq);
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ae72ba5..84b3ce1 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -29,6 +29,15 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	struct devfreq_simple_ondemand_data *data = df->data;
 	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
 
+	/*
+	 * if devfreq in suspend status and have suspend_freq,
+	 * the frequency need to set to suspend_freq
+	 */
+	if (df->suspend_flag) {
+		*freq =	df->suspend_freq;
+		return 0;
+	}
+
 	err = devfreq_update_stats(df);
 	if (err)
 		return err;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 98c6993..8567153 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -172,6 +172,7 @@ struct devfreq {
 	struct delayed_work work;
 
 	unsigned long previous_freq;
+	unsigned long suspend_freq;
 	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
@@ -179,6 +180,7 @@ struct devfreq {
 	unsigned long min_freq;
 	unsigned long max_freq;
 	bool stop_polling;
+	bool suspend_flag;
 
 	/* information for device frequency transition */
 	unsigned int total_trans;
-- 
2.6.6
