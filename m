From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 4/4] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Tue, 10 Jan 2017 08:12:39 +0100
Message-ID: <1484032359-8311-5-git-send-email-m.szyprowski@samsung.com>
References: <1484032359-8311-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170110071344eucas1p1361cafbd9d3b08a4e94e91ae6646cfd1@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:62796 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755036AbdAJHNw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 02:13:52 -0500
In-reply-to: <1484032359-8311-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/pl330.c | 124 ++++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 4489d4d13012..c7612bb0cfc8 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -268,9 +268,6 @@ enum pl330_byteswap {
 
 #define NR_DEFAULT_DESC	16
 
-/* Delay for runtime PM autosuspend, ms */
-#define PL330_AUTOSUSPEND_DELAY 20
-
 /* Populated by the PL330 core driver for DMA API driver's info */
 struct pl330_config {
 	u32	periph_id;
@@ -449,8 +446,8 @@ struct dma_pl330_chan {
 	bool cyclic;
 
 	/* for runtime pm tracking */
-	bool active;
 	struct device *slave;
+	struct device_link *slave_link;
 };
 
 struct pl330_dmac {
@@ -2016,7 +2013,6 @@ static void pl330_tasklet(unsigned long data)
 	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
 	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
-	bool power_down = false;
 
 	spin_lock_irqsave(&pch->lock, flags);
 
@@ -2031,18 +2027,10 @@ static void pl330_tasklet(unsigned long data)
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
@@ -2055,13 +2043,6 @@ static void pl330_tasklet(unsigned long data)
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
@@ -2076,12 +2057,6 @@ static void pl330_tasklet(unsigned long data)
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
@@ -2113,11 +2088,52 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
+static int pl330_add_slave_link(struct pl330_dmac *pl330,
+				struct dma_pl330_chan *pch)
+{
+	struct device_link *link;
+	int i;
+
+	if (pch->slave_link)
+		return 0;
+
+	link = device_link_add(pch->slave, pl330->ddma.dev,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+	if (!link)
+		return -ENODEV;
+
+	for (i = 0; i < pl330->num_peripherals; i++)
+		if (pl330->peripherals[i].slave == pch->slave)
+			pl330->peripherals[i].slave_link = link;
+	return 0;
+}
+
+static void pl330_del_slave_link(struct pl330_dmac *pl330,
+				 struct dma_pl330_chan *pch)
+{
+	struct device_link *link = pch->slave_link;
+	int i, count = 0;
+
+	for (i = 0; i < pl330->num_peripherals; i++)
+		if (pl330->peripherals[i].slave == pch->slave &&
+		    pl330->peripherals[i].thread)
+			count++;
+
+	if (count > 0)
+		return;
+
+	device_link_del(link);
+	for (i = 0; i < pl330->num_peripherals; i++)
+		if (pl330->peripherals[i].slave == pch->slave)
+			pch->slave_link = NULL;
+}
+
 static int pl330_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&pch->lock, flags);
 
@@ -2134,6 +2150,14 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&pch->lock, flags);
 
+	if (pch->slave)
+		ret = pl330_add_slave_link(pl330, pch);
+	else
+		ret = pm_runtime_get_sync(pl330->ddma.dev);
+
+	if (ret < 0)
+		return ret;
+
 	return 1;
 }
 
@@ -2168,9 +2192,7 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	struct pl330_dmac *pl330 = pch->dmac;
 	LIST_HEAD(list);
-	bool power_down = false;
 
-	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
 	spin_lock(&pl330->lock);
 	_stop(pch->thread);
@@ -2179,8 +2201,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	pch->thread->req[0].desc = NULL;
 	pch->thread->req[1].desc = NULL;
 	pch->thread->req_running = -1;
-	power_down = pch->active;
-	pch->active = false;
 
 	/* Mark all desc done */
 	list_for_each_entry(desc, &pch->submitted_list, node) {
@@ -2197,10 +2217,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
 	list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	if (power_down)
-		pm_runtime_put_autosuspend(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2218,7 +2234,6 @@ static int pl330_pause(struct dma_chan *chan)
 	struct pl330_dmac *pl330 = pch->dmac;
 	unsigned long flags;
 
-	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
 
 	spin_lock(&pl330->lock);
@@ -2226,8 +2241,6 @@ static int pl330_pause(struct dma_chan *chan)
 	spin_unlock(&pl330->lock);
 
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2235,11 +2248,11 @@ static int pl330_pause(struct dma_chan *chan)
 static void pl330_free_chan_resources(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct pl330_dmac *pl330 = pch->dmac;
 	unsigned long flags;
 
 	tasklet_kill(&pch->task);
 
-	pm_runtime_get_sync(pch->dmac->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
 
 	pl330_release_channel(pch->thread);
@@ -2249,19 +2262,20 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
 
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
+
+	if (pch->slave)
+		pl330_del_slave_link(pl330, pch);
+	else
+		pm_runtime_put(pl330->ddma.dev);
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
@@ -2270,8 +2284,6 @@ static int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
 		val = readl(regs + DA(thrd->id));
 		addr = desc->px.dst_addr;
 	}
-	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	/* If DMAMOV hasn't finished yet, SAR/DAR can be zero */
 	if (!val)
@@ -2357,16 +2369,6 @@ static void pl330_issue_pending(struct dma_chan *chan)
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
 
@@ -2984,11 +2986,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
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

