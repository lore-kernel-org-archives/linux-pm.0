From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: of_property_count_u32_elems() can return errors
Date: Thu, 17 Sep 2015 22:30:22 +0530
Message-ID: <46a47430b8d65f509d47fe3ad1264c6b23086d61.1442508974.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33138 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbIQRAc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 13:00:32 -0400
Received: by pacex6 with SMTP id ex6so24750745pac.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2015 10:00:31 -0700 (PDT)
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
For 4.3.

 drivers/base/power/opp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 28cd75c535b0..2048164d6c53 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -889,13 +889,22 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 /* TODO: Support multiple regulators */
 static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
 {
+	struct property *prop;
 	u32 microvolt[3] = {0};
 	int count, ret;
 
-	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
-	if (!count)
+	/* Missing property isn't a problem, but an invalid entry is */
+	prop = of_find_property(opp->np, "opp-microvolt", NULL);
+	if (!prop)
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

