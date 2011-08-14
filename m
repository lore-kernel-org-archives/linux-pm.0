From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Domains: Fix build for CONFIG_PM_RUNTIME
	unset
Date: Sun, 14 Aug 2011 16:04:44 +0200
Message-ID: <201108141604.44304.rjw__46961.9281976067$1313330645$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Function genpd_queue_power_off_work() is not defined for
CONFIG_PM_RUNTIME, so pm_genpd_poweroff_unused() causes a build
error to happen in that case.  Fix the problem by making
pm_genpd_poweroff_unused() depend on CONFIG_PM_RUNTIME too.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

This is 3.1 material if no one objects.

Thanks,
Rafael

---
 drivers/base/power/domain.c |   30 +++++++++++++++---------------
 include/linux/pm_domain.h   |   10 +++++++---
 kernel/power/Kconfig        |    4 ++++
 3 files changed, 26 insertions(+), 18 deletions(-)

Index: linux/include/linux/pm_domain.h
===================================================================
--- linux.orig/include/linux/pm_domain.h
+++ linux/include/linux/pm_domain.h
@@ -72,8 +72,6 @@ extern int pm_genpd_remove_subdomain(str
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
-extern void pm_genpd_poweroff_unused(void);
-extern void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
 #else
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 				      struct device *dev)
@@ -101,8 +99,14 @@ static inline int pm_genpd_poweron(struc
 {
 	return -ENOSYS;
 }
-static inline void pm_genpd_poweroff_unused(void) {}
+#endif
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_RUNTIME
+extern void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
+extern void pm_genpd_poweroff_unused(void);
+#else
 static inline void genpd_queue_power_off_work(struct generic_pm_domain *gpd) {}
+static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
Index: linux/drivers/base/power/domain.c
===================================================================
--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -460,6 +460,21 @@ static int pm_genpd_runtime_resume(struc
 	return 0;
 }
 
+/**
+ * pm_genpd_poweroff_unused - Power off all PM domains with no devices in use.
+ */
+void pm_genpd_poweroff_unused(void)
+{
+	struct generic_pm_domain *genpd;
+
+	mutex_lock(&gpd_list_lock);
+
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+		genpd_queue_power_off_work(genpd);
+
+	mutex_unlock(&gpd_list_lock);
+}
+
 #else
 
 static inline void genpd_power_off_work_fn(struct work_struct *work) {}
@@ -1255,18 +1270,3 @@ void pm_genpd_init(struct generic_pm_dom
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
 }
-
-/**
- * pm_genpd_poweroff_unused - Power off all PM domains with no devices in use.
- */
-void pm_genpd_poweroff_unused(void)
-{
-	struct generic_pm_domain *genpd;
-
-	mutex_lock(&gpd_list_lock);
-
-	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
-		genpd_queue_power_off_work(genpd);
-
-	mutex_unlock(&gpd_list_lock);
-}
Index: linux/kernel/power/Kconfig
===================================================================
--- linux.orig/kernel/power/Kconfig
+++ linux/kernel/power/Kconfig
@@ -231,3 +231,7 @@ config PM_CLK
 config PM_GENERIC_DOMAINS
 	bool
 	depends on PM
+
+config PM_GENERIC_DOMAINS_RUNTIME
+	def_bool y
+	depends on PM_RUNTIME && PM_GENERIC_DOMAINS
