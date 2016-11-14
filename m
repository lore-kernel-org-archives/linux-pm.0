From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 5/7] iommu/exynos: Rework and fix internal locking
Date: Mon, 14 Nov 2016 11:08:10 +0100
Message-ID: <1479118092-1365-6-git-send-email-m.szyprowski@samsung.com>
References: <1479118092-1365-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20161114100912eucas1p18aed36d2573319e00bd232b0eedf9489@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1479118092-1365-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch reworks locking in the exynos_iommu_attach/detach_device
functions to ensure that all entries of the sysmmu_drvdata and
exynos_iommu_owner structure are updated under the respective spinlocks,
while runtime pm functions are called without any spinlocks held.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 28e570b..a959443 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -731,10 +731,12 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 	spin_lock_irqsave(&domain->lock, flags);
 
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
+		spin_lock(&data->lock);
 		__sysmmu_disable(data);
 		data->pgtable = 0;
 		data->domain = NULL;
 		list_del_init(&data->domain_node);
+		spin_unlock(&data->lock);
 	}
 
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -772,17 +774,22 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
 		return;
 
+	list_for_each_entry(data, &owner->controllers, owner_node) {
+		__sysmmu_disable(data);
+		pm_runtime_put(data->sysmmu);
+	}
+
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
-		__sysmmu_disable(data);
+		spin_lock(&data->lock);
 		data->pgtable = 0;
 		data->domain = NULL;
 		list_del_init(&data->domain_node);
-		pm_runtime_put(data->sysmmu);
+		spin_unlock(&data->lock);
 	}
+	owner->domain = NULL;
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	owner->domain = NULL;
 
 	dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n", __func__,
 		&pagetable);
@@ -803,18 +810,22 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	if (owner->domain)
 		exynos_iommu_detach_device(owner->domain, dev);
 
+	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(data, &owner->controllers, owner_node) {
+		spin_lock(&data->lock);
 		data->pgtable = pagetable;
 		data->domain = domain;
+		list_add_tail(&data->domain_node, &domain->clients);
+		spin_unlock(&data->lock);
+	}
+	owner->domain = iommu_domain;
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	list_for_each_entry(data, &owner->controllers, owner_node) {
 		pm_runtime_get_sync(data->sysmmu);
 		__sysmmu_enable(data);
-
-		spin_lock_irqsave(&domain->lock, flags);
-		list_add_tail(&data->domain_node, &domain->clients);
-		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 
-	owner->domain = iommu_domain;
 	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n", __func__,
 		&pagetable);
 
-- 
1.9.1
