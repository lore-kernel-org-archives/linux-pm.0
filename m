From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 05/16] PM / OPP: Allocate dev_opp from _add_device_opp()
Date: Wed, 29 Jul 2015 16:23:00 +0530
Message-ID: <532b81932a18771d53c529ea80cb035b540cd68c.1438166099.git.viresh.kumar@linaro.org>
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

There is no need to complicate _opp_add_dynamic() with allocation of
dev_opp as well. Allocate it from _add_device_opp() instead.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 50 ++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 7895fdd64192..28d70c9f86ed 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -408,11 +408,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
 /**
- * _add_device_opp() - Allocate a new device OPP table
+ * _add_device_opp() - Find device OPP table or allocate a new one
  * @dev:	device for which we do this operation
  *
- * New device node which uses OPPs - used when multiple devices with OPP tables
- * are maintained.
+ * It tries to find an existing table first, if it couldn't find one, it
+ * allocates a new OPP table and returns that.
  *
  * Return: valid device_opp pointer if success, else NULL.
  */
@@ -420,6 +420,11 @@ static struct device_opp *_add_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 
+	/* Check for existing list for 'dev' first */
+	dev_opp = _find_device_opp(dev);
+	if (!IS_ERR(dev_opp))
+		return dev_opp;
+
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
 	 * device is needed to be added, we pay this penalty.
@@ -575,7 +580,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 			    long u_volt, bool dynamic)
 {
-	struct device_opp *dev_opp = NULL;
+	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp, *new_opp;
 	struct list_head *head;
 	int ret;
@@ -592,19 +597,11 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	new_opp->rate = freq;
 	new_opp->u_volt = u_volt;
 	new_opp->available = true;
-	new_opp->dynamic = dynamic;
-
-	/* Check for existing list for 'dev' */
-	dev_opp = _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		dev_opp = _add_device_opp(dev);
-		if (!dev_opp) {
-			ret = -ENOMEM;
-			goto free_opp;
-		}
 
-		head = &dev_opp->opp_list;
-		goto list_add;
+	dev_opp = _add_device_opp(dev);
+	if (!dev_opp) {
+		ret = -ENOMEM;
+		goto free_opp;
 	}
 
 	/*
@@ -612,15 +609,22 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	 * and discard if already present
 	 */
 	head = &dev_opp->opp_list;
+
+	/*
+	 * Need to use &dev_opp->opp_list in the condition part of the 'for'
+	 * loop, don't replace it with head otherwise it will become an infinite
+	 * loop.
+	 */
 	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
-		if (new_opp->rate <= opp->rate)
-			break;
-		else
+		if (new_opp->rate > opp->rate) {
 			head = &opp->node;
-	}
+			continue;
+		}
+
+		if (new_opp->rate < opp->rate)
+			break;
 
-	/* Duplicate OPPs ? */
-	if (new_opp->rate == opp->rate) {
+		/* Duplicate OPPs */
 		ret = opp->available && new_opp->u_volt == opp->u_volt ?
 			0 : -EEXIST;
 
@@ -630,7 +634,7 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 		goto free_opp;
 	}
 
-list_add:
+	new_opp->dynamic = dynamic;
 	new_opp->dev_opp = dev_opp;
 	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
-- 
2.4.0
