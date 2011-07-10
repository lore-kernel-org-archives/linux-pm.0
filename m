From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] ARM / shmobile: Use
	pm_genpd_poweroff_unused()
Date: Sun, 10 Jul 2011 22:47:44 +0200
Message-ID: <201107102247.45034.rjw__14747.8769570172$1310330989$gmane$org@sisk.pl>
References: <201107102246.05107.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107102246.05107.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make shmobile use pm_genpd_poweroff_unused() instead of the
open-coded powering off PM domains without devices in use.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/include/mach/common.h |    1 -
 arch/arm/mach-shmobile/pm-sh7372.c           |   13 -------------
 arch/arm/mach-shmobile/pm_runtime.c          |    6 ++----
 3 files changed, 2 insertions(+), 18 deletions(-)

Index: linux-2.6/arch/arm/mach-shmobile/include/mach/common.h
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/include/mach/common.h
+++ linux-2.6/arch/arm/mach-shmobile/include/mach/common.h
@@ -12,7 +12,6 @@ extern struct platform_suspend_ops shmob
 struct cpuidle_device;
 extern void (*shmobile_cpuidle_modes[])(void);
 extern void (*shmobile_cpuidle_setup)(struct cpuidle_device *dev);
-extern void (*shmobile_runtime_pm_late_init)(void);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
Index: linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
@@ -126,17 +126,6 @@ static bool pd_active_wakeup(struct devi
 	return true;
 }
 
-static void sh7372_late_pm_domain_off(void)
-{
-	/* request power down of unused pm domains */
-	queue_work(pm_wq, &sh7372_a4lc.genpd.power_off_work);
-	queue_work(pm_wq, &sh7372_a4mp.genpd.power_off_work);
-	queue_work(pm_wq, &sh7372_d4.genpd.power_off_work);
-	queue_work(pm_wq, &sh7372_a3rv.genpd.power_off_work);
-	queue_work(pm_wq, &sh7372_a3ri.genpd.power_off_work);
-	queue_work(pm_wq, &sh7372_a3sg.genpd.power_off_work);
-}
-
 void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd)
 {
 	struct generic_pm_domain *genpd = &sh7372_pd->genpd;
@@ -157,8 +146,6 @@ void sh7372_init_pm_domain(struct sh7372
 		genpd->power_on = pd_power_up;
 	}
 	genpd->power_on(&sh7372_pd->genpd);
-
-	shmobile_runtime_pm_late_init = sh7372_late_pm_domain_off;
 }
 
 void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
Index: linux-2.6/arch/arm/mach-shmobile/pm_runtime.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/pm_runtime.c
+++ linux-2.6/arch/arm/mach-shmobile/pm_runtime.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/sh_clk.h>
@@ -57,12 +58,9 @@ static int __init sh_pm_runtime_init(voi
 }
 core_initcall(sh_pm_runtime_init);
 
-void (*shmobile_runtime_pm_late_init)(void);
-
 static int __init sh_pm_runtime_late_init(void)
 {
-	if (shmobile_runtime_pm_late_init)
-		shmobile_runtime_pm_late_init();
+	pm_genpd_poweroff_unused();
 	return 0;
 }
 late_initcall(sh_pm_runtime_late_init);
