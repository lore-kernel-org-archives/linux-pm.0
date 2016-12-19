From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC v2 1/7] PM / devfreq: Replace 'stop_polling' boolean with flags
Date: Mon, 19 Dec 2016 03:16:21 +0100
Message-ID: <1482113787-28422-2-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:43806 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762091AbcLSCQi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Dec 2016 21:16:38 -0500
In-Reply-To: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

This is preparation for introducing some additional flags
to struct devfreq.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/devfreq.c | 18 +++++++++++-------
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 614738d..82d8052 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -28,6 +28,10 @@
 #include <linux/of.h>
 #include "governor.h"
 
+enum devfreq_flag_bits {
+	DEVFREQ_BIT_STOP_POLLING,
+};
+
 static struct class *devfreq_class;
 
 /*
@@ -366,13 +370,13 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
 void devfreq_monitor_suspend(struct devfreq *devfreq)
 {
 	mutex_lock(&devfreq->lock);
-	if (devfreq->stop_polling) {
+	if (test_bit(DEVFREQ_BIT_STOP_POLLING, &devfreq->flags)) {
 		mutex_unlock(&devfreq->lock);
 		return;
 	}
 
 	devfreq_update_status(devfreq, devfreq->previous_freq);
-	devfreq->stop_polling = true;
+	__set_bit(DEVFREQ_BIT_STOP_POLLING, &devfreq->flags);
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
@@ -391,7 +395,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	unsigned long freq;
 
 	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling)
+	if (!test_bit(DEVFREQ_BIT_STOP_POLLING, &devfreq->flags))
 		goto out;
 
 	if (!delayed_work_pending(&devfreq->work) &&
@@ -400,7 +404,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 	devfreq->last_stat_updated = jiffies;
-	devfreq->stop_polling = false;
+	__clear_bit(DEVFREQ_BIT_STOP_POLLING, &devfreq->flags);
 
 	if (devfreq->profile->get_cur_freq &&
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
@@ -427,7 +431,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 	mutex_lock(&devfreq->lock);
 	devfreq->profile->polling_ms = new_delay;
 
-	if (devfreq->stop_polling)
+	if (test_bit(DEVFREQ_BIT_STOP_POLLING, &devfreq->flags))
 		goto out;
 
 	/* if new delay is zero, stop polling */
@@ -449,7 +453,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		mutex_lock(&devfreq->lock);
-		if (!devfreq->stop_polling)
+		if (!test_bit(DEVFREQ_BIT_STOP_POLLING, &devfreq->flags))
 			queue_delayed_work(devfreq_wq, &devfreq->work,
 			      msecs_to_jiffies(devfreq->profile->polling_ms));
 	}
@@ -1203,7 +1207,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	int i, j;
 	unsigned int max_state = devfreq->profile->max_state;
 
-	if (!devfreq->stop_polling &&
+	if (!test_bit(DEVFREQ_BIT_STOP_POLLING, &devfreq->flags) &&
 			devfreq_update_status(devfreq, devfreq->previous_freq))
 		return 0;
 	if (max_state == 0)
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3bd15ae..d6bf9a3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -145,7 +145,7 @@ struct devfreq_governor {
  *		touch this.
  * @min_freq:	Limit minimum frequency requested by user (0: none)
  * @max_freq:	Limit maximum frequency requested by user (0: none)
- * @stop_polling:	 devfreq polling status of a device.
+ * @flags:	Internal DevFreq status of a device.
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
@@ -180,7 +180,7 @@ struct devfreq {
 
 	unsigned long min_freq;
 	unsigned long max_freq;
-	bool stop_polling;
+	unsigned long flags;
 
 	/* information for device frequency transition */
 	unsigned int total_trans;
-- 
2.7.3

