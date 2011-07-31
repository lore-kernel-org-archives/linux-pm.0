From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/9] PM / Domains: Rename second argument of
	pm_genpd_add_subdomain()
Date: Sun, 31 Jul 2011 19:52:16 +0200
Message-ID: <201107311952.16664.rjw__26390.129645779$1312134857$gmane$org@sisk.pl>
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

Change the name of the second argument of pm_genpd_add_subdomain()
so that it is (a) shorter and (b) in agreement with the name of
the second argument of pm_genpd_add_subdomain().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -1163,36 +1163,36 @@ int pm_genpd_remove_device(struct generi
 /**
  * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
  * @genpd: Master PM domain to add the subdomain to.
- * @new_subdomain: Subdomain to be added.
+ * @subdomain: Subdomain to be added.
  */
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
-			   struct generic_pm_domain *new_subdomain)
+			   struct generic_pm_domain *subdomain)
 {
 	struct gpd_link *link;
 	int ret = 0;
 
-	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(new_subdomain))
+	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
  start:
 	genpd_acquire_lock(genpd);
-	mutex_lock_nested(&new_subdomain->lock, SINGLE_DEPTH_NESTING);
+	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
 
-	if (new_subdomain->status != GPD_STATE_POWER_OFF
-	    && new_subdomain->status != GPD_STATE_ACTIVE) {
-		mutex_unlock(&new_subdomain->lock);
+	if (subdomain->status != GPD_STATE_POWER_OFF
+	    && subdomain->status != GPD_STATE_ACTIVE) {
+		mutex_unlock(&subdomain->lock);
 		genpd_release_lock(genpd);
 		goto start;
 	}
 
 	if (genpd->status == GPD_STATE_POWER_OFF
-	    &&  new_subdomain->status != GPD_STATE_POWER_OFF) {
+	    &&  subdomain->status != GPD_STATE_POWER_OFF) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
-		if (link->slave == new_subdomain && link->master == genpd) {
+		if (link->slave == subdomain && link->master == genpd) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -1205,13 +1205,13 @@ int pm_genpd_add_subdomain(struct generi
 	}
 	link->master = genpd;
 	list_add_tail(&link->master_node, &genpd->master_links);
-	link->slave = new_subdomain;
-	list_add_tail(&link->slave_node, &new_subdomain->slave_links);
-	if (new_subdomain->status != GPD_STATE_POWER_OFF)
+	link->slave = subdomain;
+	list_add_tail(&link->slave_node, &subdomain->slave_links);
+	if (subdomain->status != GPD_STATE_POWER_OFF)
 		genpd_sd_counter_inc(genpd);
 
  out:
-	mutex_unlock(&new_subdomain->lock);
+	mutex_unlock(&subdomain->lock);
 	genpd_release_lock(genpd);
 
 	return ret;
