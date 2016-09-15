From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / OPP: avoid maybe-uninitialized warning
Date: Thu, 15 Sep 2016 17:38:38 +0200
Message-ID: <20160915153917.3001855-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:62200 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbcIOPjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 11:39:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

When CONFIG_OPTIMIZE_INLINING is set and we are building with -Wmaybe-uninitialized
enabled, we can get a warning for the opp core driver:

drivers/base/power/opp/core.c: In function 'dev_pm_opp_set_rate':
drivers/base/power/opp/core.c:560:8: warning: 'ou_volt_min' may be used uninitialized in this function [-Wmaybe-uninitialized]

This has only now appeared as a result of commit 797da5598f3a ("PM / devfreq:
Add COMPILE_TEST for build coverage"), which makes the driver visible in
some configurations that didn't have it before.

The warning is a false positive that I got with gcc-6.1.1, but there is
a simple workaround in removing the local variables that we get warnings
for (all three are affected depending on the configuration). This also
makes the code easier to read.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/base/power/opp/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index df0c70963d9e..4c7c6da7a989 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -584,7 +584,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct clk *clk;
 	unsigned long freq, old_freq;
 	unsigned long u_volt, u_volt_min, u_volt_max;
-	unsigned long ou_volt, ou_volt_min, ou_volt_max;
 	int ret;
 
 	if (unlikely(!target_freq)) {
@@ -620,11 +619,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	old_opp = _find_freq_ceil(opp_table, &old_freq);
-	if (!IS_ERR(old_opp)) {
-		ou_volt = old_opp->u_volt;
-		ou_volt_min = old_opp->u_volt_min;
-		ou_volt_max = old_opp->u_volt_max;
-	} else {
+	if (IS_ERR(old_opp)) {
 		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
 			__func__, old_freq, PTR_ERR(old_opp));
 	}
@@ -683,7 +678,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
 	if (!IS_ERR(old_opp))
-		_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
+		_set_opp_voltage(dev, reg, old_opp->u_volt,
+				 old_opp->u_volt_min, old_opp->u_volt_max);
 
 	return ret;
 }
-- 
2.9.0

