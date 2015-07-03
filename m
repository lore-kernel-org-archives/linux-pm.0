From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/10] OPP: Allocate dev_opp from _add_device_opp()
Date: Fri, 3 Jul 2015 12:15:54 +0530
Message-ID: <20150703064554.GB4564@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <83bd3b9837b30bab62f41aed3dd2cdf52cc21688.1434369079.git.viresh.kumar@linaro.org>
 <55948DB0.8060500@codeaurora.org>
 <20150702062455.GD31684@linux>
 <5595CD68.9040701@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35335 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbGCGqC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 02:46:02 -0400
Received: by pactm7 with SMTP id tm7so52588971pac.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2015 23:46:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5595CD68.9040701@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 02-07-15, 16:46, Stephen Boyd wrote:
> Looking better.

And does this look perfect ? :)

------------------8<----------------

Message-Id: <7c23b93b6b328e0b14b5c5096c3c3322e3d8ee4b.1435905782.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 12 Jun 2015 12:43:14 +0530
Subject: [PATCH] OPP: Allocate dev_opp from _add_device_opp()

There is no need to complicate _opp_add_dynamic() with allocation of
dev_opp as well. Allocate it from _add_device_opp() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 60 +++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 7895fdd64192..5869a8524244 100644
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
@@ -613,24 +610,25 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	 */
 	head = &dev_opp->opp_list;
 	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
-		if (new_opp->rate <= opp->rate)
-			break;
-		else
+		if (new_opp->rate > opp->rate) {
 			head = &opp->node;
+		} else if (new_opp->rate < opp->rate) {
+			break;
+		} else {
+			/* Duplicate OPPs */
+			ret = opp->available && new_opp->u_volt == opp->u_volt ?
+				0 : -EEXIST;
+
+			dev_warn(dev,
+				 "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
+				 __func__, opp->rate, opp->u_volt,
+				 opp->available, new_opp->rate, new_opp->u_volt,
+				 new_opp->available);
+			goto free_opp;
+		}
 	}
 
-	/* Duplicate OPPs ? */
-	if (new_opp->rate == opp->rate) {
-		ret = opp->available && new_opp->u_volt == opp->u_volt ?
-			0 : -EEXIST;
-
-		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
-			 __func__, opp->rate, opp->u_volt, opp->available,
-			 new_opp->rate, new_opp->u_volt, new_opp->available);
-		goto free_opp;
-	}
-
-list_add:
+	new_opp->dynamic = dynamic;
 	new_opp->dev_opp = dev_opp;
 	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
