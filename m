From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 4/7] iommu/exynos: Set master device once on boot
Date: Thu, 20 Oct 2016 09:22:50 +0200
Message-ID: <1476948173-21093-5-git-send-email-m.szyprowski@samsung.com>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161020072333eucas1p25b638379091939f10b3c9eb5d89a031e@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pm@vger.kernel.org

To avoid possible races, set master device pointer in each SYSMMU
controller once on boot. Suspend/resume callbacks now properly relies on
the configured iommu domain to enable or disable SYSMMU controller.
While changing the code, also update the sleep debug messages and make
them conditional.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index f45b274513cc..28e570b53672 100644
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
