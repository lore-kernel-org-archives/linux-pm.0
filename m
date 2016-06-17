From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 10/10] iommu/exynos: Add proper runtime pm support
Date: Fri, 17 Jun 2016 08:27:00 +0200
Message-ID: <1466144820-6286-11-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1466144820-6286-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch uses recently introduced device links to track the runtime pm
state of the master's device. This way each SYSMMU controller is runtime
active its master's device is active and can save/restore its state
instead of being enabled all the time. This way SYSMMU controllers no
longer prevents respective power domains to be turned off when master's
device is not used.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 218 ++++++++++++++++++++-----------------------
 1 file changed, 99 insertions(+), 119 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 9d1a14f88891..80b7f1e7268c 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -233,8 +233,8 @@ struct sysmmu_drvdata {
 	struct clk *aclk;		/* SYSMMU's aclk clock */
 	struct clk *pclk;		/* SYSMMU's pclk clock */
 	struct clk *clk_master;		/* master's device clock */
-	int activations;		/* number of calls to sysmmu_enable */
 	spinlock_t lock;		/* lock for modyfying state */
+	int active;			/* current status */
 	struct exynos_iommu_domain *domain; /* domain we belong to */
 	struct list_head domain_node;	/* node for domain clients list */
 	struct list_head owner_node;	/* node for owner controllers list */
@@ -247,25 +247,6 @@ static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
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
@@ -384,7 +365,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	unsigned short reg_status, reg_clear;
 	int ret = -ENOSYS;
 
-	WARN_ON(!is_sysmmu_active(data));
+	WARN_ON(!data->active);
 
 	if (MMU_MAJ_VER(data->version) < 5) {
 		reg_status = REG_INT_STATUS;
@@ -430,7 +411,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
+static void __sysmmu_disable(struct sysmmu_drvdata *data)
 {
 	clk_enable(data->clk_master);
 
@@ -440,32 +421,6 @@ static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
 	__sysmmu_disable_clocks(data);
 }
 
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
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return disabled;
-}
-
 static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 {
 	unsigned int cfg;
@@ -480,7 +435,7 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 	writel(cfg, data->sfrbase + REG_MMU_CFG);
 }
 
-static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
+static void __sysmmu_enable(struct sysmmu_drvdata *data)
 {
 	__sysmmu_enable_clocks(data);
 
@@ -501,34 +456,6 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
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
@@ -536,7 +463,7 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 
 
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data) && data->version >= MAKE_MMU_VER(3, 3)) {
+	if (data->active && data->version >= MAKE_MMU_VER(3, 3)) {
 		clk_enable(data->clk_master);
 		__sysmmu_tlb_invalidate_entry(data, iova, 1);
 		clk_disable(data->clk_master);
@@ -551,7 +478,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	unsigned long flags;
 
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data)) {
+	if (data->active) {
 		unsigned int num_inv = 1;
 
 		clk_enable(data->clk_master);
@@ -652,40 +579,78 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(dev);
-
 	of_iommu_set_ops(dev->of_node, &exynos_iommu_ops);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
+static int exynos_sysmmu_runtime_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	if (data->master) {
+		dev_dbg(data->sysmmu, "runtime pm: saving state\n");
+		__sysmmu_disable(data);
+		data->active = false;
+	}
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int exynos_sysmmu_runtime_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	if (data->master) {
+		dev_dbg(data->sysmmu, "runtime pm: restoring state\n");
+		__sysmmu_enable(data);
+		data->active = true;
+	}
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
 static int exynos_sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	unsigned long flags;
 
-	dev_dbg(dev, "suspend\n");
-	if (is_sysmmu_active(data)) {
-		__sysmmu_disable_nocount(data);
-		pm_runtime_put(dev);
+	spin_lock_irqsave(&data->lock, flags);
+	if (data->active) {
+		dev_dbg(data->sysmmu, "saving state\n");
+		__sysmmu_disable(data);
 	}
+	spin_unlock_irqrestore(&data->lock, flags);
+
 	return 0;
 }
 
 static int exynos_sysmmu_resume(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	unsigned long flags;
 
-	dev_dbg(dev, "resume\n");
-	if (is_sysmmu_active(data)) {
-		pm_runtime_get_sync(dev);
-		__sysmmu_enable_nocount(data);
+	spin_lock_irqsave(&data->lock, flags);
+	if (data->active) {
+		dev_dbg(data->sysmmu, "restoring state\n");
+		__sysmmu_enable(data);
 	}
+	spin_unlock_irqrestore(&data->lock, flags);
+
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sysmmu_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume)
+	SET_RUNTIME_PM_OPS(exynos_sysmmu_runtime_suspend,
+			   exynos_sysmmu_runtime_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(exynos_sysmmu_suspend,
+				     exynos_sysmmu_resume)
 };
 
 static const struct of_device_id sysmmu_of_match[] __initconst = {
@@ -789,9 +754,16 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 	spin_lock_irqsave(&domain->lock, flags);
 
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
-		if (__sysmmu_disable(data))
-			data->master = NULL;
+		spin_lock(&data->lock);
+		if (WARN_ON(data->active)) {
+			__sysmmu_disable(data);
+			data->active = false;
+		}
+		data->master = NULL;
+		data->pgtable = 0;
+		data->domain = NULL;
 		list_del_init(&data->domain_node);
+		spin_unlock(&data->lock);
 	}
 
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -832,18 +804,22 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
+		spin_lock(&data->lock);
 		if (data->master == dev) {
-			if (__sysmmu_disable(data)) {
-				data->master = NULL;
-				list_del_init(&data->domain_node);
-			}
-			pm_runtime_put(data->sysmmu);
 			found = true;
+			if (data->active) {
+				__sysmmu_disable(data);
+				data->active = false;
+			}
+			data->master = NULL;
+			data->pgtable = 0;
+			data->domain = NULL;
+			list_del_init(&data->domain_node);
 		}
+		spin_unlock(&data->lock);
 	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	owner->domain = NULL;
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	if (found)
 		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
@@ -860,7 +836,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	struct sysmmu_drvdata *data;
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	unsigned long flags;
-	int ret = -ENODEV;
 
 	if (!has_sysmmu(dev))
 		return -ENODEV;
@@ -868,29 +843,26 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	if (owner->domain)
 		exynos_iommu_detach_device(owner->domain, dev);
 
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
+		spin_lock(&data->lock);
+		data->master = dev;
+		data->pgtable = pagetable;
+		data->domain = domain;
+		list_add_tail(&data->domain_node, &domain->clients);
+		if (pm_runtime_active(data->sysmmu)) {
+			__sysmmu_enable(data);
+			data->active = true;
 		}
+		spin_unlock(&data->lock);
 	}
-
-	if (ret < 0) {
-		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
-					__func__, &pagetable);
-		return ret;
-	}
-
 	owner->domain = iommu_domain;
-	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa %s\n",
-		__func__, &pagetable, (ret == 0) ? "" : ", again");
+	spin_unlock_irqrestore(&domain->lock, flags);
 
-	return ret;
+	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n",
+		__func__, &pagetable);
+
+	return 0;
 }
 
 static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
@@ -1265,6 +1237,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	}
 
 	list_add_tail(&data->owner_node, &owner->controllers);
+
+	/*
+	 * SYSMMU will be runtime enabled via device link (dependency) to its
+	 * master device, so there are no direct calls to pm_runtime_get/put
+	 * in this driver
+	 */
+	device_link_add(dev, &sysmmu->dev, DEVICE_LINK_PERSISTENT |
+					   DEVICE_LINK_PM_RUNTIME);
 	return 0;
 }
 
-- 
1.9.1
