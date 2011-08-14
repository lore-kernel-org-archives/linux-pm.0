From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update x2][PATCH 9/9] ARM / shmobile: Make A3RV be a
	subdomain of A4LC on SH7372
Date: Sun, 14 Aug 2011 16:07:08 +0200
Message-ID: <201108141607.08447.rjw__22058.8761069395$1313330782$gmane$org@sisk.pl>
References: <201107311946.06654.rjw@sisk.pl> <201107311952.51969.rjw@sisk.pl>
	<201108132143.47649.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108132143.47649.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ARM / shmobile: Make A3RV be a subdomain of A4LC on SH7372

Instead of coding the undocumented dependencies between power domains
A3RV and A4LC on SH7372 directly into the low-level power up/down
routines, make A3RV be a subdomain of A4LC, which will cause the
same dependecies to hold.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

It also needs to build for CONFIG_PM unset.

Thanks,
Rafael

---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    3 +
 arch/arm/mach-shmobile/pm-sh7372.c           |   48 ++++-----------------------
 arch/arm/mach-shmobile/setup-sh7372.c        |    3 +
 3 files changed, 14 insertions(+), 40 deletions(-)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
===================================================================
--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -91,35 +91,6 @@ static int pd_power_up(struct generic_pm
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
-	genpd_queue_power_off_work(&sh7372_a4lc.genpd);
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
-	return -EBUSY;
-}
-
 static bool pd_active_wakeup(struct device *dev)
 {
 	return true;
@@ -133,17 +104,8 @@ void sh7372_init_pm_domain(struct sh7372
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
 
@@ -159,6 +121,12 @@ void sh7372_add_device_to_domain(struct
 	pm_genpd_add_device(&sh7372_pd->genpd, dev);
 }
 
+void sh7372_pm_add_subdomain(struct sh7372_pm_domain *sh7372_pd,
+			     struct sh7372_pm_domain *sh7372_sd)
+{
+	pm_genpd_add_subdomain(&sh7372_pd->genpd, &sh7372_sd->genpd);
+}
+
 struct sh7372_pm_domain sh7372_a4lc = {
 	.bit_shift = 1,
 };
Index: linux/arch/arm/mach-shmobile/setup-sh7372.c
===================================================================
--- linux.orig/arch/arm/mach-shmobile/setup-sh7372.c
+++ linux/arch/arm/mach-shmobile/setup-sh7372.c
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
 
+	sh7372_pm_add_subdomain(&sh7372_a4lc, &sh7372_a3rv);
+
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
Index: linux/arch/arm/mach-shmobile/include/mach/sh7372.h
===================================================================
--- linux.orig/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ linux/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -494,9 +494,12 @@ extern struct sh7372_pm_domain sh7372_a3
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
 extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
 					struct platform_device *pdev);
+extern void sh7372_pm_add_subdomain(struct sh7372_pm_domain *sh7372_pd,
+				    struct sh7372_pm_domain *sh7372_sd);
 #else
 #define sh7372_init_pm_domain(pd) do { } while(0)
 #define sh7372_add_device_to_domain(pd, pdev) do { } while(0)
+#define sh7372_pm_add_subdomain(pd, sd) do { } while(0)
 #endif /* CONFIG_PM */
 
 #endif /* __ASM_SH7372_H__ */
