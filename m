From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/7] opp: Relocate few routines
Date: Wed, 11 Feb 2015 16:16:25 +0800
Message-ID: <c40b830fced1a1e14bd84ea97b4961a594648aba.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36681 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbBKIRA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 03:17:00 -0500
Received: by pdjp10 with SMTP id p10so2927851pdj.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 00:17:00 -0800 (PST)
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

In order to prepare for the later commits, this relocates few routines towards
the top as they will be used earlier in the code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 192 +++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 15bf29974c31..9e2118284f02 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -408,6 +408,102 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
 /**
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
  * _add_device_opp() - Allocate a new device OPP table
  * @dev:	device for which we do this operation
  *
@@ -572,102 +668,6 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
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
-- 
2.3.0.rc0.44.ga94655d

