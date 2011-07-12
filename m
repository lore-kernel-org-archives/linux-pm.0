From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ARM / shmobile: Make A3RV be a subdomain of A4LC
	on SH7372
Date: Wed, 13 Jul 2011 00:40:02 +0200
Message-ID: <201107130040.02752.rjw__36527.9728816406$1310510418$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Instead of coding the undocumented dependencies between power domains
A3RV and A4LC on SH7372 directly into the low-level power up/down
routines, make A3RV be a subdomain of A4LC, which will cause the
same dependecies to hold.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

This patch hasn't been tested yet, so caveat emptor!

Thanks,
Rafael

---
 arch/arm/mach-shmobile/pm-sh7372.c    |   43 +---------------------------------
 arch/arm/mach-shmobile/setup-sh7372.c |    3 ++
 2 files changed, 5 insertions(+), 41 deletions(-)

Index: linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
@@ -91,36 +91,6 @@ static int pd_power_up(struct generic_pm
 	return ret;
 }
 
-static int pd_power_up_a3rv(struct generic_pm_domain *genpd)
-{
-	int ret = pd_power_up(genpd);
-
-	/* force A4LC on after A3RV has been requested on */
-	pm_genpd_poweron(&sh7372_a4lc.genpd);
-
-	return ret;
-}
-
-static int pd_power_down_a3rv(struct generic_pm_domain *genpd)
-{
-	int ret = pd_power_down(genpd);
-
-	/* try to power down A4LC after A3RV is requested off */
-	pm_genpd_poweron(&sh7372_a4lc.genpd);
-	queue_work(pm_wq, &sh7372_a4lc.genpd.power_off_work);
-
-	return ret;
-}
-
-static int pd_power_down_a4lc(struct generic_pm_domain *genpd)
-{
-	/* only power down A4LC if A3RV is off */
-	if (!(__raw_readl(PSTR) & (1 << sh7372_a3rv.bit_shift)))
-		return pd_power_down(genpd);
-
-	return 0;
-}
-
 static bool pd_active_wakeup(struct device *dev)
 {
 	return true;
@@ -134,17 +104,8 @@ void sh7372_init_pm_domain(struct sh7372
 	genpd->stop_device = pm_clk_suspend;
 	genpd->start_device = pm_clk_resume;
 	genpd->active_wakeup = pd_active_wakeup;
-
-	if (sh7372_pd == &sh7372_a4lc) {
-		genpd->power_off = pd_power_down_a4lc;
-		genpd->power_on = pd_power_up;
-	} else if (sh7372_pd == &sh7372_a3rv) {
-		genpd->power_off = pd_power_down_a3rv;
-		genpd->power_on = pd_power_up_a3rv;
-	} else {
-		genpd->power_off = pd_power_down;
-		genpd->power_on = pd_power_up;
-	}
+	genpd->power_off = pd_power_down;
+	genpd->power_on = pd_power_up;
 	genpd->power_on(&sh7372_pd->genpd);
 }
 
Index: linux-2.6/arch/arm/mach-shmobile/setup-sh7372.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/setup-sh7372.c
+++ linux-2.6/arch/arm/mach-shmobile/setup-sh7372.c
@@ -30,6 +30,7 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
+#include <linux/pm_domain.h>
 #include <mach/hardware.h>
 #include <mach/sh7372.h>
 #include <asm/mach-types.h>
@@ -848,6 +849,8 @@ void __init sh7372_add_standard_devices(
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
 
+	pm_genpd_add_subdomain(&sh7372_a4lc.genpd, &sh7372_a3sg.genpd);
+
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
