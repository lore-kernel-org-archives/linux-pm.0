From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/10] opp: Relocate few routines
Date: Mon, 15 Jun 2015 17:27:27 +0530
Message-ID: <f0b36d8d92b406a3a51f32d5fcca10a73529d637.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33716 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbbFOL6A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:58:00 -0400
Received: by pdjn11 with SMTP id n11so71610467pdj.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:57:59 -0700 (PDT)
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

In order to prepare for the later commits, this relocates few routines towards
the top as they will be used earlier in the code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 277 ++++++++++++++++++++++++-----------------------
 1 file changed, 139 insertions(+), 138 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 677fb2843553..8c3fd57975fb 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -438,6 +438,102 @@ static struct device_opp *_add_device_opp(struct device *dev)
 }
 
 /**
+ * _kfree_device_rcu() - Free device_opp RCU handler
+ * @head:	RCU head
+ */
+static void _kfree_device_rcu(struct rcu_head *head)
+{
+	struct device_opp *device_opp = container_of(head, struct device_opp, rcu_head);
+
+	kfree_rcu(device_opp, rcu_head);
+}
+
+/**
+ * _kfree_opp_rcu() - Free OPP RCU handler
+ * @head:	RCU head
+ */
+static void _kfree_opp_rcu(struct rcu_head *head)
+{
+	struct dev_pm_opp *opp = container_of(head, struct dev_pm_opp, rcu_head);
+
+	kfree_rcu(opp, rcu_head);
+}
+
+/**
+ * _opp_remove()  - Remove an OPP from a table definition
+ * @dev_opp:	points back to the device_opp struct this opp belongs to
+ * @opp:	pointer to the OPP to remove
+ *
+ * This function removes an opp definition from the opp list.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * It is assumed that the caller holds required mutex for an RCU updater
+ * strategy.
+ */
+static void _opp_remove(struct device_opp *dev_opp,
+			struct dev_pm_opp *opp)
+{
+	/*
+	 * Notify the changes in the availability of the operable
+	 * frequency/voltage list.
+	 */
+	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
+	list_del_rcu(&opp->node);
+	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
+
+	if (list_empty(&dev_opp->opp_list)) {
+		list_del_rcu(&dev_opp->node);
+		call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
+			  _kfree_device_rcu);
+	}
+}
+
+/**
+ * dev_pm_opp_remove()  - Remove an OPP from OPP list
+ * @dev:	device for which we do this operation
+ * @freq:	OPP to remove with matching 'freq'
+ *
+ * This function removes an opp from the opp list.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_remove(struct device *dev, unsigned long freq)
+{
+	struct dev_pm_opp *opp;
+	struct device_opp *dev_opp;
+	bool found = false;
+
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		goto unlock;
+
+	list_for_each_entry(opp, &dev_opp->opp_list, node) {
+		if (opp->rate == freq) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
+			 __func__, freq);
+		goto unlock;
+	}
+
+	_opp_remove(dev_opp, opp);
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
+
+/**
  * _opp_add_dynamic() - Allocate a dynamic OPP.
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
@@ -570,102 +666,6 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 
 /**
- * _kfree_opp_rcu() - Free OPP RCU handler
- * @head:	RCU head
- */
-static void _kfree_opp_rcu(struct rcu_head *head)
-{
-	struct dev_pm_opp *opp = container_of(head, struct dev_pm_opp, rcu_head);
-
-	kfree_rcu(opp, rcu_head);
-}
-
-/**
- * _kfree_device_rcu() - Free device_opp RCU handler
- * @head:	RCU head
- */
-static void _kfree_device_rcu(struct rcu_head *head)
-{
-	struct device_opp *device_opp = container_of(head, struct device_opp, rcu_head);
-
-	kfree_rcu(device_opp, rcu_head);
-}
-
-/**
- * _opp_remove()  - Remove an OPP from a table definition
- * @dev_opp:	points back to the device_opp struct this opp belongs to
- * @opp:	pointer to the OPP to remove
- *
- * This function removes an opp definition from the opp list.
- *
- * Locking: The internal device_opp and opp structures are RCU protected.
- * It is assumed that the caller holds required mutex for an RCU updater
- * strategy.
- */
-static void _opp_remove(struct device_opp *dev_opp,
-			struct dev_pm_opp *opp)
-{
-	/*
-	 * Notify the changes in the availability of the operable
-	 * frequency/voltage list.
-	 */
-	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
-	list_del_rcu(&opp->node);
-	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
-
-	if (list_empty(&dev_opp->opp_list)) {
-		list_del_rcu(&dev_opp->node);
-		call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
-			  _kfree_device_rcu);
-	}
-}
-
-/**
- * dev_pm_opp_remove()  - Remove an OPP from OPP list
- * @dev:	device for which we do this operation
- * @freq:	OPP to remove with matching 'freq'
- *
- * This function removes an opp from the opp list.
- *
- * Locking: The internal device_opp and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- */
-void dev_pm_opp_remove(struct device *dev, unsigned long freq)
-{
-	struct dev_pm_opp *opp;
-	struct device_opp *dev_opp;
-	bool found = false;
-
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
-
-	dev_opp = _find_device_opp(dev);
-	if (IS_ERR(dev_opp))
-		goto unlock;
-
-	list_for_each_entry(opp, &dev_opp->opp_list, node) {
-		if (opp->rate == freq) {
-			found = true;
-			break;
-		}
-	}
-
-	if (!found) {
-		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
-			 __func__, freq);
-		goto unlock;
-	}
-
-	_opp_remove(dev_opp, opp);
-unlock:
-	mutex_unlock(&dev_opp_list_lock);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
-
-/**
  * _opp_set_availability() - helper to set the availability of an opp
  * @dev:		device for which we do this operation
  * @freq:		OPP frequency to modify availability
@@ -825,6 +825,49 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
 #ifdef CONFIG_OF
 /**
+ * of_free_opp_table() - Free OPP table entries created from static DT entries
+ * @dev:	device pointer used to lookup device OPPs.
+ *
+ * Free OPPs created using static entries present in DT.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function indirectly uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void of_free_opp_table(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp, *tmp;
+
+	/* Check for existing list for 'dev' */
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		int error = PTR_ERR(dev_opp);
+
+		if (error != -ENODEV)
+			WARN(1, "%s: dev_opp: %d\n",
+			     IS_ERR_OR_NULL(dev) ?
+					"Invalid device" : dev_name(dev),
+			     error);
+		return;
+	}
+
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
+	/* Free static OPPs */
+	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
+		if (!opp->dynamic)
+			_opp_remove(dev_opp, opp);
+	}
+
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(of_free_opp_table);
+
+/**
  * of_init_opp_table() - Initialize opp table from device tree
  * @dev:	device pointer used to lookup device OPPs.
  *
@@ -882,46 +925,4 @@ int of_init_opp_table(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
-
-/**
- * of_free_opp_table() - Free OPP table entries created from static DT entries
- * @dev:	device pointer used to lookup device OPPs.
- *
- * Free OPPs created using static entries present in DT.
- *
- * Locking: The internal device_opp and opp structures are RCU protected.
- * Hence this function indirectly uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- */
-void of_free_opp_table(struct device *dev)
-{
-	struct device_opp *dev_opp;
-	struct dev_pm_opp *opp, *tmp;
-
-	/* Check for existing list for 'dev' */
-	dev_opp = _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		int error = PTR_ERR(dev_opp);
-		if (error != -ENODEV)
-			WARN(1, "%s: dev_opp: %d\n",
-			     IS_ERR_OR_NULL(dev) ?
-					"Invalid device" : dev_name(dev),
-			     error);
-		return;
-	}
-
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
-
-	/* Free static OPPs */
-	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
-		if (!opp->dynamic)
-			_opp_remove(dev_opp, opp);
-	}
-
-	mutex_unlock(&dev_opp_list_lock);
-}
-EXPORT_SYMBOL_GPL(of_free_opp_table);
 #endif
-- 
2.4.0

