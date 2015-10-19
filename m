From: Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] devfreq: correctly check failed allocation
Date: Mon, 19 Oct 2015 14:26:49 +0000
Message-ID: <1445264809-21917-1-git-send-email-wuninsu@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34962 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbbJSOZe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 10:25:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu, Insu Yun <wuninsu@gmail.com>

Since devm_kzalloc can be failed in memory pressure,
check return value and handle error.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/devfreq/devfreq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ca1b362..814089f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -482,9 +482,23 @@ struct devfreq *devfreq_add_device(struct device *dev,
 						devfreq->profile->max_state *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
+	if (!devfreq->trans_table) {
+		dev_err(dev, "%s: Unable to create transition table for the device\n",
+			__func__);
+		err = -ENOMEM;
+		goto err_dev;
+	}
+
 	devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned int) *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
+	if (!devfreq->time_in_state) {
+		dev_err(dev, "%s: Unable to create state for the device\n",
+			__func__);
+		err = -ENOMEM;
+		goto err_dev;
+	}
+
 	devfreq->last_stat_updated = jiffies;
 
 	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
-- 
1.9.1

