From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: renesas: Use pm_clk_no_clocks() helper i.s.o. direct access
Date: Tue, 25 Apr 2017 19:33:58 +0200
Message-ID: <1493141638-28940-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:54802 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1952065AbdDYReB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 13:34:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The pm_subsys_data.clock_list member exists only if CONFIG_PM_CLK=y.
Hence direct accesses to this field break compile-testing on platforms
where CONFIG_PM_CLK=n.

To fix this, use the pm_clk_no_clocks() helper instead, for which a
dummy version is provided if CONFIG_PM_CLK=n.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued up in clk-renesas-for-v4.13.

 drivers/clk/renesas/clk-mstp.c         | 2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 4067216bf31fbce9..f1617dd044cbbe15 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -325,7 +325,7 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 
 void cpg_mstp_detach_dev(struct generic_pm_domain *unused, struct device *dev)
 {
-	if (!list_empty(&dev->power.subsys_data->clock_list))
+	if (!pm_clk_no_clocks(dev))
 		pm_clk_destroy(dev);
 }
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 99eeec6f24ec6c6b..38a01406740dfc04 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -477,7 +477,7 @@ int cpg_mssr_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 
 void cpg_mssr_detach_dev(struct generic_pm_domain *unused, struct device *dev)
 {
-	if (!list_empty(&dev->power.subsys_data->clock_list))
+	if (!pm_clk_no_clocks(dev))
 		pm_clk_destroy(dev);
 }
 
-- 
2.7.4
