From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 12/12] PM / devfreq: Add opp_notifier_cb() function pointer
 to support OPP notifier
Date: Thu, 24 Aug 2017 10:42:59 +0900
Message-ID: <1503538979-22693-13-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas1p3bf35f95d83b2a2ed36126f918638b8fc@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45187 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdHXBnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:02 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The devfreq uses the OPP interface as a mandatory method
and so the devfreq has to support the OPP notifier in order to
catch the OPP events. So, this patch adds the new opp_notifier_cb()
function pointer in the struct devfreq_dev_profile. The user can
add the their own callback function to receive the OPP events.

Also, the devfreq provides the default OPP notifeir callback
in order to remake the frequency table when OPP events happen.
- default_opp_notifier_cb()

After merged the commit 0ec09ac2cebe ("PM / devfreq: Set the
freq_table of devfreq device"), if the freq_table is NULL,
the devfreq_add_device() makes the freq_table by using OPP interface.
In this case, the devfreq should handle the freq_table
when OPP events happen such as OPP_EVENT_REMOVE, OPP_EVENT_ADD.

When the dev_pm_opp_add/remove() are called, the devfreq core
has to remake the frequency table with the changed OPP information
in the default_opp_notifier_cb().

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/devfreq.h   | 12 ++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7efa867e4aea..d313bed95871 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -163,6 +163,39 @@ static int set_freq_table(struct devfreq *devfreq)
 	return 0;
 }
 
+static int default_opp_notifier_cb(struct notifier_block *nb,
+				unsigned long opp_event, void *opp)
+{
+	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
+	struct devfreq_dev_profile *profile = devfreq->profile;
+	struct device *dev = devfreq->dev.parent;
+	int ret = 0;
+
+	mutex_lock(&devfreq->lock);
+
+	switch (opp_event) {
+	case OPP_EVENT_ADD:
+	case OPP_EVENT_REMOVE:
+		/* Free the frequency table */
+		profile->max_state = 0;
+		kfree(dev, profile->freq_table);
+
+		/* Remake the frequency table with the changed OPP  */
+		ret = set_freq_table(devfreq);
+		if (ret < 0)
+			goto out;
+		break;
+	case OPP_EVENT_DISABLE:
+	case OPP_EVENT_ENABLE:
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&devfreq->lock);
+	return ret;
+}
+
 /**
  * devfreq_update_status() - Update statistics of devfreq behavior
  * @devfreq:	the devfreq instance
@@ -637,6 +670,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
+	/* Register OPP notifier to catch the change of OPP entries */
+	if (!devfreq->nb.notifier_call)
+		devfreq->nb.notifier_call = default_opp_notifier_cb;
+	err = dev_pm_opp_register_notifier(dev, &devfreq->nb);
+	if (err < 0) {
+		mutex_unlock(&devfreq->lock);
+		dev_err(dev, "Unable to register opp notifier (%d)\n", err);
+		goto err_reg;
+	}
 	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
@@ -663,9 +705,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	return devfreq;
 
 err_init:
+	dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
-
+err_reg:
 	device_unregister(&devfreq->dev);
 err_dev:
 	if (devfreq)
@@ -686,6 +729,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	dev_pm_opp_unregister_notifier(devfreq->dev.parent, &devfreq->nb);
 	device_unregister(&devfreq->dev);
 
 	return 0;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d6f054545799..9596fd195986 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -84,6 +84,16 @@ struct devfreq_dev_status {
  *			from devfreq_remove_device() call. If the user
  *			has registered devfreq->nb at a notifier-head,
  *			this is the time to unregister it.
+ * @opp_notifier_cb:	And optional callback that is called when following
+ *			OPP events happen from OPP interface. If the user
+ *			doesn't add this callback, the devfreq core add
+ *			the default callback funtion to handle the OPP events.
+ *			- Second parameter : the OPP event
+ *				: OPP_EVENT_ADD
+ *				: OPP_EVENT_REMOVE
+ *				: OPP_EVENT_ENABLE
+ *				: OPP_EVENT_DISABLE,
+ *			- Third parameter : the instance of struct dev_pm_opp
  * @freq_table:	Optional list of frequencies to support statistics.
  * @max_state:	The size of freq_table.
  */
@@ -96,6 +106,8 @@ struct devfreq_dev_profile {
 			      struct devfreq_dev_status *stat);
 	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
 	void (*exit)(struct device *dev);
+	int (*opp_notifier_cb)(struct notifier_block *nb,
+				unsigned long opp_event, void *opp);
 
 	unsigned long *freq_table;
 	unsigned int max_state;
-- 
1.9.1
