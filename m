From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 05/11] OPP: Break _opp_add_dynamic() into smaller functions
Date: Mon, 27 Jul 2015 10:32:35 +0530
Message-ID: <87cd2aebefc834f92b75c5bc4e64a83646998fae.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Later commits would add support for new OPP bindings and this would be
required then. So, lets do it in a separate patch to make it easily
reviewable.

Another change worth noticing is INIT_LIST_HEAD(&opp->node). We weren't
doing it earlier as we never tried to delete a list node before it is
added to list. But this wouldn't be the case anymore. We might try to
delete a node (just to reuse the same code paths), without it being
getting added to the list.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 109 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 40 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 901b6c77a791..962d62316b80 100644
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
 
@@ -544,12 +546,63 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
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
+	struct dev_pm_opp *opp;
+	struct list_head *head = &dev_opp->opp_list;
+
+	/*
+	 * Insert new OPP in order of increasing frequency
+	 * and discard if already present.
+	 */
+	list_for_each_entry_rcu(opp, head, node) {
+		if (new_opp->rate > opp->rate)
+			head = &opp->node;
+		else if (new_opp->rate < opp->rate)
+			break;
+
+		/* Duplicate OPPs */
+		dev_warn(dev_opp->dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
+			 __func__, opp->rate, opp->u_volt, opp->available,
+			 new_opp->rate, new_opp->u_volt, new_opp->available);
+
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
@@ -581,53 +634,28 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 			    long u_volt, bool dynamic)
 {
 	struct device_opp *dev_opp;
-	struct dev_pm_opp *opp, *new_opp;
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
-		goto free_opp;
-	}
-
-	/*
-	 * Insert new OPP in order of increasing frequency
-	 * and discard if already present
-	 */
-	head = &dev_opp->opp_list;
-	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
-		if (new_opp->rate > opp->rate)
-			head = &opp->node;
-		else if (new_opp->rate < opp->rate)
-			break;
-
-		/* Duplicate OPPs */
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
 
-	new_opp->dynamic = dynamic;
-	new_opp->dev_opp = dev_opp;
-	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
 
 	/*
@@ -638,8 +666,9 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	return 0;
 
 free_opp:
+	_opp_remove(dev_opp, new_opp, false);
+unlock:
 	mutex_unlock(&dev_opp_list_lock);
-	kfree(new_opp);
 	return ret;
 }
 
@@ -867,7 +896,7 @@ void of_free_opp_table(struct device *dev)
 	/* Free static OPPs */
 	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
 		if (!opp->dynamic)
-			_opp_remove(dev_opp, opp);
+			_opp_remove(dev_opp, opp, true);
 	}
 
 	mutex_unlock(&dev_opp_list_lock);
-- 
2.4.0
