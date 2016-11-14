From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 4/7] iommu/exynos: Set master device once on boot
Date: Mon, 14 Nov 2016 11:08:09 +0100
Message-ID: <1479118092-1365-5-git-send-email-m.szyprowski@samsung.com>
References: <1479118092-1365-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20161114100911eucas1p15b495af346ea89af2f10bb3267b2cdc5@eucas1p1.samsung.com>
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

To avoid possible races, set master device pointer in each SYSMMU
controller once on boot. Suspend/resume callbacks now properly relies on
the configured iommu domain to enable or disable SYSMMU controller.
While changing the code, also update the sleep debug messages and make
them conditional.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index f45b274..28e570b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -600,10 +600,12 @@ static int exynos_sysmmu_suspend(struct device *dev)
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
 	struct device *master = data->master;
 
-	dev_dbg(dev, "suspend\n");
 	if (master) {
-		__sysmmu_disable(data);
 		pm_runtime_put(dev);
+		if (data->domain) {
+			dev_dbg(data->sysmmu, "saving state\n");
+			__sysmmu_disable(data);
+		}
 	}
 	return 0;
 }
@@ -613,10 +615,12 @@ static int exynos_sysmmu_resume(struct device *dev)
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
 	struct device *master = data->master;
 
-	dev_dbg(dev, "resume\n");
 	if (master) {
 		pm_runtime_get_sync(dev);
-		__sysmmu_enable(data);
+		if (data->domain) {
+			dev_dbg(data->sysmmu, "restoring state\n");
+			__sysmmu_enable(data);
+		}
 	}
 	return 0;
 }
@@ -730,7 +734,6 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 		__sysmmu_disable(data);
 		data->pgtable = 0;
 		data->domain = NULL;
-		data->master = NULL;
 		list_del_init(&data->domain_node);
 	}
 
@@ -772,7 +775,6 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
 		__sysmmu_disable(data);
-		data->master = NULL;
 		data->pgtable = 0;
 		data->domain = NULL;
 		list_del_init(&data->domain_node);
@@ -806,7 +808,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 		data->domain = domain;
 		pm_runtime_get_sync(data->sysmmu);
 		__sysmmu_enable(data);
-		data->master = dev;
 
 		spin_lock_irqsave(&domain->lock, flags);
 		list_add_tail(&data->domain_node, &domain->clients);
@@ -1192,6 +1193,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	}
 
 	list_add_tail(&data->owner_node, &owner->controllers);
+	data->master = dev;
 	return 0;
 }
 
-- 
1.9.1
