From: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Subject: [PATCH 1/3] PM / devfreq: set min/max freq limit from freq table
Date: Tue,  8 Jan 2013 11:20:37 +0530
Message-ID: <1357624239-13938-1-git-send-email-rajagopal.venkat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:59132 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3AHFye (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jan 2013 00:54:34 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so21826dak.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Jan 2013 21:54:32 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, mturquette@linaro.org, rjw@sisk.pl
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajagopal Venkat <rajagopal.venkat@linaro.org>

Set devfreq device min and max frequency limits when device
is added to devfreq, provided frequency table is supplied.
This helps governors to suggest target frequency with in
limits.

Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
---
 drivers/devfreq/devfreq.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a8f0173..5782c9b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -69,6 +69,29 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 }
 
 /**
+ * devfreq_set_freq_limits() - Set min and max frequency from freq_table
+ * @devfreq:	the devfreq instance
+ */
+static void devfreq_set_freq_limits(struct devfreq *devfreq)
+{
+	int idx;
+	unsigned long min = ~0, max = 0;
+
+	if (!devfreq->profile->freq_table)
+		return;
+
+	for (idx = 0; idx < devfreq->profile->max_state; idx++) {
+		if (min > devfreq->profile->freq_table[idx])
+			min = devfreq->profile->freq_table[idx];
+		if (max < devfreq->profile->freq_table[idx])
+			max = devfreq->profile->freq_table[idx];
+	}
+
+	devfreq->min_freq = min;
+	devfreq->max_freq = max;
+}
+
+/**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
  * @devfreq:	the devfreq instance
  * @freq:	the target frequency
@@ -476,6 +499,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 						devfreq->profile->max_state,
 						GFP_KERNEL);
 	devfreq->last_stat_updated = jiffies;
+	devfreq_set_freq_limits(devfreq);
 
 	dev_set_name(&devfreq->dev, dev_name(dev));
 	err = device_register(&devfreq->dev);
-- 
1.7.10.4

