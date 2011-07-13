From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] ARM / shmobile: Use
	genpd_queue_power_off_work()
Date: Wed, 13 Jul 2011 23:54:18 +0200
Message-ID: <201107132354.18324.rjw__40796.231912873$1310594498$gmane$org@sisk.pl>
References: <201107132352.59801.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107132352.59801.rjw@sisk.pl>
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

Make pd_power_down_a3rv() use genpd_queue_power_off_work() to queue
up the powering off of the A4LC domain to avoid queuing it up when
it is pending.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm-sh7372.c |    2 +-
 drivers/base/power/domain.c        |    2 +-
 include/linux/pm_domain.h          |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
@@ -107,7 +107,7 @@ static int pd_power_down_a3rv(struct gen
 
 	/* try to power down A4LC after A3RV is requested off */
 	pm_genpd_poweron(&sh7372_a4lc.genpd);
-	queue_work(pm_wq, &sh7372_a4lc.genpd.power_off_work);
+	genpd_queue_power_off_work(&sh7372_a4lc.genpd);
 
 	return ret;
 }
Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -222,7 +222,7 @@ static bool genpd_abort_poweroff(struct
  * Queue up the execution of pm_genpd_poweroff() unless it's already been done
  * before.
  */
-static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 {
 	if (!work_pending(&genpd->power_off_work))
 		queue_work(pm_wq, &genpd->power_off_work);
Index: linux-2.6/include/linux/pm_domain.h
===================================================================
--- linux-2.6.orig/include/linux/pm_domain.h
+++ linux-2.6/include/linux/pm_domain.h
@@ -73,6 +73,7 @@ extern void pm_genpd_init(struct generic
 			  struct dev_power_governor *gov, bool is_off);
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern void pm_genpd_poweroff_unused(void);
+extern void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
 #else
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 				      struct device *dev)
@@ -101,6 +102,7 @@ static inline int pm_genpd_poweron(struc
 	return -ENOSYS;
 }
 static inline void pm_genpd_poweroff_unused(void) {}
+static inline void genpd_queue_power_off_work(struct generic_pm_domain *gpd) {}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
