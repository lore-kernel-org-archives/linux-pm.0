From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 03/12] PM / devfreq: Move private devfreq_update_stats()
 into devfreq
Date: Thu, 24 Aug 2017 10:42:50 +0900
Message-ID: <1503538979-22693-4-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p174f90081b192ae5239f0130413ba3845@epcas2p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29200 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdHXBnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:01 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cwchoi00@gmail.com>

From: Chanwoo Choi <cwchoi00@gmail.com>

THe devfreq_update_stats() updates the 'struct devfreq_dev_status'
in order to get current status of devfreq device. It is only used
for the governors.

This patch moves the devfreq_update_stats() into devfreq directory.

Signed-off-by: Chanwoo Choi <cwchoi00@gmail.com>
---
 drivers/devfreq/governor.h |  4 ++++
 include/linux/devfreq.h    | 13 -------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index a4f2fa1091e4..cfc50a61a90d 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -69,4 +69,8 @@ extern void devfreq_interval_update(struct devfreq *devfreq,
 
 extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
 
+static inline int devfreq_update_stats(struct devfreq *df)
+{
+	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
+}
 #endif /* _GOVERNOR_H */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 6c220e4ebb6b..597294e0cc40 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -214,19 +214,6 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
 extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 						int index);
 
-/**
- * devfreq_update_stats() - update the last_status pointer in struct devfreq
- * @df:		the devfreq instance whose status needs updating
- *
- *  Governors are recommended to use this function along with last_status,
- * which allows other entities to reuse the last_status without affecting
- * the values fetched later by governors.
- */
-static inline int devfreq_update_stats(struct devfreq *df)
-{
-	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
-}
-
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
  * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
-- 
1.9.1
