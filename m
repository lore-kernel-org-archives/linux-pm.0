From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 7/7] iommu/exynos: Use device dependency links to control
 runtime pm
Date: Thu, 20 Oct 2016 09:22:53 +0200
Message-ID: <1476948173-21093-8-git-send-email-m.szyprowski@samsung.com>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161020072336eucas1p24a2b020f69b6ae1f55e1760e6e0e94f9@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch uses recently introduced device dependency links to track the
runtime pm state of the master's device. This way each SYSMMU controller
is set to runtime active only when its master's device is active and can
restore or save its state instead of being activated all the time when
attached to the given master device. This way SYSMMU controllers no longer
prevents respective power domains to be turned off when master's device
is not being used.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 5e6d7bbf9b70..59b4f2ce4f5f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -781,10 +781,6 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
 		return;
 
-	list_for_each_entry(data, &owner->controllers, owner_node) {
-		pm_runtime_put_sync(data->sysmmu);
-	}
-
 	mutex_lock(&owner->rpm_lock);
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
@@ -848,10 +844,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 
 	mutex_unlock(&owner->rpm_lock);
 
-	list_for_each_entry(data, &owner->controllers, owner_node) {
-		pm_runtime_get_sync(data->sysmmu);
-	}
-
 	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n", __func__,
 		&pagetable);
 
@@ -1232,6 +1224,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
 
 	list_add_tail(&data->owner_node, &owner->controllers);
 	data->master = dev;
+
+	/*
+	 * SYSMMU will be runtime activated via device link (dependency) to its
+	 * master device, so there are no direct calls to pm_runtime_get/put
+	 * in this driver.
+	 */
+	device_link_add(dev, data->sysmmu, DL_FLAG_PM_RUNTIME);
+
 	return 0;
 }
 
-- 
1.9.1
