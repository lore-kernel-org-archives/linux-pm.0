From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 2/2] iommu/exynos: Add proper runtime pm support
Date: Thu, 29 Sep 2016 10:12:31 +0200
Message-ID: <1475136751-31340-3-git-send-email-m.szyprowski@samsung.com>
References: <1475136751-31340-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20160929081240eucas1p231c1ab5c5936886cbec6bc3f5267c940@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1475136751-31340-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch uses recently introduced device links to track the runtime pm
state of the master's device. This way each SYSMMU controller is runtime
activated when its master's device is active and can save/restore its state
instead of being enabled all the time. This way SYSMMU controllers no
longer prevents respective power domains to be turned off when master's
device is not used.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 225 ++++++++++++++++++-------------------------
 1 file changed, 94 insertions(+), 131 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index dfb44034b4ee..c8926e030713 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -206,6 +206,7 @@ static const struct sysmmu_fault_info sysmmu_v5_faults[] = {
 struct exynos_iommu_owner {
 	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
 	struct iommu_domain *domain;	/* domain this device is attached */
+	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
 };
 
 /*
@@ -237,8 +238,8 @@ struct sysmmu_drvdata {
 	struct clk *aclk;		/* SYSMMU's aclk clock */
 	struct clk *pclk;		/* SYSMMU's pclk clock */
 	struct clk *clk_master;		/* master's device clock */
-	int activations;		/* number of calls to sysmmu_enable */
 	spinlock_t lock;		/* lock for modyfying state */
+	int active;			/* current status */
 	struct exynos_iommu_domain *domain; /* domain we belong to */
 	struct list_head domain_node;	/* node for domain clients list */
 	struct list_head owner_node;	/* node for owner controllers list */
@@ -251,25 +252,6 @@ static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
 	return container_of(dom, struct exynos_iommu_domain, domain);
 }
 
-static bool set_sysmmu_active(struct sysmmu_drvdata *data)
-{
-	/* return true if the System MMU was not active previously
-	   and it needs to be initialized */
-	return ++data->activations == 1;
-}
-
-static bool set_sysmmu_inactive(struct sysmmu_drvdata *data)
-{
-	/* return true if the System MMU is needed to be disabled */
-	BUG_ON(data->activations < 1);
-	return --data->activations == 0;
-}
-
-static bool is_sysmmu_active(struct sysmmu_drvdata *data)
-{
-	return data->activations > 0;
-}
-
 static void sysmmu_unblock(struct sysmmu_drvdata *data)
 {
 	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
@@ -388,7 +370,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	unsigned short reg_status, reg_clear;
 	int ret = -ENOSYS;
 
-	WARN_ON(!is_sysmmu_active(data));
+	WARN_ON(!data->active);
 
 	if (MMU_MAJ_VER(data->version) < 5) {
 		reg_status = REG_INT_STATUS;
@@ -434,40 +416,19 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
+static void __sysmmu_disable(struct sysmmu_drvdata *data)
 {
+	unsigned long flags;
+
 	clk_enable(data->clk_master);
 
+	spin_lock_irqsave(&data->lock, flags);
 	writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 	writel(0, data->sfrbase + REG_MMU_CFG);
-
-	__sysmmu_disable_clocks(data);
-}
-
-static bool __sysmmu_disable(struct sysmmu_drvdata *data)
-{
-	bool disabled;
-	unsigned long flags;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	disabled = set_sysmmu_inactive(data);
-
-	if (disabled) {
-		data->pgtable = 0;
-		data->domain = NULL;
-
-		__sysmmu_disable_nocount(data);
-
-		dev_dbg(data->sysmmu, "Disabled\n");
-	} else  {
-		dev_dbg(data->sysmmu, "%d times left to disable\n",
-					data->activations);
-	}
-
+	data->active = false;
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	return disabled;
+	__sysmmu_disable_clocks(data);
 }
 
 static void __sysmmu_init_config(struct sysmmu_drvdata *data)
@@ -484,17 +445,19 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 	writel(cfg, data->sfrbase + REG_MMU_CFG);
 }
 
-static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
+static void __sysmmu_enable(struct sysmmu_drvdata *data)
 {
+	unsigned long flags;
+
 	__sysmmu_enable_clocks(data);
 
+	spin_lock_irqsave(&data->lock, flags);
 	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
-
 	__sysmmu_init_config(data);
-
 	__sysmmu_set_ptbase(data, data->pgtable);
-
 	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
+	data->active = true;
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	/*
 	 * SYSMMU driver keeps master's clock enabled only for the short
@@ -505,48 +468,18 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 	clk_disable(data->clk_master);
 }
 
-static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
-			   struct exynos_iommu_domain *domain)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&data->lock, flags);
-	if (set_sysmmu_active(data)) {
-		data->pgtable = pgtable;
-		data->domain = domain;
-
-		__sysmmu_enable_nocount(data);
-
-		dev_dbg(data->sysmmu, "Enabled\n");
-	} else {
-		ret = (pgtable == data->pgtable) ? 1 : -EBUSY;
-
-		dev_dbg(data->sysmmu, "already enabled\n");
-	}
-
-	if (WARN_ON(ret < 0))
-		set_sysmmu_inactive(data); /* decrement count */
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return ret;
-}
-
 static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 					    sysmmu_iova_t iova)
 {
 	unsigned long flags;
 
-
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data) && data->version >= MAKE_MMU_VER(3, 3)) {
+	if (data->active && data->version >= MAKE_MMU_VER(3, 3)) {
 		clk_enable(data->clk_master);
 		__sysmmu_tlb_invalidate_entry(data, iova, 1);
 		clk_disable(data->clk_master);
 	}
 	spin_unlock_irqrestore(&data->lock, flags);
-
 }
 
 static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
@@ -555,7 +488,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	unsigned long flags;
 
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data)) {
+	if (data->active) {
 		unsigned int num_inv = 1;
 
 		clk_enable(data->clk_master);
@@ -656,40 +589,55 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(dev);
-
 	of_iommu_set_ops(dev->of_node, &exynos_iommu_ops);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int exynos_sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct exynos_iommu_owner *owner;
 
-	dev_dbg(dev, "suspend\n");
-	if (is_sysmmu_active(data)) {
-		__sysmmu_disable_nocount(data);
-		pm_runtime_put(dev);
+	if (!data->master)
+		return 0;
+
+	owner = data->master->archdata.iommu;
+
+	mutex_lock(&owner->rpm_lock);
+	if (data->domain) {
+		dev_dbg(data->sysmmu, "saving state\n");
+		__sysmmu_disable(data);
 	}
+	mutex_unlock(&owner->rpm_lock);
+
 	return 0;
 }
 
 static int exynos_sysmmu_resume(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct exynos_iommu_owner *owner;
 
-	dev_dbg(dev, "resume\n");
-	if (is_sysmmu_active(data)) {
-		pm_runtime_get_sync(dev);
-		__sysmmu_enable_nocount(data);
+	if (!data->master)
+		return 0;
+
+	owner = data->master->archdata.iommu;
+
+	mutex_lock(&owner->rpm_lock);
+	if (data->domain) {
+		dev_dbg(data->sysmmu, "restoring state\n");
+		__sysmmu_enable(data);
 	}
+	mutex_unlock(&owner->rpm_lock);
+
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
@@ -793,9 +741,12 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 	spin_lock_irqsave(&domain->lock, flags);
 
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
-		if (__sysmmu_disable(data))
-			data->master = NULL;
+		spin_lock(&data->lock);
+		__sysmmu_disable(data);
+		data->pgtable = 0;
+		data->domain = NULL;
 		list_del_init(&data->domain_node);
+		spin_unlock(&data->lock);
 	}
 
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -829,31 +780,32 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
-	bool found = false;
 
 	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
 		return;
 
+	mutex_lock(&owner->rpm_lock);
+
+	list_for_each_entry(data, &owner->controllers, owner_node) {
+		if (pm_runtime_active(data->sysmmu))
+			__sysmmu_disable(data);
+	}
+
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
+		spin_lock(&data->lock);
+		data->pgtable = 0;
+		data->domain = NULL;
+		list_del_init(&data->domain_node);
+		spin_unlock(&data->lock);
 	}
+	owner->domain = NULL;
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	owner->domain = NULL;
+	mutex_unlock(&owner->rpm_lock);
 
-	if (found)
-		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
-					__func__, &pagetable);
-	else
-		dev_err(dev, "%s: No IOMMU is attached\n", __func__);
+	dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n", __func__,
+		&pagetable);
 }
 
 static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
@@ -864,7 +816,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	struct sysmmu_drvdata *data;
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	unsigned long flags;
-	int ret = -ENODEV;
 
 	if (!has_sysmmu(dev))
 		return -ENODEV;
@@ -872,29 +823,30 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	if (owner->domain)
 		exynos_iommu_detach_device(owner->domain, dev);
 
+	mutex_lock(&owner->rpm_lock);
+
+	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(data, &owner->controllers, owner_node) {
-		pm_runtime_get_sync(data->sysmmu);
-		ret = __sysmmu_enable(data, pagetable, domain);
-		if (ret >= 0) {
-			data->master = dev;
-
-			spin_lock_irqsave(&domain->lock, flags);
-			list_add_tail(&data->domain_node, &domain->clients);
-			spin_unlock_irqrestore(&domain->lock, flags);
-		}
+		spin_lock(&data->lock);
+		data->pgtable = pagetable;
+		data->domain = domain;
+		list_add_tail(&data->domain_node, &domain->clients);
+		spin_unlock(&data->lock);
 	}
+	owner->domain = iommu_domain;
+	spin_unlock_irqrestore(&domain->lock, flags);
 
-	if (ret < 0) {
-		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
-					__func__, &pagetable);
-		return ret;
+	list_for_each_entry(data, &owner->controllers, owner_node) {
+		if (pm_runtime_active(data->sysmmu))
+			__sysmmu_enable(data);
 	}
 
-	owner->domain = iommu_domain;
-	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa %s\n",
-		__func__, &pagetable, (ret == 0) ? "" : ", again");
+	mutex_unlock(&owner->rpm_lock);
 
-	return ret;
+	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n", __func__,
+		&pagetable);
+
+	return 0;
 }
 
 static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
@@ -1265,10 +1217,21 @@ static int exynos_iommu_of_xlate(struct device *dev,
 			return -ENOMEM;
 
 		INIT_LIST_HEAD(&owner->controllers);
+		mutex_init(&owner->rpm_lock);
 		dev->archdata.iommu = owner;
 	}
 
 	list_add_tail(&data->owner_node, &owner->controllers);
+	data->master = dev;
+
+	/*
+	 * SYSMMU will be runtime enabled via device link (dependency) to its
+	 * master device, so there are no direct calls to pm_runtime_get/put
+	 * in this driver.
+	 */
+	device_link_add(dev, data->sysmmu, DEVICE_LINK_AVAILABLE,
+			DEVICE_LINK_PM_RUNTIME);
+
 	return 0;
 }
 
-- 
1.9.1
