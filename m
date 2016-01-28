From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/16] PM / OPP: Disable OPPs that aren't supported by the regulator
Date: Thu, 28 Jan 2016 13:50:31 +0530
Message-ID: <16ba415d52ce9c967201f9fca1385014334e1be3.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

Disable any OPPs where the connected regulator isn't able to provide the
specified voltage.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 1e22b71abf1e..71545becfca1 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -687,6 +687,22 @@ static struct dev_pm_opp *_allocate_opp(struct device *dev,
 	return opp;
 }
 
+static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
+					 struct device_opp *dev_opp)
+{
+	struct regulator *reg = dev_opp->regulator;
+
+	if (!IS_ERR(reg) &&
+	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
+					    opp->u_volt_max)) {
+		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
+			__func__, opp->u_volt_min, opp->u_volt_max);
+		return false;
+	}
+
+	return true;
+}
+
 static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		    struct device_opp *dev_opp)
 {
@@ -728,6 +744,12 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
 			__func__, ret);
 
+	if (!_opp_supported_by_regulators(new_opp, dev_opp)) {
+		new_opp->available = false;
+		dev_warn(dev, "%s: OPP not supported by regulators (%lu)\n",
+			 __func__, new_opp->rate);
+	}
+
 	return 0;
 }
 
-- 
2.7.0.79.gdc08a19
