From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/16] PM / OPP: Parse all power-supply related bindings together
Date: Fri, 11 Sep 2015 17:32:01 +0530
Message-ID: <6269be0aac00ae0d1549db9be93472b951636ef6.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34462 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbbIKMCw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 08:02:52 -0400
Received: by padhy16 with SMTP id hy16so73623386pad.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2015 05:02:52 -0700 (PDT)
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

Move all DT parsing for the power supplies to a single function, rather
than keeping them at separate places. This will help manage things
properly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 6bebc503d727..463417b6838c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -787,9 +787,10 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 }
 
 /* TODO: Support multiple regulators */
-static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
+static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 {
 	u32 microvolt[3] = {0};
+	u32 val;
 	int count, ret;
 
 	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
@@ -815,6 +816,9 @@ static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
 	opp->u_volt_min = microvolt[1];
 	opp->u_volt_max = microvolt[2];
 
+	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
+		opp->u_amp = val;
+
 	return 0;
 }
 
@@ -879,13 +883,10 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
-	ret = opp_get_microvolt(new_opp, dev);
+	ret = opp_parse_supplies(new_opp, dev);
 	if (ret)
 		goto free_opp;
 
-	if (!of_property_read_u32(new_opp->np, "opp-microamp", &val))
-		new_opp->u_amp = val;
-
 	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)
 		goto free_opp;
-- 
2.4.0

