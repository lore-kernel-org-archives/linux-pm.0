From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/6] PM / devfreq: event: Remove the error log of
 devfreq_event_get_edev_by_phandle()
Date: Thu, 19 Nov 2015 17:17:45 +0900
Message-ID: <1447921070-6045-2-git-send-email-cw00.choi@samsung.com>
References: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51455 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbKSIR5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 03:17:57 -0500
In-reply-to: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch just removes the error log when devfreq_event_get_edev_by_phandle()
fail to get the instance of devfreq-event device. It is related to sequence of
the probe() of each driver. So, this error log might show the always during
kernel booting. Instead, each driver using this function can show the
appropriate error log.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index f304a0289eda..f51de879b2be 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -226,17 +226,12 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
 	struct device_node *node;
 	struct devfreq_event_dev *edev;
 
-	if (!dev->of_node) {
-		dev_err(dev, "device does not have a device node entry\n");
+	if (!dev->of_node)
 		return ERR_PTR(-EINVAL);
-	}
 
 	node = of_parse_phandle(dev->of_node, "devfreq-events", index);
-	if (!node) {
-		dev_err(dev, "failed to get phandle in %s node\n",
-			dev->of_node->full_name);
+	if (!node)
 		return ERR_PTR(-ENODEV);
-	}
 
 	mutex_lock(&devfreq_event_list_lock);
 	list_for_each_entry(edev, &devfreq_event_list, node) {
@@ -248,8 +243,6 @@ out:
 	mutex_unlock(&devfreq_event_list_lock);
 
 	if (!edev) {
-		dev_err(dev, "unable to get devfreq-event device : %s\n",
-			node->name);
 		of_node_put(node);
 		return ERR_PTR(-ENODEV);
 	}
-- 
1.9.1

