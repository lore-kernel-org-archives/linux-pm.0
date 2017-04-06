From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] PM / devfreq: Move struct devfreq_governor to devfreq
 directory
Date: Thu, 06 Apr 2017 13:19:35 +0900
Message-ID: <1491452375-13815-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170406041937epcas1p1b5cd8e13bf4049e1e4e5ff4d2b1b75b1@epcas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37790 "EHLO
        epoutp01.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751180AbdDFETl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2017 00:19:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This patch moves the struct devfreq_governor from header file
to the devfreq directory because this structure is private data
and it have to be only accessed by the devfreq core.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h | 29 +++++++++++++++++++++++++++++
 include/linux/devfreq.h    | 30 +-----------------------------
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 71576b8bdfef..a4f2fa1091e4 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -25,6 +25,35 @@
 #define DEVFREQ_GOV_SUSPEND			0x4
 #define DEVFREQ_GOV_RESUME			0x5
 
+/**
+ * struct devfreq_governor - Devfreq policy governor
+ * @node:		list node - contains registered devfreq governors
+ * @name:		Governor's name
+ * @immutable:		Immutable flag for governor. If the value is 1,
+ *			this govenror is never changeable to other governor.
+ * @get_target_freq:	Returns desired operating frequency for the device.
+ *			Basically, get_target_freq will run
+ *			devfreq_dev_profile.get_dev_status() to get the
+ *			status of the device (load = busy_time / total_time).
+ *			If no_central_polling is set, this callback is called
+ *			only with update_devfreq() notified by OPP.
+ * @event_handler:      Callback for devfreq core framework to notify events
+ *                      to governors. Events include per device governor
+ *                      init and exit, opp changes out of devfreq, suspend
+ *                      and resume of per device devfreq during device idle.
+ *
+ * Note that the callbacks are called with devfreq->lock locked by devfreq.
+ */
+struct devfreq_governor {
+	struct list_head node;
+
+	const char name[DEVFREQ_NAME_LEN];
+	const unsigned int immutable;
+	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
+	int (*event_handler)(struct devfreq *devfreq,
+				unsigned int event, void *data);
+};
+
 /* Caution: devfreq->lock must be locked before calling update_devfreq */
 extern int update_devfreq(struct devfreq *devfreq);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index e0acb0e5243b..6c220e4ebb6b 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -27,6 +27,7 @@
 #define DEVFREQ_POSTCHANGE		(1)
 
 struct devfreq;
+struct devfreq_governor;
 
 /**
  * struct devfreq_dev_status - Data given from devfreq user device to
@@ -101,35 +102,6 @@ struct devfreq_dev_profile {
 };
 
 /**
- * struct devfreq_governor - Devfreq policy governor
- * @node:		list node - contains registered devfreq governors
- * @name:		Governor's name
- * @immutable:		Immutable flag for governor. If the value is 1,
- *			this govenror is never changeable to other governor.
- * @get_target_freq:	Returns desired operating frequency for the device.
- *			Basically, get_target_freq will run
- *			devfreq_dev_profile.get_dev_status() to get the
- *			status of the device (load = busy_time / total_time).
- *			If no_central_polling is set, this callback is called
- *			only with update_devfreq() notified by OPP.
- * @event_handler:      Callback for devfreq core framework to notify events
- *                      to governors. Events include per device governor
- *                      init and exit, opp changes out of devfreq, suspend
- *                      and resume of per device devfreq during device idle.
- *
- * Note that the callbacks are called with devfreq->lock locked by devfreq.
- */
-struct devfreq_governor {
-	struct list_head node;
-
-	const char name[DEVFREQ_NAME_LEN];
-	const unsigned int immutable;
-	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
-	int (*event_handler)(struct devfreq *devfreq,
-				unsigned int event, void *data);
-};
-
-/**
  * struct devfreq - Device devfreq structure
  * @node:	list node - contains the devices with devfreq that have been
  *		registered.
-- 
1.9.1
