From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v7] PM/devfreq: add suspend frequency support
Date: Thu, 24 Nov 2016 17:11:42 +0800
Message-ID: <1479978702-21449-1-git-send-email-hl@rock-chips.com>
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
Changes in v6:
- return to use stop_polling check suspend status
Changes in v7:
- move handle suspend frequency in devfreq_suspend_device()

 drivers/devfreq/devfreq.c | 47 ++++++++++++++++++++++++++++++++++-------------
 include/linux/devfreq.h   |  1 +
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index da72d97..958abc8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -212,16 +212,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 	return 0;
 }
 
-/* Load monitoring helper functions for governors use */
-
-/**
- * update_devfreq() - Reevaluate the device and configure frequency.
- * @devfreq:	the devfreq instance.
- *
- * Note: Lock devfreq->lock before calling update_devfreq
- *	 This function is exported for governors.
- */
-int update_devfreq(struct devfreq *devfreq)
+static int _update_devfreq(struct devfreq *devfreq, bool is_suspending)
 {
 	struct devfreq_freqs freqs;
 	unsigned long freq, cur_freq;
@@ -237,9 +228,13 @@ int update_devfreq(struct devfreq *devfreq)
 		return -EINVAL;
 
 	/* Reevaluate the proper frequency */
-	err = devfreq->governor->get_target_freq(devfreq, &freq);
-	if (err)
-		return err;
+	if (is_suspending && devfreq->suspend_freq) {
+		freq = devfreq->suspend_freq;
+	} else {
+		err = devfreq->governor->get_target_freq(devfreq, &freq);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Adjust the frequency with user freq and QoS.
@@ -285,6 +280,21 @@ int update_devfreq(struct devfreq *devfreq)
 	devfreq->previous_freq = freq;
 	return err;
 }
+
+/* Load monitoring helper functions for governors use */
+
+/**
+ * update_devfreq() - Reevaluate the device and configure frequency.
+ * @devfreq:	the devfreq instance.
+ *
+ * Note: Lock devfreq->lock before calling update_devfreq
+ *	 This function is exported for governors.
+ */
+
+int update_devfreq(struct devfreq *devfreq)
+{
+	return _update_devfreq(devfreq, false);
+}
 EXPORT_SYMBOL(update_devfreq);
 
 /**
@@ -524,6 +534,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
 	int err = 0;
+	struct dev_pm_opp *suspend_opp;
 
 	if (!dev || !profile || !governor_name) {
 		dev_err(dev, "%s: Invalid parameters.\n", __func__);
@@ -558,6 +569,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
@@ -754,6 +771,10 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 	if (!devfreq->governor)
 		return 0;
 
+	mutex_lock(&devfreq->lock);
+	_update_devfreq(devfreq, true);
+	mutex_unlock(&devfreq->lock);
+
 	return devfreq->governor->event_handler(devfreq,
 				DEVFREQ_GOV_SUSPEND, NULL);
 }
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 98c6993..517e394 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -172,6 +172,7 @@ struct devfreq {
 	struct delayed_work work;
 
 	unsigned long previous_freq;
+	unsigned long suspend_freq;
 	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
-- 
2.6.6
