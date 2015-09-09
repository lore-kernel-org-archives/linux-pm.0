From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Return suspend_opp only if it is enabled
Date: Wed,  9 Sep 2015 16:58:22 +0530
Message-ID: <31e1c19352d71233ef4aebda265ef341e1e4dcb6.1441798015.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35048 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbbIIL2a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 07:28:30 -0400
Received: by pacfv12 with SMTP id fv12so8064598pac.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 04:28:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

There is no point returning suspend_opp, if it is disabled by the core.
As we can't use it at all. Fix it.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Fixes: 4eafbd15b6c8 ("PM / OPP: add dev_pm_opp_get_suspend_opp() helper")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 3d948eabf3a7..28cd75c535b0 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -345,7 +345,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
  * @dev:	device for which we do this operation
  *
  * Return: This function returns pointer to the suspend opp if it is
- * defined, otherwise it returns NULL.
+ * defined and available, otherwise it returns NULL.
  *
  * Locking: This function must be called under rcu_read_lock(). opp is a rcu
  * protected pointer. The reason for the same is that the opp pointer which is
@@ -356,17 +356,15 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
 struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
-	struct dev_pm_opp *opp;
 
 	opp_rcu_lockdep_assert();
 
 	dev_opp = _find_device_opp(dev);
-	if (IS_ERR(dev_opp))
-		opp = NULL;
-	else
-		opp = dev_opp->suspend_opp;
+	if (IS_ERR(dev_opp) || !dev_opp->suspend_opp ||
+	    !dev_opp->suspend_opp->available)
+		return NULL;
 
-	return opp;
+	return dev_opp->suspend_opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp);
 
-- 
2.4.0

