From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 04/11] OPP: Allocate dev_opp from _add_device_opp()
Date: Mon, 27 Jul 2015 10:32:34 +0530
Message-ID: <1b6eba9446126e95d06bce73596d24bbdc14505e.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34741 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbG0FDf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 01:03:35 -0400
Received: by pdbbh15 with SMTP id bh15so45260408pdb.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 22:03:35 -0700 (PDT)
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

There is no need to complicate _opp_add_dynamic() with allocation of
dev_opp as well. Allocate it from _add_device_opp() instead.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 7895fdd64192..901b6c77a791 100644
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
@@ -613,14 +610,12 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	 */
 	head = &dev_opp->opp_list;
 	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
-		if (new_opp->rate <= opp->rate)
-			break;
-		else
+		if (new_opp->rate > opp->rate)
 			head = &opp->node;
-	}
+		else if (new_opp->rate < opp->rate)
+			break;
 
-	/* Duplicate OPPs ? */
-	if (new_opp->rate == opp->rate) {
+		/* Duplicate OPPs */
 		ret = opp->available && new_opp->u_volt == opp->u_volt ?
 			0 : -EEXIST;
 
@@ -630,7 +625,7 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 		goto free_opp;
 	}
 
-list_add:
+	new_opp->dynamic = dynamic;
 	new_opp->dev_opp = dev_opp;
 	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
-- 
2.4.0

