From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/9] PM / Domains: Add "wait for parent" status
	for generic PM domains
Date: Sun, 31 Jul 2011 19:49:58 +0200
Message-ID: <201107311949.58790.rjw__2255.55856382034$1312134839$gmane$org@sisk.pl>
References: <201107311946.06654.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107311946.06654.rjw@sisk.pl>
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

The next patch will make it possible for a generic PM domain to have
multiple parents (i.e. multiple PM domains it depends on).  To
prepare for that change it is necessary to change pm_genpd_poweron()
so that it doesn't jump to the start label after running itself
recursively for the parent domain.  For this purpose, introduce a new
PM domain status value GPD_STATE_WAIT_PARENT that will be set by
pm_genpd_poweron() before calling itself recursively for the parent
domain and modify the code in drivers/base/power/domain.c so that
the GPD_STATE_WAIT_PARENT status is guaranteed to be preserved during
the execution of pm_genpd_poweron() for the parent.

This change also causes pm_genpd_add_subdomain() and
pm_genpd_remove_subdomain() to wait for started pm_genpd_poweron() to
complete and allows pm_genpd_runtime_resume() to avoid dropping the
lock after powering on the PM domain.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   90 +++++++++++++++++++++++++++++---------------
 include/linux/pm_domain.h   |    1 
 2 files changed, 61 insertions(+), 30 deletions(-)

Index: linux-2.6/include/linux/pm_domain.h
===================================================================
--- linux-2.6.orig/include/linux/pm_domain.h
+++ linux-2.6/include/linux/pm_domain.h
@@ -13,6 +13,7 @@
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
+	GPD_STATE_WAIT_PARENT,	/* PM domain's parent is being waited for */
 	GPD_STATE_BUSY,		/* Something is happening to the PM domain */
 	GPD_STATE_REPEAT,	/* Power off in progress, to be repeated */
 	GPD_STATE_POWER_OFF,	/* PM domain is off */
Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -81,45 +81,59 @@ static void genpd_set_active(struct gene
 }
 
 /**
- * pm_genpd_poweron - Restore power to a given PM domain and its parents.
+ * __pm_genpd_poweron - Restore power to a given PM domain and its parents.
  * @genpd: PM domain to power up.
  *
  * Restore power to @genpd and all of its parents so that it is possible to
  * resume a device belonging to it.
  */
-int pm_genpd_poweron(struct generic_pm_domain *genpd)
+int __pm_genpd_poweron(struct generic_pm_domain *genpd)
+	__releases(&genpd->lock) __acquires(&genpd->lock)
 {
-	struct generic_pm_domain *parent;
+	DEFINE_WAIT(wait);
 	int ret = 0;
 
-	mutex_lock(&genpd->lock);
+	/* If the domain's parent is being waited for, we have to wait too. */
+	for (;;) {
+		prepare_to_wait(&genpd->status_wait_queue, &wait,
+				TASK_UNINTERRUPTIBLE);
+		if (genpd->status != GPD_STATE_WAIT_PARENT)
+			break;
+		mutex_unlock(&genpd->lock);
 
-	parent = genpd->parent;
+		schedule();
+
+		mutex_lock(&genpd->lock);
+	}
+	finish_wait(&genpd->status_wait_queue, &wait);
 
- start:
 	if (genpd->status == GPD_STATE_ACTIVE
 	    || (genpd->prepared_count > 0 && genpd->suspend_power_off))
-		goto out;
+		return 0;
 
 	if (genpd->status != GPD_STATE_POWER_OFF) {
 		genpd_set_active(genpd);
-		goto out;
+		return 0;
 	}
 
-	if (parent) {
-		genpd_sd_counter_inc(parent);
+	if (genpd->parent) {
+		genpd_sd_counter_inc(genpd->parent);
+		genpd->status = GPD_STATE_WAIT_PARENT;
 
 		mutex_unlock(&genpd->lock);
 
-		ret = pm_genpd_poweron(parent);
+		ret = pm_genpd_poweron(genpd->parent);
 
 		mutex_lock(&genpd->lock);
 
+		/*
+		 * The "wait for parent" status is guaranteed not to change
+		 * while the parent is powering on.
+		 */
+		genpd->status = GPD_STATE_POWER_OFF;
+		wake_up_all(&genpd->status_wait_queue);
 		if (ret)
 			goto err;
-
-		parent = NULL;
-		goto start;
 	}
 
 	if (genpd->power_on) {
@@ -130,16 +144,27 @@ int pm_genpd_poweron(struct generic_pm_d
 
 	genpd_set_active(genpd);
 
- out:
-	mutex_unlock(&genpd->lock);
-
-	return ret;
+	return 0;
 
  err:
 	if (genpd->parent)
 		genpd_sd_counter_dec(genpd->parent);
 
-	goto out;
+	return ret;
+}
+
+/**
+ * pm_genpd_poweron - Restore power to a given PM domain and its parents.
+ * @genpd: PM domain to power up.
+ */
+int pm_genpd_poweron(struct generic_pm_domain *genpd)
+{
+	int ret;
+
+	mutex_lock(&genpd->lock);
+	ret = __pm_genpd_poweron(genpd);
+	mutex_unlock(&genpd->lock);
+	return ret;
 }
 
 #endif /* CONFIG_PM */
@@ -225,7 +250,8 @@ static void __pm_genpd_restore_device(st
  */
 static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
 {
-	return genpd->status == GPD_STATE_ACTIVE || genpd->resume_count > 0;
+	return genpd->status == GPD_STATE_WAIT_PARENT
+		|| genpd->status == GPD_STATE_ACTIVE || genpd->resume_count > 0;
 }
 
 /**
@@ -261,11 +287,13 @@ static int pm_genpd_poweroff(struct gene
 	/*
 	 * Do not try to power off the domain in the following situations:
 	 * (1) The domain is already in the "power off" state.
-	 * (2) System suspend is in progress.
+	 * (2) The domain is waiting for its parent to power up.
 	 * (3) One of the domain's devices is being resumed right now.
+	 * (4) System suspend is in progress.
 	 */
-	if (genpd->status == GPD_STATE_POWER_OFF || genpd->prepared_count > 0
-	    || genpd->resume_count > 0)
+	if (genpd->status == GPD_STATE_POWER_OFF
+	    || genpd->status == GPD_STATE_WAIT_PARENT
+	    || genpd->resume_count > 0 || genpd->prepared_count > 0)
 		return 0;
 
 	if (atomic_read(&genpd->sd_count) > 0)
@@ -299,14 +327,15 @@ static int pm_genpd_poweroff(struct gene
 	list_for_each_entry_reverse(dle, &genpd->dev_list, node) {
 		ret = atomic_read(&genpd->sd_count) == 0 ?
 			__pm_genpd_save_device(dle, genpd) : -EBUSY;
+
+		if (genpd_abort_poweroff(genpd))
+			goto out;
+
 		if (ret) {
 			genpd_set_active(genpd);
 			goto out;
 		}
 
-		if (genpd_abort_poweroff(genpd))
-			goto out;
-
 		if (genpd->status == GPD_STATE_REPEAT) {
 			genpd->poweroff_task = NULL;
 			goto start;
@@ -432,11 +461,12 @@ static int pm_genpd_runtime_resume(struc
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	ret = pm_genpd_poweron(genpd);
-	if (ret)
-		return ret;
-
 	mutex_lock(&genpd->lock);
+	ret = __pm_genpd_poweron(genpd);
+	if (ret) {
+		mutex_unlock(&genpd->lock);
+		return ret;
+	}
 	genpd->status = GPD_STATE_BUSY;
 	genpd->resume_count++;
 	for (;;) {
