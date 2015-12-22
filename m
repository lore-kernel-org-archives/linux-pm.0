From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/17] PM / OPP: Disable OPPs that aren't supported by the regulator
Date: Tue, 22 Dec 2015 15:46:04 +0530
Message-ID: <b3edc6d769720792791bda5701545f019d7a9329.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34488 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKQf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:16:35 -0500
Received: by mail-pf0-f181.google.com with SMTP id u7so57921868pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:16:35 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

Disable any OPPs where the connected regulator isn't able to provide the
specified voltage.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 76232ee04cc6..12066d3def38 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -701,6 +701,22 @@ static struct dev_pm_opp *_allocate_opp(struct device *dev,
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
@@ -742,6 +758,12 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
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
2.7.0.rc1.186.g94414c4

