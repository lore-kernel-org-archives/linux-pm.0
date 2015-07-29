From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 06/16] PM / OPP: Break _opp_add_dynamic() into smaller
 functions
Date: Wed, 29 Jul 2015 16:23:01 +0530
Message-ID: <f5778b7bf5d30d888297c9e2fd7097901e9c47d9.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: nm@ti.com, ta.omasab@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, mturquette@baylibre.com, khilman@linaro.org, Pavel Machek <pavel@ucw.cz>, rob.herring@linaro.org, kesavan.abhilash@gmail.com, b.zolnierkie@samsung.com, arnd.bergmann@linaro.org, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, santosh.shilimkar@oracle.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, viswanath.puttagunta@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, Sudeep.Holla@arm.com, l.stach@pengutronix.de
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
 drivers/base/power/opp.c | 125 ++++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 49 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 28d70c9f86ed..0d8dbf21c299 100644
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
 
@@ -544,12 +546,70 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
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
+	 * Insert new OPP in order of increasing frequency and discard if
+	 * already present.
+	 *
+	 * Need to use &dev_opp->opp_list in the condition part of the 'for'
+	 * loop, don't replace it with head otherwise it will become an infinite
+	 * loop.
+	 */
+	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+		if (new_opp->rate > opp->rate) {
+			head = &opp->node;
+			continue;
+		}
+
+		if (new_opp->rate < opp->rate)
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
@@ -581,62 +641,28 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
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
-
-	/*
-	 * Need to use &dev_opp->opp_list in the condition part of the 'for'
-	 * loop, don't replace it with head otherwise it will become an infinite
-	 * loop.
-	 */
-	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
-		if (new_opp->rate > opp->rate) {
-			head = &opp->node;
-			continue;
-		}
-
-		if (new_opp->rate < opp->rate)
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
@@ -647,8 +673,9 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	return 0;
 
 free_opp:
+	_opp_remove(dev_opp, new_opp, false);
+unlock:
 	mutex_unlock(&dev_opp_list_lock);
-	kfree(new_opp);
 	return ret;
 }
 
@@ -876,7 +903,7 @@ void of_free_opp_table(struct device *dev)
 	/* Free static OPPs */
 	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
 		if (!opp->dynamic)
-			_opp_remove(dev_opp, opp);
+			_opp_remove(dev_opp, opp, true);
 	}
 
 	mutex_unlock(&dev_opp_list_lock);
-- 
2.4.0
