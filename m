From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ALWAYS_ON
Date: Mon, 12 Jun 2017 11:23:46 +0200
Message-ID: <1497259427-8299-3-git-send-email-geert+renesas@glider.be>
References: <1497259427-8299-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:59002 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdFLJXy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 05:23:54 -0400
In-Reply-To: <1497259427-8299-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Improve handling of always-on PM domains by using the
GENPD_FLAG_ALWAYS_ON flag introduced in commit ffaa42e8a40b7f10 ("PM /
Domains: Enable users of genpd to specify always on PM domains").

Note that the PM domain containing the serial console is still handled
locally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 175bd3d91ebcbcb4..e5fa6a3cf1ddf159 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -130,7 +130,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	genpd->flags = GENPD_FLAG_PM_CLK;
+	genpd->flags |= GENPD_FLAG_PM_CLK;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
@@ -140,14 +140,6 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
 }
 
-static int rmobile_pd_suspend_busy(void)
-{
-	/*
-	 * This domain should not be turned off.
-	 */
-	return -EBUSY;
-}
-
 static int rmobile_pd_suspend_console(void)
 {
 	/*
@@ -260,8 +252,7 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		 * only be turned off if the CPU is not in use.
 		 */
 		pr_debug("PM domain %s contains CPU\n", name);
-		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_busy;
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 		break;
 
 	case PD_CONSOLE:
@@ -277,8 +268,7 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		 * is not in use.
 		 */
 		pr_debug("PM domain %s contains Coresight-ETM\n", name);
-		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_busy;
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 		break;
 
 	case PD_MEMCTL:
@@ -287,8 +277,7 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		 * should only be turned off if memory is not in use.
 		 */
 		pr_debug("PM domain %s contains MEMCTL\n", name);
-		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_busy;
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 		break;
 
 	case PD_NORMAL:
-- 
2.7.4
