From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/8] PM / Domains: Move code from under #ifdef
	CONFIG_PM_RUNTIME
Date: Sat, 11 Jun 2011 22:37:48 +0200
Message-ID: <201106112237.48634.rjw__46622.4231095568$1307824997$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106112223.04972.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is some code in drivers/base/power/domain.c that will be useful
for both runtime PM and system-wide power transitions, so make it
depend on CONFIG_PM instead of CONFIG_PM_RUNTIME.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |  118 +++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 54 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -14,6 +14,66 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 
+#ifdef CONFIG_PM
+
+static struct generic_pm_domain *dev_to_genpd(struct device *dev)
+{
+	if (IS_ERR_OR_NULL(dev->pm_domain))
+		return ERR_PTR(-EINVAL);
+
+	return container_of(dev->pm_domain, struct generic_pm_domain, domain);
+}
+
+/**
+ * pm_genpd_poweron - Restore power to a given PM domain and its parents.
+ * @genpd: PM domain to power up.
+ *
+ * Restore power to @genpd and all of its parents so that it is possible to
+ * resume a device belonging to it.
+ */
+static int pm_genpd_poweron(struct generic_pm_domain *genpd)
+{
+	int ret = 0;
+
+ start:
+	if (genpd->parent)
+		mutex_lock(&genpd->parent->lock);
+	mutex_lock(&genpd->lock);
+
+	if (!genpd->power_is_off)
+		goto out;
+
+	if (genpd->parent && genpd->parent->power_is_off) {
+		mutex_unlock(&genpd->lock);
+		mutex_unlock(&genpd->parent->lock);
+
+		ret = pm_genpd_poweron(genpd->parent);
+		if (ret)
+			return ret;
+
+		goto start;
+	}
+
+	if (genpd->power_on) {
+		int ret = genpd->power_on(&genpd->domain);
+		if (ret)
+			goto out;
+	}
+
+	genpd->power_is_off = false;
+	if (genpd->parent)
+		genpd->parent->sd_count++;
+
+ out:
+	mutex_unlock(&genpd->lock);
+	if (genpd->parent)
+		mutex_unlock(&genpd->parent->lock);
+
+	return ret;
+}
+
+#endif /* CONFIG_PM */
+
 #ifdef CONFIG_PM_RUNTIME
 
 static void genpd_sd_counter_dec(struct generic_pm_domain *genpd)
@@ -155,11 +215,10 @@ static int pm_genpd_runtime_suspend(stru
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(dev->pm_domain))
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	genpd = container_of(dev->pm_domain, struct generic_pm_domain, domain);
-
 	if (genpd->parent)
 		mutex_lock(&genpd->parent->lock);
 	mutex_lock(&genpd->lock);
@@ -182,54 +241,6 @@ static int pm_genpd_runtime_suspend(stru
 }
 
 /**
- * pm_genpd_poweron - Restore power to a given PM domain and its parents.
- * @genpd: PM domain to power up.
- *
- * Restore power to @genpd and all of its parents so that it is possible to
- * resume a device belonging to it.
- */
-static int pm_genpd_poweron(struct generic_pm_domain *genpd)
-{
-	int ret = 0;
-
- start:
-	if (genpd->parent)
-		mutex_lock(&genpd->parent->lock);
-	mutex_lock(&genpd->lock);
-
-	if (!genpd->power_is_off)
-		goto out;
-
-	if (genpd->parent && genpd->parent->power_is_off) {
-		mutex_unlock(&genpd->lock);
-		mutex_unlock(&genpd->parent->lock);
-
-		ret = pm_genpd_poweron(genpd->parent);
-		if (ret)
-			return ret;
-
-		goto start;
-	}
-
-	if (genpd->power_on) {
-		int ret = genpd->power_on(&genpd->domain);
-		if (ret)
-			goto out;
-	}
-
-	genpd->power_is_off = false;
-	if (genpd->parent)
-		genpd->parent->sd_count++;
-
- out:
-	mutex_unlock(&genpd->lock);
-	if (genpd->parent)
-		mutex_unlock(&genpd->parent->lock);
-
-	return ret;
-}
-
-/**
  * pm_genpd_runtime_resume - Resume a device belonging to I/O PM domain.
  * @dev: Device to resume.
  *
@@ -245,11 +256,10 @@ static int pm_genpd_runtime_resume(struc
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(dev->pm_domain))
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	genpd = container_of(dev->pm_domain, struct generic_pm_domain, domain);
-
 	ret = pm_genpd_poweron(genpd);
 	if (ret)
 		return ret;
