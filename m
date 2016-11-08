From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v6 6/7] iommu/exynos: Add runtime pm support
Date: Tue, 08 Nov 2016 14:29:23 +0100
Message-ID: <1478611764-6473-7-git-send-email-m.szyprowski@samsung.com>
References: <1478611764-6473-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161108133018eucas1p27180e82ae25189bda573766251491e66@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1478611764-6473-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch adds runtime pm implementation, which is based on previous
suspend/resume code. SYSMMU controller is now being enabled/disabled mainly
from the runtime pm callbacks. System sleep callbacks relies on generic
pm_runtime_force_suspend/pm_runtime_force_resume helpers. To ensure
internal state consistency, additional lock for runtime pm transitions
was introduced.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 45 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a959443..5e6d7bb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -206,6 +206,7 @@ struct sysmmu_fault_info {
 struct exynos_iommu_owner {
 	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
 	struct iommu_domain *domain;	/* domain this device is attached */
+	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
 };
 
 /*
@@ -594,40 +595,46 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int exynos_sysmmu_suspend(struct device *dev)
+static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
 	struct device *master = data->master;
 
 	if (master) {
-		pm_runtime_put(dev);
+		struct exynos_iommu_owner *owner = master->archdata.iommu;
+
+		mutex_lock(&owner->rpm_lock);
 		if (data->domain) {
 			dev_dbg(data->sysmmu, "saving state\n");
 			__sysmmu_disable(data);
 		}
+		mutex_unlock(&owner->rpm_lock);
 	}
 	return 0;
 }
 
-static int exynos_sysmmu_resume(struct device *dev)
+static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
 	struct device *master = data->master;
 
 	if (master) {
-		pm_runtime_get_sync(dev);
+		struct exynos_iommu_owner *owner = master->archdata.iommu;
+
+		mutex_lock(&owner->rpm_lock);
 		if (data->domain) {
 			dev_dbg(data->sysmmu, "restoring state\n");
 			__sysmmu_enable(data);
 		}
+		mutex_unlock(&owner->rpm_lock);
 	}
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sysmmu_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume)
+	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 };
 
 static const struct of_device_id sysmmu_of_match[] __initconst = {
@@ -775,7 +782,15 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 		return;
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
-		__sysmmu_disable(data);
+		pm_runtime_put_sync(data->sysmmu);
+	}
+
+	mutex_lock(&owner->rpm_lock);
+
+	list_for_each_entry(data, &owner->controllers, owner_node) {
+		pm_runtime_get_noresume(data->sysmmu);
+		if (pm_runtime_active(data->sysmmu))
+			__sysmmu_disable(data);
 		pm_runtime_put(data->sysmmu);
 	}
 
@@ -790,6 +805,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 	owner->domain = NULL;
 	spin_unlock_irqrestore(&domain->lock, flags);
 
+	mutex_unlock(&owner->rpm_lock);
 
 	dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n", __func__,
 		&pagetable);
@@ -810,6 +826,8 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	if (owner->domain)
 		exynos_iommu_detach_device(owner->domain, dev);
 
+	mutex_lock(&owner->rpm_lock);
+
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(data, &owner->controllers, owner_node) {
 		spin_lock(&data->lock);
@@ -822,8 +840,16 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
+		pm_runtime_get_noresume(data->sysmmu);
+		if (pm_runtime_active(data->sysmmu))
+			__sysmmu_enable(data);
+		pm_runtime_put(data->sysmmu);
+	}
+
+	mutex_unlock(&owner->rpm_lock);
+
+	list_for_each_entry(data, &owner->controllers, owner_node) {
 		pm_runtime_get_sync(data->sysmmu);
-		__sysmmu_enable(data);
 	}
 
 	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n", __func__,
@@ -1200,6 +1226,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
 			return -ENOMEM;
 
 		INIT_LIST_HEAD(&owner->controllers);
+		mutex_init(&owner->rpm_lock);
 		dev->archdata.iommu = owner;
 	}
 
-- 
1.9.1
