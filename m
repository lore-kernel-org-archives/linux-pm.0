From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/9] PM / Domains: Make pm_genpd_poweron() always
	survive parent removal
Date: Sun, 31 Jul 2011 19:49:12 +0200
Message-ID: <201107311949.12503.rjw@sisk.pl>
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

If pm_genpd_remove_subdomain() is called to remove a PM domain's
subdomain and pm_genpd_poweron() is called for that subdomain at
the same time, and the pm_genpd_poweron() called by it recursively
for the parent returns an error, the first pm_genpd_poweron()'s
error code path will attempt to decrement the subdomain counter of
a PM domain that it's not a subdomain of any more.

Rearrange the code in pm_genpd_poweron() to prevent this from
happening.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -89,12 +89,14 @@ static void genpd_set_active(struct gene
  */
 int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
-	struct generic_pm_domain *parent = genpd->parent;
+	struct generic_pm_domain *parent;
 	int ret = 0;
 
- start:
 	mutex_lock(&genpd->lock);
 
+	parent = genpd->parent;
+
+ start:
 	if (genpd->status == GPD_STATE_ACTIVE
 	    || (genpd->prepared_count > 0 && genpd->suspend_power_off))
 		goto out;
@@ -110,29 +112,34 @@ int pm_genpd_poweron(struct generic_pm_d
 		mutex_unlock(&genpd->lock);
 
 		ret = pm_genpd_poweron(parent);
-		if (ret) {
-			genpd_sd_counter_dec(parent);
-			return ret;
-		}
+
+		mutex_lock(&genpd->lock);
+
+		if (ret)
+			goto err;
 
 		parent = NULL;
 		goto start;
 	}
 
-	if (genpd->power_on)
+	if (genpd->power_on) {
 		ret = genpd->power_on(genpd);
-
-	if (ret) {
-		if (genpd->parent)
-			genpd_sd_counter_dec(genpd->parent);
-	} else {
-		genpd_set_active(genpd);
+		if (ret)
+			goto err;
 	}
 
+	genpd_set_active(genpd);
+
  out:
 	mutex_unlock(&genpd->lock);
 
 	return ret;
+
+ err:
+	if (genpd->parent)
+		genpd_sd_counter_dec(genpd->parent);
+
+	goto out;
 }
 
 #endif /* CONFIG_PM */
