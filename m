From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 3/7] iommu/exynos: Simplify internal enable/disable
	functions
Date: Mon, 14 Nov 2016 11:08:08 +0100
Message-ID: <1479118092-1365-4-git-send-email-m.szyprowski@samsung.com>
References: <1479118092-1365-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20161114100910eucas1p1d146481b6818212c30884e91e01a663b@eucas1p1.samsung.com>
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

Remove remaining leftovers of the ref-count related code in the
__sysmmu_enable/disable functions inline __sysmmu_enable/disable_nocount
to them. Suspend/resume callbacks now checks if master device is set for
given SYSMMU controller instead of relying on the activation count.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 104 ++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 75 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 4056228..f45b274 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -237,8 +237,8 @@ struct sysmmu_drvdata {
 	struct clk *aclk;		/* SYSMMU's aclk clock */
 	struct clk *pclk;		/* SYSMMU's pclk clock */
 	struct clk *clk_master;		/* master's device clock */
-	int activations;		/* number of calls to sysmmu_enable */
 	spinlock_t lock;		/* lock for modyfying state */
+	bool active;			/* current status */
 	struct exynos_iommu_domain *domain; /* domain we belong to */
 	struct list_head domain_node;	/* node for domain clients list */
 	struct list_head owner_node;	/* node for owner controllers list */
@@ -251,25 +251,6 @@ static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
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
@@ -388,7 +369,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	unsigned short reg_status, reg_clear;
 	int ret = -ENOSYS;
 
-	WARN_ON(!is_sysmmu_active(data));
+	WARN_ON(!data->active);
 
 	if (MMU_MAJ_VER(data->version) < 5) {
 		reg_status = REG_INT_STATUS;
@@ -434,37 +415,19 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
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
-	}
-
+	data->active = false;
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	return disabled;
+	__sysmmu_disable_clocks(data);
 }
 
 static void __sysmmu_init_config(struct sysmmu_drvdata *data)
@@ -481,17 +444,19 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
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
@@ -502,37 +467,18 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 	clk_disable(data->clk_master);
 }
 
-static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
-			   struct exynos_iommu_domain *domain)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&data->lock, flags);
-	if (set_sysmmu_active(data)) {
-		data->pgtable = pgtable;
-		data->domain = domain;
-		__sysmmu_enable_nocount(data);
-		dev_dbg(data->sysmmu, "Enabled\n");
-	}
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
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
@@ -541,7 +487,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	unsigned long flags;
 
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data)) {
+	if (data->active) {
 		unsigned int num_inv = 1;
 
 		clk_enable(data->clk_master);
@@ -652,10 +598,11 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 static int exynos_sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct device *master = data->master;
 
 	dev_dbg(dev, "suspend\n");
-	if (is_sysmmu_active(data)) {
-		__sysmmu_disable_nocount(data);
+	if (master) {
+		__sysmmu_disable(data);
 		pm_runtime_put(dev);
 	}
 	return 0;
@@ -664,11 +611,12 @@ static int exynos_sysmmu_suspend(struct device *dev)
 static int exynos_sysmmu_resume(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct device *master = data->master;
 
 	dev_dbg(dev, "resume\n");
-	if (is_sysmmu_active(data)) {
+	if (master) {
 		pm_runtime_get_sync(dev);
-		__sysmmu_enable_nocount(data);
+		__sysmmu_enable(data);
 	}
 	return 0;
 }
@@ -780,6 +728,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
 		__sysmmu_disable(data);
+		data->pgtable = 0;
+		data->domain = NULL;
 		data->master = NULL;
 		list_del_init(&data->domain_node);
 	}
@@ -823,6 +773,8 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
 		__sysmmu_disable(data);
 		data->master = NULL;
+		data->pgtable = 0;
+		data->domain = NULL;
 		list_del_init(&data->domain_node);
 		pm_runtime_put(data->sysmmu);
 	}
@@ -850,8 +802,10 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 		exynos_iommu_detach_device(owner->domain, dev);
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
+		data->pgtable = pagetable;
+		data->domain = domain;
 		pm_runtime_get_sync(data->sysmmu);
-		__sysmmu_enable(data, pagetable, domain);
+		__sysmmu_enable(data);
 		data->master = dev;
 
 		spin_lock_irqsave(&domain->lock, flags);
-- 
1.9.1
