From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v8 4/5] PM / DEVFREQ: add internal interfaces for
	governors
Date: Wed, 24 Aug 2011 17:22:10 +0900
Message-ID: <1314174131-14194-5-git-send-email-myungjoo.ham@samsung.com>
References: <1314086044-24659-1-git-send-email-myungjoo.ham@samsung.com>
	<1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

- get_devfreq(): governors may convert struct dev -> struct devfreq
- update_devfreq(): governors may notify DEVFREQ core to reevaluate
frequencies.
- Governors may have .init and .exit callbacks

In order to use the internal interface, get_devfreq() and
update_devfreq(), governor should include "governor.h"

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/devfreq/devfreq.c  |   32 ++++++++++++++++++++++++--------
 drivers/devfreq/governor.h |   20 ++++++++++++++++++++
 include/linux/devfreq.h    |    2 ++
 3 files changed, 46 insertions(+), 8 deletions(-)
 create mode 100644 drivers/devfreq/governor.h

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 5bbece6..8de3b21 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -65,10 +65,10 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 
 /**
  * get_devfreq() - find devfreq struct. a wrapped find_device_devfreq()
- *		with mutex protection.
+ *		with mutex protection. exported for governors
  * @dev:	device pointer used to lookup device devfreq.
  */
-static struct devfreq *get_devfreq(struct device *dev)
+struct devfreq *get_devfreq(struct device *dev)
 {
 	struct devfreq *ret;
 
@@ -113,17 +113,15 @@ static int devfreq_do(struct devfreq *devfreq)
 }
 
 /**
- * devfreq_update() - Notify that the device OPP has been changed.
- * @dev:	the device whose OPP has been changed.
+ * update_devfreq() - Notify that the device OPP or frequency requirement
+ *		has been changed. This function is exported for governors.
+ * @devfreq:	the devfreq instance.
  */
-static int devfreq_update(struct notifier_block *nb, unsigned long type,
-			  void *devp)
+int update_devfreq(struct devfreq *devfreq)
 {
-	struct devfreq *devfreq;
 	int err = 0;
 
 	mutex_lock(&devfreq_list_lock);
-	devfreq = container_of(nb, struct devfreq, nb);
 	/* Reevaluate the proper frequency */
 	err = devfreq_do(devfreq);
 	mutex_unlock(&devfreq_list_lock);
@@ -131,6 +129,18 @@ static int devfreq_update(struct notifier_block *nb, unsigned long type,
 }
 
 /**
+ * devfreq_update() - Notify that the device OPP has been changed.
+ * @dev:	the device whose OPP has been changed.
+ */
+static int devfreq_update(struct notifier_block *nb, unsigned long type,
+			  void *devp)
+{
+	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
+
+	return update_devfreq(devfreq);
+}
+
+/**
  * devfreq_monitor() - Periodically run devfreq_do()
  * @work: the work struct used to run devfreq_monitor periodically.
  *
@@ -254,6 +264,9 @@ int devfreq_add_device(struct device *dev, struct devfreq_dev_profile *profile,
 
 	list_add(&devfreq->node, &devfreq_list);
 
+	if (governor->init)
+		governor->init(devfreq);
+
 	if (devfreq_wq && devfreq->next_polling && !polling) {
 		polling = true;
 		queue_delayed_work(devfreq_wq, &devfreq_work,
@@ -295,6 +308,9 @@ int devfreq_remove_device(struct device *dev)
 
 	sysfs_unmerge_group(&dev->kobj, &dev_attr_group);
 
+	if (devfreq->governor->exit)
+		devfreq->governor->exit(devfreq);
+
 	list_del(&devfreq->node);
 	srcu_notifier_chain_unregister(nh, &devfreq->nb);
 	kfree(devfreq);
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
new file mode 100644
index 0000000..bb5d964
--- /dev/null
+++ b/drivers/devfreq/governor.h
@@ -0,0 +1,20 @@
+/*
+ * governor.h - internal header for governors.
+ *
+ * Copyright (C) 2011 Samsung Electronics
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This header is for devfreq governors in drivers/devfreq/
+ */
+
+#ifndef _GOVERNOR_H
+#define _GOVERNOR_H
+
+extern struct devfreq *get_devfreq(struct device *dev);
+extern int update_devfreq(struct devfreq *devfreq);
+
+#endif /* _GOVERNOR_H */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 8252238..fdc6916 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -46,6 +46,8 @@ struct devfreq_dev_profile {
 struct devfreq_governor {
 	char name[DEVFREQ_NAME_LEN];
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
+	int (*init)(struct devfreq *this);
+	void (*exit)(struct devfreq *this);
 };
 
 /**
-- 
1.7.4.1
