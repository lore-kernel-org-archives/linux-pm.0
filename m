From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/15] power-supply: Don't return -EINVAL from __power_supply_find_supply_from_node()
Date: Thu,  4 Sep 2014 17:31:30 +0530
Message-ID: <a683e3d78c79fd00c88dbd7cb63819ee55d43dfc.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46517 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:52 -0400
Received: by mail-pd0-f178.google.com with SMTP id y13so13421498pdi.23
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:49 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

We need to stop 'class_for_each_device' loop when a supply matches with the
of-node. In order to achieve this we currently return -EINVAL from
__power_supply_populate_supplied_from() on successful match.

class_for_each_device() is free to return similar errors in other cases as well
and so the choice of return value here isn't particularly great.

This commit isn't removing the Hack but making it more elegant by returning '1'
instead.

Also power_supply_find_supply_from_node() can return errors other than
-EPROBE_DEFER now if class_for_each_device() fails.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index ab1cf8b..55140eb 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -161,9 +161,9 @@ static int  __power_supply_find_supply_from_node(struct device *dev,
 	struct device_node *np = data;
 	struct power_supply *epsy = dev_get_drvdata(dev);
 
-	/* return error breaks out of class_for_each_device loop */
+	/* returning non-zero breaks out of class_for_each_device loop */
 	if (epsy->of_node == np)
-		return -EINVAL;
+		return 1;
 
 	return 0;
 }
@@ -186,15 +186,19 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 		return -EPROBE_DEFER;
 
 	/*
-	 * We have to treat the return value as inverted, because if
-	 * we return error on not found, then it won't continue looking.
-	 * So we trick it by returning error on success to stop looking
-	 * once the matching device is found.
+	 * class_for_each_device() either returns its own errors or values
+	 * returned by __power_supply_find_supply_from_node().
+	 *
+	 * __power_supply_find_supply_from_node() will return 0 (no match)
+	 * or 1 (match).
+	 *
+	 * We return 0 if class_for_each_device() returned 1, -EPROBE_DEFER if
+	 * it returned 0, or error as returned by it.
 	 */
 	error = class_for_each_device(power_supply_class, NULL, supply_node,
 				       __power_supply_find_supply_from_node);
 
-	return error ? 0 : -EPROBE_DEFER;
+	return error ? (error == 1 ? 0 : error) : -EPROBE_DEFER;
 }
 
 static int power_supply_check_supplies(struct power_supply *psy)
-- 
2.0.3.693.g996b0fd

