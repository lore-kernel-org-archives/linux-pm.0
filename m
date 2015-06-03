From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 1/3] PM / Domains: Allocate memory outside domain locks
Date: Wed, 3 Jun 2015 15:55:13 +0000 (UTC)
Message-ID: <1433456946-53296-2-git-send-email-lina.iyer__49465.9888944172$1433346913$gmane$org@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Date: Thu,  4 Jun 2015 16:29:04 -0600
In-Reply-To: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: mathieu.poirier@linaro.org, linux-pm@vger.kernel.org, galak@codeaurora.org, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

In order for domains to be powered on/off in irq locked context, the
domain locks could either be a spinlock or a mutex, depending on the
domain. In preparation for atomic support, allocate domain data outside
the domain locks, so the allocation calls dont have to be context
sensitive.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3b3367b..dfd7595 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1367,13 +1367,17 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *subdomain)
 {
-	struct gpd_link *link;
+	struct gpd_link *link, *itr;
 	int ret = 0;
 
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
 	    || genpd == subdomain)
 		return -EINVAL;
 
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
 	mutex_lock(&genpd->lock);
 	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
 
@@ -1383,18 +1387,13 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 		goto out;
 	}
 
-	list_for_each_entry(link, &genpd->master_links, master_node) {
-		if (link->slave == subdomain && link->master == genpd) {
+	list_for_each_entry(itr, &genpd->master_links, master_node) {
+		if (itr->slave == subdomain && itr->master == genpd) {
 			ret = -EINVAL;
 			goto out;
 		}
 	}
 
-	link = kzalloc(sizeof(*link), GFP_KERNEL);
-	if (!link) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	link->master = genpd;
 	list_add_tail(&link->master_node, &genpd->master_links);
 	link->slave = subdomain;
@@ -1496,17 +1495,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	if (IS_ERR_OR_NULL(genpd) || state < 0)
 		return -EINVAL;
 
+	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
+	if (!cpuidle_data)
+		return -ENOMEM;
+
 	mutex_lock(&genpd->lock);
 
 	if (genpd->cpuidle_data) {
 		ret = -EEXIST;
 		goto out;
 	}
-	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
-	if (!cpuidle_data) {
-		ret = -ENOMEM;
-		goto out;
-	}
+
 	cpuidle_drv = cpuidle_driver_ref();
 	if (!cpuidle_drv) {
 		ret = -ENODEV;
-- 
2.1.4
