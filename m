From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 02/16] PM / OPP: Disable OPPs that aren't supported by the regulator
Date: Tue,  9 Feb 2016 10:30:34 +0530
Message-ID: <4046978926e8e61e56489e8ed348d1725cbfd499.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35377 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcBIFBP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 00:01:15 -0500
Received: by mail-pf0-f178.google.com with SMTP id c10so54663889pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 21:01:14 -0800 (PST)
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

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
2.7.1.370.gb2aa7f8

