From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/9] PM / Domains: Implement subdomain counters
	as atomic fields
Date: Sun, 31 Jul 2011 19:47:48 +0200
Message-ID: <201107311947.48268.rjw__16209.0918551714$1312137299$gmane$org@sisk.pl>
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

Currently, pm_genpd_poweron() and pm_genpd_poweroff() need to take
the parent PM domain's lock in order to modify the parent's counter
of active subdomains in a nonracy way.  This causes the locking to be
considerably complex and in fact is not necessary, because the
subdomain counters may be implemented as atomic fields and they
won't have to be modified under a lock.

Replace the unsigned in sd_count field in struct generic_pm_domain
by an atomic_t one and modify the code in drivers/base/power/domain.c
to take this change into account.

This patch doesn't change the locking yet, that is going to be done
in a separate subsequent patch.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   30 ++++++++++++++++++++----------
 include/linux/pm_domain.h   |    2 +-
 2 files changed, 21 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -29,10 +29,20 @@ static struct generic_pm_domain *dev_to_
 	return pd_to_genpd(dev->pm_domain);
 }
 
-static void genpd_sd_counter_dec(struct generic_pm_domain *genpd)
+static bool genpd_sd_counter_dec(struct generic_pm_domain *genpd)
 {
-	if (!WARN_ON(genpd->sd_count == 0))
-			genpd->sd_count--;
+	bool ret = false;
+
+	if (!WARN_ON(atomic_read(&genpd->sd_count) == 0))
+		ret = !!atomic_dec_and_test(&genpd->sd_count);
+
+	return ret;
+}
+
+static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
+{
+	atomic_inc(&genpd->sd_count);
+	smp_mb__after_atomic_inc();
 }
 
 static void genpd_acquire_lock(struct generic_pm_domain *genpd)
@@ -118,7 +128,7 @@ int pm_genpd_poweron(struct generic_pm_d
 
 	genpd_set_active(genpd);
 	if (parent)
-		parent->sd_count++;
+		genpd_sd_counter_inc(parent);
 
  out:
 	mutex_unlock(&genpd->lock);
@@ -254,7 +264,7 @@ static int pm_genpd_poweroff(struct gene
 	    || genpd->resume_count > 0)
 		return 0;
 
-	if (genpd->sd_count > 0)
+	if (atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
 	not_suspended = 0;
@@ -325,8 +335,7 @@ static int pm_genpd_poweroff(struct gene
 	genpd->status = GPD_STATE_POWER_OFF;
 
 	if (parent) {
-		genpd_sd_counter_dec(parent);
-		if (parent->sd_count == 0)
+		if (genpd_sd_counter_dec(parent))
 			genpd_queue_power_off_work(parent);
 
 		genpd_release_lock(parent);
@@ -491,7 +500,8 @@ static void pm_genpd_sync_poweroff(struc
 	if (genpd->status == GPD_STATE_POWER_OFF)
 		return;
 
-	if (genpd->suspended_count != genpd->device_count || genpd->sd_count > 0)
+	if (genpd->suspended_count != genpd->device_count
+	    || atomic_read(&genpd->sd_count) > 0)
 		return;
 
 	if (genpd->power_off)
@@ -1152,7 +1162,7 @@ int pm_genpd_add_subdomain(struct generi
 	list_add_tail(&new_subdomain->sd_node, &genpd->sd_list);
 	new_subdomain->parent = genpd;
 	if (subdomain->status != GPD_STATE_POWER_OFF)
-		genpd->sd_count++;
+		genpd_sd_counter_inc(genpd);
 
  out:
 	mutex_unlock(&new_subdomain->lock);
@@ -1227,7 +1237,7 @@ void pm_genpd_init(struct generic_pm_dom
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	genpd->in_progress = 0;
-	genpd->sd_count = 0;
+	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
 	init_waitqueue_head(&genpd->status_wait_queue);
 	genpd->poweroff_task = NULL;
Index: linux-2.6/include/linux/pm_domain.h
===================================================================
--- linux-2.6.orig/include/linux/pm_domain.h
+++ linux-2.6/include/linux/pm_domain.h
@@ -33,7 +33,7 @@ struct generic_pm_domain {
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
 	unsigned int in_progress;	/* Number of devices being suspended now */
-	unsigned int sd_count;	/* Number of subdomains with power "on" */
+	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
 	wait_queue_head_t status_wait_queue;
 	struct task_struct *poweroff_task;	/* Powering off task */
