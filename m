From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 7/7] iommu/exynos: Use device dependency links to control
	runtime pm
Date: Mon, 14 Nov 2016 11:08:12 +0100
Message-ID: <1479118092-1365-8-git-send-email-m.szyprowski@samsung.com>
References: <1479118092-1365-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20161114100913eucas1p13d380f351985e8401a054c48bd13e299@eucas1p1.samsung.com>
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

This patch uses recently introduced device dependency links to track the
runtime pm state of the master's device. The goal is to let SYSMMU
controller device's runtime PM to follow the runtime PM state of the
respective master's device. This way each SYSMMU controller is active
only when its master's device is active and can properly restore or save
its state instead on runtime PM transition of master's device.
This approach replaces old behavior, when SYSMMU controller was set to
runtime active once after attaching to the master device. In the new
approach SYSMMU controllers no longer prevents respective power domains
to be turned off when master's device is not being used.

This patch reduces total power consumption of idle system, because most
power domains can be finally turned off. For example, on Exynos 4412
based Odroid U3 this patch reduces power consuption from 136mA to 130mA
at 5V (by 4.4%).

The dependency links also enforce proper order of suspending/restoring
devices during system sleep transition, so there is no more need to use
LATE_SYSTEM_SLEEP_PM_OPS-based workaround for ensuring that SYSMMUs are
suspended after their master devices.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 5e6d7bb..4b05a15 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -633,8 +633,8 @@ static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
 
 static const struct dev_pm_ops sysmmu_pm_ops = {
 	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				     pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static const struct of_device_id sysmmu_of_match[] __initconst = {
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
