From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Thu, 09 Feb 2017 15:22:51 +0100
Message-ID: <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch replaces irq-safe runtime PM with non-irq-safe version based on
the new approach. Existing, irq-safe runtime PM implementation for PL330 was
not bringing much benefits of its own - only clocks were enabled/disabled.

Another limitation of irq-safe runtime PM is a fact, that it may prevent
the generic PM domain (genpd) from being powered off, particularly in cases
when the genpd doesn't have the GENPD_FLAG_IRQ_SAFE set.

Till now non-irq-safe runtime PM implementation was only possible by calling
pm_runtime_get/put functions from alloc/free_chan_resources. All other DMA
engine API functions cannot be called from a context, which permits sleeping.
Such implementation, in practice would result in keeping DMA controller's
device active almost all the time, because most of the slave device drivers
(DMA engine clients) acquire DMA channel in their probe() function and
released it during driver removal.

This patch provides a new, different approach. It is based on an observation
that there can be only one slave device using each DMA channel. PL330 hardware
always has dedicated channels for each peripheral device. Using recently
introduced device dependencies (links) infrastructure one can ensure proper
runtime PM state of PL330 DMA controller basing on the runtime PM state of
the slave device.

In this approach in pl330_set_slave() function a new dependency is being
created between PL330 DMA controller device (as a supplier) and given slave
device (as a consumer). This way PL330 DMA controller device runtime active
counter is increased when the slave device is resumed and decreased the same
time when given slave device is put to suspend. This way it has been ensured
to keep PL330 DMA controller runtime active if there is an active used of
any of its DMA channels. This is similar to what has been already
implemented in Exynos IOMMU driver in commit 2f5f44f205cc95 ("iommu/exynos:
Use device dependency links to control runtime pm").

If slave device doesn't implement runtime PM or keeps device runtime active
all the time, then PL330 DMA controller will be runtime active all the time
when channel is being allocated.

If one requests memory-to-memory channel, runtime active counter is
increased unconditionally. This might be a drawback of this approach, but
PL330 is not really used for memory-to-memory operations due to poor
performance in such operations compared to the CPU.

Removal of irq-safe runtime PM is based on the revert of the following
commits:
1. commit 5c9e6c2b2ba3 "dmaengine: pl330: fix runtime pm support"
2. commit 81cc6edc0870 "dmaengine: pl330: Fix hang on dmaengine_terminate_all
   on certain boards"
3. commit ae43b3289186 "ARM: 8202/1: dmaengine: pl330: Add runtime Power
   Management support v12"

Introducing non-irq-safe runtime power management finally allows to turn off
audio power domain on Exynos5 SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/pl330.c | 177 +++++++++++++++++++++++-----------------------------
 1 file changed, 77 insertions(+), 100 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 8b0da7fa520d..17efad418faa 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -22,6 +22,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
+#include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -268,9 +269,6 @@ enum pl330_byteswap {
 
 #define NR_DEFAULT_DESC	16
 
-/* Delay for runtime PM autosuspend, ms */
-#define PL330_AUTOSUSPEND_DELAY 20
-
 /* Populated by the PL330 core driver for DMA API driver's info */
 struct pl330_config {
 	u32	periph_id;
@@ -449,7 +447,7 @@ struct dma_pl330_chan {
 	bool cyclic;
 
 	/* for runtime pm tracking */
-	bool active;
+	struct device_link *slave_link;
 };
 
 struct pl330_dmac {
@@ -463,6 +461,8 @@ struct pl330_dmac {
 	struct list_head desc_pool;
 	/* To protect desc_pool manipulation */
 	spinlock_t pool_lock;
+	/* For management of slave PM links */
+	struct mutex rpm_lock;
 
 	/* Size of MicroCode buffers for each channel. */
 	unsigned mcbufsz;
@@ -2008,7 +2008,6 @@ static void pl330_tasklet(unsigned long data)
 	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
 	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
-	bool power_down = false;
 
 	spin_lock_irqsave(&pch->lock, flags);
 
@@ -2023,18 +2022,10 @@ static void pl330_tasklet(unsigned long data)
 	/* Try to submit a req imm. next to the last completed cookie */
 	fill_queue(pch);
 
-	if (list_empty(&pch->work_list)) {
-		spin_lock(&pch->thread->dmac->lock);
-		_stop(pch->thread);
-		spin_unlock(&pch->thread->dmac->lock);
-		power_down = true;
-		pch->active = false;
-	} else {
-		/* Make sure the PL330 Channel thread is active */
-		spin_lock(&pch->thread->dmac->lock);
-		_start(pch->thread);
-		spin_unlock(&pch->thread->dmac->lock);
-	}
+	/* Make sure the PL330 Channel thread is active */
+	spin_lock(&pch->thread->dmac->lock);
+	_start(pch->thread);
+	spin_unlock(&pch->thread->dmac->lock);
 
 	while (!list_empty(&pch->completed_list)) {
 		struct dmaengine_desc_callback cb;
@@ -2047,13 +2038,6 @@ static void pl330_tasklet(unsigned long data)
 		if (pch->cyclic) {
 			desc->status = PREP;
 			list_move_tail(&desc->node, &pch->work_list);
-			if (power_down) {
-				pch->active = true;
-				spin_lock(&pch->thread->dmac->lock);
-				_start(pch->thread);
-				spin_unlock(&pch->thread->dmac->lock);
-				power_down = false;
-			}
 		} else {
 			desc->status = FREE;
 			list_move_tail(&desc->node, &pch->dmac->desc_pool);
@@ -2068,12 +2052,6 @@ static void pl330_tasklet(unsigned long data)
 		}
 	}
 	spin_unlock_irqrestore(&pch->lock, flags);
-
-	/* If work list empty, power down */
-	if (power_down) {
-		pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-		pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
-	}
 }
 
 static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
@@ -2096,11 +2074,68 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
+static int pl330_set_slave(struct dma_chan *chan, struct device *slave)
+{
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct pl330_dmac *pl330 = pch->dmac;
+	int i;
+
+	mutex_lock(&pl330->rpm_lock);
+
+	for (i = 0; i < pl330->num_peripherals; i++) {
+		if (pl330->peripherals[i].chan.slave == slave &&
+		    pl330->peripherals[i].slave_link) {
+			pch->slave_link = pl330->peripherals[i].slave_link;
+			goto done;
+		}
+	}
+
+	pch->slave_link = device_link_add(slave, pl330->ddma.dev,
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+	if (!pch->slave_link) {
+		mutex_unlock(&pl330->rpm_lock);
+		return -ENODEV;
+	}
+done:
+	mutex_unlock(&pl330->rpm_lock);
+
+	pm_runtime_put(pl330->ddma.dev);
+
+	return 0;
+}
+
+static void pl330_release_slave(struct dma_chan *chan)
+{
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct pl330_dmac *pl330 = pch->dmac;
+	struct device_link *link = pch->slave_link;
+	int i, count = 0;
+
+	pm_runtime_get_sync(pl330->ddma.dev);
+
+	mutex_lock(&pl330->rpm_lock);
+
+	for (i = 0; i < pl330->num_peripherals; i++)
+		if (pl330->peripherals[i].slave_link == link)
+			count++;
+
+	pch->slave_link = NULL;
+	if (count == 1)
+		device_link_del(link);
+
+	mutex_unlock(&pl330->rpm_lock);
+}
+
 static int pl330_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
 	unsigned long flags;
+	int ret;
+
+	ret = pm_runtime_get_sync(pl330->ddma.dev);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&pl330->lock, flags);
 
@@ -2110,6 +2145,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 	pch->thread = pl330_request_channel(pl330);
 	if (!pch->thread) {
 		spin_unlock_irqrestore(&pl330->lock, flags);
+		pm_runtime_put(pl330->ddma.dev);
 		return -ENOMEM;
 	}
 
@@ -2151,9 +2187,7 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	struct pl330_dmac *pl330 = pch->dmac;
 	LIST_HEAD(list);
-	bool power_down = false;
 
-	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
 	spin_lock(&pl330->lock);
 	_stop(pch->thread);
@@ -2162,8 +2196,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	pch->thread->req[0].desc = NULL;
 	pch->thread->req[1].desc = NULL;
 	pch->thread->req_running = -1;
-	power_down = pch->active;
-	pch->active = false;
 
 	/* Mark all desc done */
 	list_for_each_entry(desc, &pch->submitted_list, node) {
@@ -2180,10 +2212,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
 	list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	if (power_down)
-		pm_runtime_put_autosuspend(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2201,7 +2229,6 @@ static int pl330_pause(struct dma_chan *chan)
 	struct pl330_dmac *pl330 = pch->dmac;
 	unsigned long flags;
 
-	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
 
 	spin_lock(&pl330->lock);
@@ -2209,8 +2236,6 @@ static int pl330_pause(struct dma_chan *chan)
 	spin_unlock(&pl330->lock);
 
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2223,7 +2248,6 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 
 	tasklet_kill(&pch->task);
 
-	pm_runtime_get_sync(pch->dmac->ddma.dev);
 	spin_lock_irqsave(&pl330->lock, flags);
 
 	pl330_release_channel(pch->thread);
@@ -2233,19 +2257,17 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
-	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
+
+	pm_runtime_put(pl330->ddma.dev);
 }
 
 static int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
 					   struct dma_pl330_desc *desc)
 {
 	struct pl330_thread *thrd = pch->thread;
-	struct pl330_dmac *pl330 = pch->dmac;
 	void __iomem *regs = thrd->dmac->base;
 	u32 val, addr;
 
-	pm_runtime_get_sync(pl330->ddma.dev);
 	val = addr = 0;
 	if (desc->rqcfg.src_inc) {
 		val = readl(regs + SA(thrd->id));
@@ -2254,8 +2276,6 @@ static int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
 		val = readl(regs + DA(thrd->id));
 		addr = desc->px.dst_addr;
 	}
-	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	/* If DMAMOV hasn't finished yet, SAR/DAR can be zero */
 	if (!val)
@@ -2341,16 +2361,6 @@ static void pl330_issue_pending(struct dma_chan *chan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&pch->lock, flags);
-	if (list_empty(&pch->work_list)) {
-		/*
-		 * Warn on nothing pending. Empty submitted_list may
-		 * break our pm_runtime usage counter as it is
-		 * updated on work_list emptiness status.
-		 */
-		WARN_ON(list_empty(&pch->submitted_list));
-		pch->active = true;
-		pm_runtime_get_sync(pch->dmac->ddma.dev);
-	}
 	list_splice_tail_init(&pch->submitted_list, &pch->work_list);
 	spin_unlock_irqrestore(&pch->lock, flags);
 
@@ -2778,44 +2788,12 @@ static irqreturn_t pl330_irq_handler(int irq, void *data)
 	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES)
 
 /*
- * Runtime PM callbacks are provided by amba/bus.c driver.
- *
- * It is assumed here that IRQ safe runtime PM is chosen in probe and amba
- * bus driver will only disable/enable the clock in runtime PM callbacks.
+ * Runtime PM callbacks are provided by amba/bus.c driver, system sleep
+ * suspend/resume is implemented by generic helpers, which use existing
+ * runtime PM callbacks.
  */
-static int __maybe_unused pl330_suspend(struct device *dev)
-{
-	struct amba_device *pcdev = to_amba_device(dev);
-
-	pm_runtime_disable(dev);
-
-	if (!pm_runtime_status_suspended(dev)) {
-		/* amba did not disable the clock */
-		amba_pclk_disable(pcdev);
-	}
-	amba_pclk_unprepare(pcdev);
-
-	return 0;
-}
-
-static int __maybe_unused pl330_resume(struct device *dev)
-{
-	struct amba_device *pcdev = to_amba_device(dev);
-	int ret;
-
-	ret = amba_pclk_prepare(pcdev);
-	if (ret)
-		return ret;
-
-	if (!pm_runtime_status_suspended(dev))
-		ret = amba_pclk_enable(pcdev);
-
-	pm_runtime_enable(dev);
-
-	return ret;
-}
-
-static SIMPLE_DEV_PM_OPS(pl330_pm, pl330_suspend, pl330_resume);
+static SIMPLE_DEV_PM_OPS(pl330_pm, pm_runtime_force_suspend,
+			 pm_runtime_force_resume);
 
 static int
 pl330_probe(struct amba_device *adev, const struct amba_id *id)
@@ -2877,6 +2855,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 
 	INIT_LIST_HEAD(&pl330->desc_pool);
 	spin_lock_init(&pl330->pool_lock);
+	mutex_init(&pl330->rpm_lock);
 
 	/* Create a descriptor pool of default size */
 	if (!add_desc(pl330, GFP_KERNEL, NR_DEFAULT_DESC))
@@ -2920,6 +2899,8 @@ static int __maybe_unused pl330_resume(struct device *dev)
 
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
+	pd->device_set_slave = pl330_set_slave;
+	pd->device_release_slave = pl330_release_slave;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
 	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
@@ -2968,11 +2949,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 		pcfg->data_buf_dep, pcfg->data_bus_width / 8, pcfg->num_chan,
 		pcfg->num_peri, pcfg->num_events);
 
-	pm_runtime_irq_safe(&adev->dev);
-	pm_runtime_use_autosuspend(&adev->dev);
-	pm_runtime_set_autosuspend_delay(&adev->dev, PL330_AUTOSUSPEND_DELAY);
-	pm_runtime_mark_last_busy(&adev->dev);
-	pm_runtime_put_autosuspend(&adev->dev);
+	pm_runtime_put(&adev->dev);
 
 	return 0;
 probe_err3:
-- 
1.9.1
