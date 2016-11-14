From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 2/7] iommu/exynos: Remove dead code
Date: Mon, 14 Nov 2016 11:08:07 +0100
Message-ID: <1479118092-1365-3-git-send-email-m.szyprowski@samsung.com>
References: <1479118092-1365-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20161114100909eucas1p1bc6b64109f463f12879b2e3eccb76434@eucas1p1.samsung.com>
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

__sysmmu_enable/disable functions were designed to do ref-count based
operations, but current code always calls them only once, so the code for
checking the conditions and invalid conditions can be simply removed
without any influence to the driver operation.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 65 ++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8ba0d60..4056228 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -460,9 +460,6 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 		__sysmmu_disable_nocount(data);
 
 		dev_dbg(data->sysmmu, "Disabled\n");
-	} else  {
-		dev_dbg(data->sysmmu, "%d times left to disable\n",
-					data->activations);
 	}
 
 	spin_unlock_irqrestore(&data->lock, flags);
@@ -508,29 +505,18 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
 			   struct exynos_iommu_domain *domain)
 {
-	int ret = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
 		data->domain = domain;
-
 		__sysmmu_enable_nocount(data);
-
 		dev_dbg(data->sysmmu, "Enabled\n");
-	} else {
-		ret = (pgtable == data->pgtable) ? 1 : -EBUSY;
-
-		dev_dbg(data->sysmmu, "already enabled\n");
 	}
-
-	if (WARN_ON(ret < 0))
-		set_sysmmu_inactive(data); /* decrement count */
-
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	return ret;
+	return 0;
 }
 
 static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
@@ -793,8 +779,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 	spin_lock_irqsave(&domain->lock, flags);
 
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
-		if (__sysmmu_disable(data))
-			data->master = NULL;
+		__sysmmu_disable(data);
+		data->master = NULL;
 		list_del_init(&data->domain_node);
 	}
 
@@ -829,31 +815,23 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
-	bool found = false;
 
 	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
 		return;
 
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
-		if (data->master == dev) {
-			if (__sysmmu_disable(data)) {
-				data->master = NULL;
-				list_del_init(&data->domain_node);
-			}
-			pm_runtime_put(data->sysmmu);
-			found = true;
-		}
+		__sysmmu_disable(data);
+		data->master = NULL;
+		list_del_init(&data->domain_node);
+		pm_runtime_put(data->sysmmu);
 	}
 	spin_unlock_irqrestore(&domain->lock, flags);
 
 	owner->domain = NULL;
 
-	if (found)
-		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
-					__func__, &pagetable);
-	else
-		dev_err(dev, "%s: No IOMMU is attached\n", __func__);
+	dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n", __func__,
+		&pagetable);
 }
 
 static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
@@ -864,7 +842,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	struct sysmmu_drvdata *data;
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	unsigned long flags;
-	int ret = -ENODEV;
 
 	if (!has_sysmmu(dev))
 		return -ENODEV;
@@ -874,27 +851,19 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
 		pm_runtime_get_sync(data->sysmmu);
-		ret = __sysmmu_enable(data, pagetable, domain);
-		if (ret >= 0) {
-			data->master = dev;
+		__sysmmu_enable(data, pagetable, domain);
+		data->master = dev;
 
-			spin_lock_irqsave(&domain->lock, flags);
-			list_add_tail(&data->domain_node, &domain->clients);
-			spin_unlock_irqrestore(&domain->lock, flags);
-		}
-	}
-
-	if (ret < 0) {
-		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
-					__func__, &pagetable);
-		return ret;
+		spin_lock_irqsave(&domain->lock, flags);
+		list_add_tail(&data->domain_node, &domain->clients);
+		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 
 	owner->domain = iommu_domain;
-	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa %s\n",
-		__func__, &pagetable, (ret == 0) ? "" : ", again");
+	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n", __func__,
+		&pagetable);
 
-	return ret;
+	return 0;
 }
 
 static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
-- 
1.9.1
