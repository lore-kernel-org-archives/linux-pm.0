From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 2/2] PM / devfreq: Add suspend frequency support
Date: Wed, 28 Dec 2016 21:07:08 +0900
Message-ID: <1482926828-19746-3-git-send-email-cw00.choi@samsung.com>
References: <1482926828-19746-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228120710epcas5p25597b14fdf1dce59f2bc185d0f5f5401@epcas5p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57031 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbcL1MHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 07:07:13 -0500
In-reply-to: <1482926828-19746-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: hl@rock-chips.com, tjakobi@math.uni-bielefeld.de, chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

From: Lin Huang <hl@rock-chips.com>

Add suspend frequency support and if needed set it to
the frequency obtained from the suspend opp (can be defined
using opp-v2 bindings and is optional).

Signed-off-by: Lin Huang <hl@rock-chips.com>
[cw00.choi: Support the passive governor and use separate devfreq_set_target()]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 31 ++++++++++++++++++++++++++++++-
 include/linux/devfreq.h   |  2 ++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e386f14d91c3..8109fb71177b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -620,6 +620,23 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
+	/*
+	 * Get the suspend frequency from OPP table. But the devfreq device
+	 * using passive governor don't need to get the suspend frequency
+	 * because the passive devfreq device depend on the parent devfreq
+	 * device.
+	 */
+	devfreq->suspend_freq = 0L;
+	if (strncmp(devfreq->governor_name, "passive", 7)) {
+		struct dev_pm_opp *opp;
+
+		rcu_read_lock();
+		opp = dev_pm_opp_get_suspend_opp(dev);
+		if (opp)
+			devfreq->suspend_freq = dev_pm_opp_get_freq(opp);
+		rcu_read_unlock();
+	}
+
 	devfreq->governor = governor;
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
@@ -777,14 +794,26 @@ void devm_devfreq_remove_device(struct device *dev, struct devfreq *devfreq)
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
 	if (!devfreq->governor)
 		return 0;
 
-	return devfreq->governor->event_handler(devfreq,
+	ret = devfreq->governor->event_handler(devfreq,
 				DEVFREQ_GOV_SUSPEND, NULL);
+	if (ret < 0)
+		return ret;
+
+	if (devfreq->suspend_freq) {
+		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2de4e2eea180..926bef5a6332 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -141,6 +141,7 @@ struct devfreq_governor {
  *		devfreq.nb to the corresponding register notifier call chain.
  * @work:	delayed work for load monitoring.
  * @previous_freq:	previously configured frequency value.
+ * @suspend_freq:	frequency to set during suspend mode.
  * @data:	Private data of the governor. The devfreq framework does not
  *		touch this.
  * @min_freq:	Limit minimum frequency requested by user (0: none)
@@ -172,6 +173,7 @@ struct devfreq {
 	struct delayed_work work;
 
 	unsigned long previous_freq;
+	unsigned long suspend_freq;
 	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
-- 
1.9.1

