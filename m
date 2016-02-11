From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PM / OPP: Fix NULL pointer dereference crash when disabling OPPs
Date: Thu, 11 Feb 2016 11:25:59 +0000
Message-ID: <1455189959-27944-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Commit 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by
the regulator") disables OPPs that are not supported by the regulator.
This is causes a crash on Tegra124 Jetson TK1 when using the DFLL clock
source for the CPU. The DFLL manages the voltage itself and so there is
no regulator specified for the OPPs and so we get a crash when we try to
dereference the regulator pointer. Fix this by checking to see if the
regulator IS_ERR_OR_NULL before dereferencing it.

Fixes: 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by the
regulator")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index ab711c2c3e00..d7cd4e265766 100644
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
2.1.4
