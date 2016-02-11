From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] PM / OPP: Fix NULL pointer dereference when no regulator is
 defined
Date: Thu, 11 Feb 2016 17:13:07 +0100
Message-ID: <6387373.HWURUPOrgK@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47057 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbcBKQNz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 11:13:55 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Commit 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't
supported by the regulator") causes NULL pointer dereference
OOPS when no regulator for OPP is defined.  Fix it by
replacing IS_ERR() check with IS_ERR_OR_NULL() one (since
providing regulator for OPP is optional).

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Fixes: 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by the regulator")
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
This fixes linux-pm/linux-next tree boot hang regression on
Exynos4412 SoC based Odroid-U3 board.

Rafael, please apply.  Thank you!

 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index ab711c2..d7cd4e2 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -975,7 +975,7 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 {
 	struct regulator *reg = dev_opp->regulator;
 
-	if (!IS_ERR(reg) &&
+	if (!IS_ERR_OR_NULL(reg) &&
 	    !regulator_is_supported_voltage(reg, opp->u_volt_min,
 					    opp->u_volt_max)) {
 		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
-- 
1.9.1


