From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Mon, 15 Feb 2016 21:56:42 +0530
Message-ID: <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36148 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcBOQ1E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 11:27:04 -0500
Received: by mail-pa0-f43.google.com with SMTP id yy13so87908701pab.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 08:27:03 -0800 (PST)
In-Reply-To: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org

We are currently required to do two checks for regulator pointer:
IS_ERR() and IS_NULL().

And multiple instances are reported, about both of these not being used
consistently and so resulting in crashes.

Fix that by initializing regulator pointer with an error value and
checking it only against an error.

This makes code consistent and efficient.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d7cd4e265766..146b6197d598 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -257,7 +257,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	}
 
 	reg = dev_opp->regulator;
-	if (IS_ERR_OR_NULL(reg)) {
+	if (IS_ERR(reg)) {
 		/* Regulator may not be required for device */
 		if (reg)
 			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
@@ -798,6 +798,9 @@ static struct device_opp *_add_device_opp(struct device *dev)
 		of_node_put(np);
 	}
 
+	/* Set regulator to a non-NULL error value */
+	dev_opp->regulator = ERR_PTR(-EFAULT);
+
 	/* Find clk for the device */
 	dev_opp->clk = clk_get(dev, NULL);
 	if (IS_ERR(dev_opp->clk)) {
@@ -845,7 +848,7 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->prop_name)
 		return;
 
-	if (!IS_ERR_OR_NULL(dev_opp->regulator))
+	if (!IS_ERR(dev_opp->regulator))
 		return;
 
 	/* Release clk */
@@ -975,7 +978,7 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 {
 	struct regulator *reg = dev_opp->regulator;
 
-	if (!IS_ERR_OR_NULL(reg) &&
+	if (!IS_ERR(reg) &&
 	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
 					    opp->u_volt_max)) {
 		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
@@ -1435,7 +1438,7 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name)
 	}
 
 	/* Already have a regulator set */
-	if (WARN_ON(!IS_ERR_OR_NULL(dev_opp->regulator))) {
+	if (WARN_ON(!IS_ERR(dev_opp->regulator))) {
 		ret = -EBUSY;
 		goto err;
 	}
@@ -1486,7 +1489,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
 		goto unlock;
 	}
 
-	if (IS_ERR_OR_NULL(dev_opp->regulator)) {
+	if (IS_ERR(dev_opp->regulator)) {
 		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
 		goto unlock;
 	}
@@ -1495,7 +1498,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
 	WARN_ON(!list_empty(&dev_opp->opp_list));
 
 	regulator_put(dev_opp->regulator);
-	dev_opp->regulator = ERR_PTR(-EINVAL);
+	dev_opp->regulator = ERR_PTR(-EFAULT);
 
 	/* Try freeing device_opp if this was the last blocking resource */
 	_remove_device_opp(dev_opp);
-- 
2.7.1.410.g6faf27b

