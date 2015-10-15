From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/4] PM / OPP: Parse all power-supply related bindings together
Date: Thu, 15 Oct 2015 21:42:45 +0530
Message-ID: <10b3f112bb2863098a0ab21bcb9e951f0a8da51c.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Move all DT parsing for the power supplies to a single function, rather
than keeping them at separate places. This will help manage things
properly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 63b0f57601b8..8fa522f41226 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -772,9 +772,10 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 }
 
 /* TODO: Support multiple regulators */
-static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
+static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
 {
 	u32 microvolt[3] = {0};
+	u32 val;
 	int count, ret;
 
 	/* Missing property isn't a problem, but an invalid entry is */
@@ -807,6 +808,9 @@ static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
 	opp->u_volt_min = microvolt[1];
 	opp->u_volt_max = microvolt[2];
 
+	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
+		opp->u_amp = val;
+
 	return 0;
 }
 
@@ -871,13 +875,10 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
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
