From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] PM / OPP: of_property_count_u32_elems() can return errors
Date: Tue, 22 Sep 2015 09:35:31 -0700
Message-ID: <3ad0ce115028e628e556a505689d396b6e98f04e.1442939340.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33260 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758607AbbIVQft (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 12:35:49 -0400
Received: by pacex6 with SMTP id ex6so13691720pac.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 09:35:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

of_property_count_u32_elems() will never return 0, but a -ve error value
of a positive count. And so the current !count check is wrong.

Also, a missing "opp-microvolt" property isn't a problem and so we need
to do of_find_property() separately to confirm that.

Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Dropped 'prop' variable.

 drivers/base/power/opp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 28cd75c535b0..1194669c2bb5 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -892,10 +892,17 @@ static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
 	u32 microvolt[3] = {0};
 	int count, ret;
 
-	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
-	if (!count)
+	/* Missing property isn't a problem, but an invalid entry is */
+	if (!of_find_property(opp->np, "opp-microvolt", NULL))
 		return 0;
 
+	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
+	if (count < 0) {
+		dev_err(dev, "%s: Invalid opp-microvolt property (%d)\n",
+			__func__, count);
+		return count;
+	}
+
 	/* There can be one or three elements here */
 	if (count != 1 && count != 3) {
 		dev_err(dev, "%s: Invalid number of elements in opp-microvolt property (%d)\n",
-- 
2.4.0

