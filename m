From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/10] OPP: Break _opp_add_dynamic() into smaller functions
Date: Mon, 15 Jun 2015 17:27:30 +0530
Message-ID: <15b69640a8672d983f2233e16e52ca275d36c816.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35494 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbbFOL6L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:58:11 -0400
Received: by pdbnf5 with SMTP id nf5so71735514pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:58:10 -0700 (PDT)
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Later commits would add support for new OPP bindings and this would be
required then. So, lets do it in a separate patch to make it easily
reviewable.

Another change worth noticing is INIT_LIST_HEAD(&opp->node). We weren't
doing it earlier as we never tried to delete a list node before it is
added to list. But this wouldn't be the case anymore. We might try to
delete a node (just to reuse the same code paths), without it being
getting added to the list.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 115 +++++++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 4b646f36f252..2ac48ff9c1ef 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -484,6 +484,7 @@ static void _kfree_opp_rcu(struct rcu_head *head)
  * _opp_remove()  - Remove an OPP from a table definition
  * @dev_opp:	points back to the device_opp struct this opp belongs to
  * @opp:	pointer to the OPP to remove
+ * @notify:	OPP_EVENT_REMOVE notification should be sent or not
  *
  * This function removes an opp definition from the opp list.
  *
@@ -492,13 +493,14 @@ static void _kfree_opp_rcu(struct rcu_head *head)
  * strategy.
  */
 static void _opp_remove(struct device_opp *dev_opp,
-			struct dev_pm_opp *opp)
+			struct dev_pm_opp *opp, bool notify)
 {
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
+	if (notify)
+		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
 	list_del_rcu(&opp->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
@@ -544,12 +546,65 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 		goto unlock;
 	}
 
-	_opp_remove(dev_opp, opp);
+	_opp_remove(dev_opp, opp, true);
 unlock:
 	mutex_unlock(&dev_opp_list_lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
+static struct dev_pm_opp *_allocate_opp(struct device *dev,
+					struct device_opp **dev_opp)
+{
+	struct dev_pm_opp *opp;
+
+	/* allocate new OPP node */
+	opp = kzalloc(sizeof(*opp), GFP_KERNEL);
+	if (!opp)
+		return NULL;
+
+	INIT_LIST_HEAD(&opp->node);
+
+	*dev_opp = _add_device_opp(dev);
+	if (!*dev_opp) {
+		kfree(opp);
+		return NULL;
+	}
+
+	return opp;
+}
+
+static int _opp_add(struct dev_pm_opp *new_opp, struct device_opp *dev_opp)
+{
+	struct dev_pm_opp *opp = NULL;
+	struct list_head *head = &dev_opp->opp_list;
+
+	/*
+	 * Insert new OPP in order of increasing frequency
+	 * and discard if already present
+	 */
+	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+		if (new_opp->rate <= opp->rate)
+			break;
+
+		head = &opp->node;
+	}
+
+	/* Duplicate OPPs ? */
+	if (opp && new_opp->rate == opp->rate) {
+		dev_warn(dev_opp->dev,
+			 "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
+			 __func__, opp->rate, opp->u_volt, opp->available,
+			 new_opp->rate, new_opp->u_volt, new_opp->available);
+		return opp->available && new_opp->u_volt == opp->u_volt ?
+			0 : -EEXIST;
+	}
+
+	new_opp->dev_opp = dev_opp;
+	list_add_rcu(&new_opp->node, head);
+
+	return 0;
+}
+
 /**
  * _opp_add_dynamic() - Allocate a dynamic OPP.
  * @dev:	device for which we do this operation
@@ -581,55 +636,28 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 			    long u_volt, bool dynamic)
 {
 	struct device_opp *dev_opp;
-	struct dev_pm_opp *opp = NULL, *new_opp;
-	struct list_head *head;
+	struct dev_pm_opp *new_opp;
 	int ret;
 
-	/* allocate new OPP node */
-	new_opp = kzalloc(sizeof(*new_opp), GFP_KERNEL);
-	if (!new_opp)
-		return -ENOMEM;
-
 	/* Hold our list modification lock here */
 	mutex_lock(&dev_opp_list_lock);
 
+	new_opp = _allocate_opp(dev, &dev_opp);
+	if (!new_opp) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
 	/* populate the opp table */
 	new_opp->rate = freq;
 	new_opp->u_volt = u_volt;
 	new_opp->available = true;
+	new_opp->dynamic = dynamic;
 
-	dev_opp = _add_device_opp(dev);
-	if (!dev_opp) {
-		ret = -ENOMEM;
+	ret = _opp_add(new_opp, dev_opp);
+	if (ret)
 		goto free_opp;
-	}
-
-	/*
-	 * Insert new OPP in order of increasing frequency
-	 * and discard if already present
-	 */
-	head = &dev_opp->opp_list;
-	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
-		if (new_opp->rate <= opp->rate)
-			break;
-		else
-			head = &opp->node;
-	}
-
-	/* Duplicate OPPs ? */
-	if (opp && new_opp->rate == opp->rate) {
-		ret = opp->available && new_opp->u_volt == opp->u_volt ?
-			0 : -EEXIST;
-
-		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
-			 __func__, opp->rate, opp->u_volt, opp->available,
-			 new_opp->rate, new_opp->u_volt, new_opp->available);
-		goto remove_dev_opp;
-	}
 
-	new_opp->dynamic = dynamic;
-	new_opp->dev_opp = dev_opp;
-	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
 
 	/*
@@ -639,11 +667,10 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
 	return 0;
 
-remove_dev_opp:
-	_remove_device_opp(dev_opp);
 free_opp:
+	_opp_remove(dev_opp, new_opp, false);
+unlock:
 	mutex_unlock(&dev_opp_list_lock);
-	kfree(new_opp);
 	return ret;
 }
 
@@ -871,7 +898,7 @@ void of_free_opp_table(struct device *dev)
 	/* Free static OPPs */
 	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
 		if (!opp->dynamic)
-			_opp_remove(dev_opp, opp);
+			_opp_remove(dev_opp, opp, true);
 	}
 
 	mutex_unlock(&dev_opp_list_lock);
-- 
2.4.0

