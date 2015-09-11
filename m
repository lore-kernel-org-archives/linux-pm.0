From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/16] PM / OPP: Disable OPPs that aren't supported by the regulators
Date: Fri, 11 Sep 2015 17:32:05 +0530
Message-ID: <2cd568e33356b2f409d6af81aaad4e2ee418b905.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Disable any OPPs where the connected regulators aren't able to provide
the specified voltage.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 42ea5a332ddc..04fe181b8132 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -834,6 +834,34 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	return ret;
 }
 
+static bool opp_supported_by_regulators(struct dev_pm_opp *opp,
+					struct device_opp *dev_opp)
+{
+	struct opp_supply *supply;
+	struct regulator *reg;
+	int count;
+
+	for (count = 0; count < dev_opp->supply_count; count++) {
+		supply = opp->supplies + count;
+		reg = dev_opp->regulators[count];
+
+		/* Regulator may not be available for device */
+		if (IS_ERR(reg))
+			continue;
+
+		if (!regulator_is_supported_voltage(reg, supply->u_volt_min,
+						    supply->u_volt_max)) {
+			pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator: %s\n",
+				__func__, supply->u_volt_min,
+				supply->u_volt_max,
+				dev_opp->supply_names[count]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 /* returns the number of entries used from microvolt */
 static void opp_parse_single_supply(struct opp_supply *supply, bool triplet,
 				    u32 *microvolt, u32 *microamp)
@@ -1016,6 +1044,12 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np,
 	if (new_opp->clock_latency_ns > dev_opp->clock_latency_ns_max)
 		dev_opp->clock_latency_ns_max = new_opp->clock_latency_ns;
 
+	if (!opp_supported_by_regulators(new_opp, dev_opp)) {
+		new_opp->available = false;
+		dev_warn(dev, "%s: OPP not supported by regulators (%lu)\n",
+			 __func__, new_opp->rate);
+	}
+
 	mutex_unlock(&dev_opp_list_lock);
 
 	supply = &new_opp->supplies[0];
-- 
2.4.0
