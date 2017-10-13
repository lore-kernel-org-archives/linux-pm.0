From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 3/8] PM / devfreq: Use the available min/max frequency
Date: Fri, 13 Oct 2017 16:48:19 +0900
Message-ID: <1507880904-31956-4-git-send-email-cw00.choi@samsung.com>
References: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171013074833epcas1p433f03287f42a5b6dc16e796efa2a3bf3@epcas1p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34874 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757442AbdJMHsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 03:48:37 -0400
In-reply-to: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The commit a76caf55e5b35 ("thermal: Add devfreq cooling") is able
to disable OPP as a cooling device. In result, both update_devfreq()
and {min|max}_freq_show() have to consider the 'opp->available'
status of each OPP.

So, this patch adds the 'scaling_{min|max}_freq' to struct devfreq
in order to indicate the available mininum and maximum frequency
by adjusting OPP interface such as dev_pm_opp_{disable|enable}().
The 'scaling_{min|max}_freq' are used for on both update_devfreq()
and {min|max}_freq_show().

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++++++--------
 include/linux/devfreq.h   |  4 ++++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b6ba24e5db0d..9de013ffeb67 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -28,6 +28,9 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define MAX(a,b)	((a > b) ? a : b)
+#define MIN(a,b)	((a < b) ? a : b)
+
 static struct class *devfreq_class;
 
 /*
@@ -255,7 +258,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 int update_devfreq(struct devfreq *devfreq)
 {
 	struct devfreq_freqs freqs;
-	unsigned long freq, cur_freq;
+	unsigned long freq, cur_freq, min_freq, max_freq;
 	int err = 0;
 	u32 flags = 0;
 
@@ -273,19 +276,21 @@ int update_devfreq(struct devfreq *devfreq)
 		return err;
 
 	/*
-	 * Adjust the frequency with user freq and QoS.
+	 * Adjust the frequency with user freq, QoS and available freq.
 	 *
 	 * List from the highest priority
 	 * max_freq
 	 * min_freq
 	 */
+	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
+	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
 
-	if (devfreq->min_freq && freq < devfreq->min_freq) {
-		freq = devfreq->min_freq;
+	if (min_freq && freq < min_freq) {
+		freq = min_freq;
 		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
 	}
-	if (devfreq->max_freq && freq > devfreq->max_freq) {
-		freq = devfreq->max_freq;
+	if (max_freq && freq > max_freq) {
+		freq = max_freq;
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
@@ -494,6 +499,19 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 	int ret;
 
 	mutex_lock(&devfreq->lock);
+
+	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
+	if (!devfreq->scaling_min_freq) {
+		mutex_unlock(&devfreq->lock);
+		return -EINVAL;
+	}
+
+	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
+	if (!devfreq->max_freq) {
+		mutex_unlock(&devfreq->lock);
+		return -EINVAL;
+	}
+
 	ret = update_devfreq(devfreq);
 	mutex_unlock(&devfreq->lock);
 
@@ -593,6 +611,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		err = -EINVAL;
 		goto err_dev;
 	}
+	devfreq->scaling_min_freq = devfreq->min_freq;
 
 	devfreq->max_freq = find_available_max_freq(devfreq);
 	if (!devfreq->max_freq) {
@@ -600,6 +619,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		err = -EINVAL;
 		goto err_dev;
 	}
+	devfreq->scaling_max_freq = devfreq->max_freq;
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
@@ -1127,7 +1147,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->min_freq);
+	return sprintf(buf, "%lu\n", to_devfreq(dev)->scaling_min_freq);
 }
 
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
@@ -1161,7 +1181,7 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->max_freq);
+	return sprintf(buf, "%lu\n", to_devfreq(dev)->scaling_max_freq);
 }
 static DEVICE_ATTR_RW(max_freq);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 597294e0cc40..fe7862060945 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -120,6 +120,8 @@ struct devfreq_dev_profile {
  *		touch this.
  * @min_freq:	Limit minimum frequency requested by user (0: none)
  * @max_freq:	Limit maximum frequency requested by user (0: none)
+ * @scaling_min_freq:	Limit minimum frequency requested by devfreq-cooling
+ * @scaling_max_freq:	Limit maximum frequency requested by devfreq-cooling
  * @stop_polling:	 devfreq polling status of a device.
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
@@ -153,6 +155,8 @@ struct devfreq {
 
 	unsigned long min_freq;
 	unsigned long max_freq;
+	unsigned long scaling_min_freq;
+	unsigned long scaling_max_freq;
 	bool stop_polling;
 
 	/* information for device frequency transition */
-- 
1.9.1
