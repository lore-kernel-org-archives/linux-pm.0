From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/7] OPP: Break _opp_add_dynamic() into smaller functions
Date: Wed, 11 Feb 2015 16:16:26 +0800
Message-ID: <fcb800ff92057c0bc83c1ce66255d818ba34e1e2.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45104 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbBKIRE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 03:17:04 -0500
Received: by pdjz10 with SMTP id z10so2837295pdj.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 00:17:03 -0800 (PST)
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Later commits would add support for new OPP bindings and this would be required
then. So, lets do it in a separate patch to make it reviewing easy.

Another change worth noticing is INIT_LIST_HEAD(&opp->node). We weren't doing it
earlier as we never tried to delete a list node before it is added to list. But
this wouldn't be the case anymore. We might try to delete a node (just to reuse
the same code paths), without it being getting added to the list.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 127 ++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 52 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 9e2118284f02..904dcf386747 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -433,6 +433,7 @@ static void _kfree_device_rcu(struct rcu_head *head)
  * _opp_remove()  - Remove an OPP from a table definition
  * @dev_opp:	points back to the device_opp struct this opp belongs to
  * @opp:	pointer to the OPP to remove
+ * @notify:	OPP_EVENT_REMOVE notification should be sent or not
  *
  * This function removes an opp definition from the opp list.
  *
@@ -441,13 +442,14 @@ static void _kfree_device_rcu(struct rcu_head *head)
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
 
@@ -497,7 +499,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 		goto unlock;
 	}
 
-	_opp_remove(dev_opp, opp);
+	_opp_remove(dev_opp, opp, true);
 unlock:
 	mutex_unlock(&dev_opp_list_lock);
 }
@@ -533,6 +535,63 @@ static struct device_opp *_add_device_opp(struct device *dev)
 	return dev_opp;
 }
 
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
+	/* Check for existing list for 'dev' */
+	*dev_opp = _find_device_opp(dev);
+	if (IS_ERR(*dev_opp)) {
+		*dev_opp = _add_device_opp(dev);
+		if (!*dev_opp) {
+			kfree(opp);
+			return NULL;
+		}
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
@@ -563,66 +622,29 @@ static struct device_opp *_add_device_opp(struct device *dev)
 static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 			    long u_volt, bool dynamic)
 {
-	struct device_opp *dev_opp = NULL;
-	struct dev_pm_opp *opp, *new_opp;
-	struct list_head *head;
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *new_opp;
 	int ret;
 
-	/* allocate new OPP node */
-	new_opp = kzalloc(sizeof(*new_opp), GFP_KERNEL);
-	if (!new_opp) {
-		dev_warn(dev, "%s: Unable to create new OPP node\n", __func__);
-		return -ENOMEM;
-	}
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
 	new_opp->dynamic = dynamic;
 
-	/* Check for existing list for 'dev' */
-	dev_opp = _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		dev_opp = _add_device_opp(dev);
-		if (!dev_opp) {
-			ret = -ENOMEM;
-			goto free_opp;
-		}
-
-		head = &dev_opp->opp_list;
-		goto list_add;
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
-	if (new_opp->rate == opp->rate) {
-		ret = opp->available && new_opp->u_volt == opp->u_volt ?
-			0 : -EEXIST;
-
-		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
-			 __func__, opp->rate, opp->u_volt, opp->available,
-			 new_opp->rate, new_opp->u_volt, new_opp->available);
+	ret = _opp_add(new_opp, dev_opp);
+	if (ret)
 		goto free_opp;
-	}
 
-list_add:
-	new_opp->dev_opp = dev_opp;
-	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
 
 	/*
@@ -633,8 +655,9 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	return 0;
 
 free_opp:
+	_opp_remove(dev_opp, new_opp, false);
+unlock:
 	mutex_unlock(&dev_opp_list_lock);
-	kfree(new_opp);
 	return ret;
 }
 
@@ -922,7 +945,7 @@ void of_free_opp_table(struct device *dev)
 	/* Free static OPPs */
 	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
 		if (!opp->dynamic)
-			_opp_remove(dev_opp, opp);
+			_opp_remove(dev_opp, opp, true);
 	}
 
 	mutex_unlock(&dev_opp_list_lock);
-- 
2.3.0.rc0.44.ga94655d

