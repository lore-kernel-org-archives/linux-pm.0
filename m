From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 05/12] PM / devfreq: Set min/max_freq when adding the
 devfreq device
Date: Thu, 24 Aug 2017 10:42:52 +0900
Message-ID: <1503538979-22693-6-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p161d781837dffe0724c0fd73fc477281a@epcas2p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20009 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdHXBnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:02 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Previously, the min/max_freq of devfreq device are always zero
before the user changes the min/max_freq through sysfs entry.
It might make the confusion of min/max_freq.

This patch initializes the available min/max_freq by using the OPP API.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 3c5ccb96e165..56f8a0473834 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -69,6 +69,34 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+static unsigned long find_available_min_freq(struct devfreq *devfreq)
+{
+	struct dev_pm_opp *opp;
+	unsigned long min_freq = 0;
+
+	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
+	if (IS_ERR(opp))
+		min_freq = 0;
+
+	dev_pm_opp_put(opp);
+
+	return min_freq;
+}
+
+static unsigned long find_available_max_freq(struct devfreq *devfreq)
+{
+	struct dev_pm_opp *opp;
+	unsigned long max_freq = ULONG_MAX;
+
+	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
+	if (IS_ERR(opp))
+		max_freq = 0;
+
+	dev_pm_opp_put(opp);
+
+	return max_freq;
+}
+
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
  * @devfreq:	the devfreq instance
@@ -556,6 +584,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table)
 		devfreq_set_freq_table(devfreq);
 
+	/* Set the scaling available min_freq and max_freq */
+	devfreq->min_freq = find_available_min_freq(devfreq);
+	if (!devfreq->min_freq) {
+		mutex_unlock(&devfreq->lock);
+		err = -EINVAL;
+		goto err_dev;
+	}
+
+	devfreq->max_freq = find_available_max_freq(devfreq);
+	if (!devfreq->max_freq) {
+		mutex_unlock(&devfreq->lock);
+		err = -EINVAL;
+		goto err_dev;
+	}
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
-- 
1.9.1
