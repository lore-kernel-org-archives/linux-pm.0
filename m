From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 4/4] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Fri, 13 Jan 2017 08:26:40 +0100
Message-ID: <1484292400-29730-5-git-send-email-m.szyprowski@samsung.com>
References: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170113072653eucas1p17ed0755fad3bd351c4e89ec9fa10e09e@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch replaces irq-safe runtime PM with non-irq-safe version based on
the new approach. Existing, irq-safe runtime PM implementation for PL330 was
not bringing much benefits of its own - only clocks were enabled/disabled.

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

In this approach in pl330_alloc_chan_resources() function a new dependency
is being created between PL330 DMA controller device (as a supplier) and
given slave device (as a consumer). This way PL330 DMA controller device
runtime active counter is increased when the slave device is resumed and
decreased the same time when given slave device is put to suspend. This way
it has been ensured to keep PL330 DMA controller runtime active if there is
an active used of any of its DMA channels. Slave device pointer is initially
stored in per-channel data in of_dma_xlate callback. This is similar to what
has been already implemented in Exynos IOMMU driver in commit 2f5f44f205cc95
("iommu/exynos: Use device dependency links to control runtime pm").

If slave device doesn't implement runtime PM or keeps device runtime active
all the time, then PL330 DMA controller will be runtime active all the time
when channel is being allocated. The goal is however to have runtime PM
added to all devices in the system, because it lets respective power
domains to be turned off, what gives the best results in terms of power
saving.

If one requests memory-to-memory channel, runtime active counter is
increased unconditionally. This might be a drawback of this approach, but
PL330 is not really used for memory-to-memory operations due to poor
performance in such operations compared to the CPU.

Introducing non-irq-safe runtime power management finally allows to turn off
audio power domain on Exynos5 SoCs.

Removal of irq-safe runtime PM is based on the revert of the following
commits:
1. commit 5c9e6c2b2ba3 "dmaengine: pl330: fix runtime pm support"
2. commit 81cc6edc0870 "dmaengine: pl330: Fix hang on dmaengine_terminate_all
   on certain boards"
3. commit ae43b3289186 "ARM: 8202/1: dmaengine: pl330: Add runtime Power
   Management support v12"

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/pl330.c | 135 ++++++++++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 63 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index c77a3494659c..a97cb02250ab 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -268,9 +269,6 @@ enum pl330_byteswap {
 
 #define NR_DEFAULT_DESC	16
 
-/* Delay for runtime PM autosuspend, ms */
-#define PL330_AUTOSUSPEND_DELAY 20
-
 /* Populated by the PL330 core driver for DMA API driver's info */
 struct pl330_config {
 	u32	periph_id;
@@ -449,8 +447,8 @@ struct dma_pl330_chan {
 	bool cyclic;
 
 	/* for runtime pm tracking */
-	bool active;
 	struct device *slave;
+	struct device_link *slave_link;
 };
 
 struct pl330_dmac {
@@ -465,6 +463,9 @@ struct pl330_dmac {
 	/* To protect desc_pool manipulation */
 	spinlock_t pool_lock;
 
+	/* For runtime PM management of slave channels */
+	struct mutex rpm_lock;
+
 	/* Size of MicroCode buffers for each channel. */
 	unsigned mcbufsz;
 	/* ioremap'ed address of PL330 registers. */
@@ -2008,7 +2009,6 @@ static void pl330_tasklet(unsigned long data)
 	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
 	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
-	bool power_down = false;
 
 	spin_lock_irqsave(&pch->lock, flags);
 
@@ -2023,18 +2023,10 @@ static void pl330_tasklet(unsigned long data)
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
@@ -2047,13 +2039,6 @@ static void pl330_tasklet(unsigned long data)
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
@@ -2068,12 +2053,6 @@ static void pl330_tasklet(unsigned long data)
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
@@ -2105,11 +2084,69 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
+static int pl330_add_slave_pm_link(struct pl330_dmac *pl330,
+				   struct dma_pl330_chan *pch)
+{
+	int ret = 0;
+	int i;
+
+	/* No slave device means memory-to-memory channels */
+	if (!pch->slave)
+		return pm_runtime_get_sync(pl330->ddma.dev);
+
+	mutex_lock(&pl330->rpm_lock);
+
+	for (i = 0; i < pl330->num_peripherals; i++) {
+		if (pl330->peripherals[i].slave == pch->slave &&
+		    pl330->peripherals[i].slave_link) {
+			pch->slave_link = pl330->peripherals[i].slave_link;
+			goto done;
+		}
+	}
+
+	pch->slave_link = device_link_add(pch->slave, pl330->ddma.dev,
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+	if (!pch->slave_link)
+		ret = -ENODEV;
+
+done:
+	mutex_unlock(&pl330->rpm_lock);
+	return ret;
+}
+
+static void pl330_del_slave_pm_link(struct pl330_dmac *pl330,
+				    struct dma_pl330_chan *pch)
+{
+	struct device_link *link = pch->slave_link;
+	int i, count = 0;
+
+	if (!pch->slave)
+		pm_runtime_put(pl330->ddma.dev);
+
+	mutex_lock(&pl330->rpm_lock);
+
+	for (i = 0; i < pl330->num_peripherals; i++)
+		if (pl330->peripherals[i].slave_link == link)
+			count++;
+
+	pch->slave_link = NULL;
+
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
+	ret = pl330_add_slave_pm_link(pl330, pch);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&pl330->lock, flags);
 
@@ -2119,6 +2156,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 	pch->thread = pl330_request_channel(pl330);
 	if (!pch->thread) {
 		spin_unlock_irqrestore(&pl330->lock, flags);
+		pl330_del_slave_pm_link(pl330, pch);
 		return -ENOMEM;
 	}
 
@@ -2160,9 +2198,7 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	struct pl330_dmac *pl330 = pch->dmac;
 	LIST_HEAD(list);
-	bool power_down = false;
 
-	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
 	spin_lock(&pl330->lock);
 	_stop(pch->thread);
@@ -2171,8 +2207,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	pch->thread->req[0].desc = NULL;
 	pch->thread->req[1].desc = NULL;
 	pch->thread->req_running = -1;
-	power_down = pch->active;
-	pch->active = false;
 
 	/* Mark all desc done */
 	list_for_each_entry(desc, &pch->submitted_list, node) {
@@ -2189,10 +2223,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
 	list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	if (power_down)
-		pm_runtime_put_autosuspend(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2210,7 +2240,6 @@ static int pl330_pause(struct dma_chan *chan)
 	struct pl330_dmac *pl330 = pch->dmac;
 	unsigned long flags;
 
-	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
 
 	spin_lock(&pl330->lock);
@@ -2218,8 +2247,6 @@ static int pl330_pause(struct dma_chan *chan)
 	spin_unlock(&pl330->lock);
 
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2232,7 +2259,6 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 
 	tasklet_kill(&pch->task);
 
-	pm_runtime_get_sync(pch->dmac->ddma.dev);
 	spin_lock_irqsave(&pl330->lock, flags);
 
 	pl330_release_channel(pch->thread);
@@ -2242,19 +2268,17 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
-	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
+
+	pl330_del_slave_pm_link(pl330, pch);
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
@@ -2263,8 +2287,6 @@ static int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
 		val = readl(regs + DA(thrd->id));
 		addr = desc->px.dst_addr;
 	}
-	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	/* If DMAMOV hasn't finished yet, SAR/DAR can be zero */
 	if (!val)
@@ -2350,16 +2372,6 @@ static void pl330_issue_pending(struct dma_chan *chan)
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
 
@@ -2886,6 +2898,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 
 	INIT_LIST_HEAD(&pl330->desc_pool);
 	spin_lock_init(&pl330->pool_lock);
+	mutex_init(&pl330->rpm_lock);
 
 	/* Create a descriptor pool of default size */
 	if (!add_desc(pl330, GFP_KERNEL, NR_DEFAULT_DESC))
@@ -2977,11 +2990,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
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
