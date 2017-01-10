From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 1/4] dmaengine: pl330: remove pdata based initialization
Date: Tue, 10 Jan 2017 08:12:36 +0100
Message-ID: <1484032359-8311-2-git-send-email-m.szyprowski@samsung.com>
References: <1484032359-8311-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170110071342eucas1p1dfe3c4708bf4c1fb193a6f36bfbdc997@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1484032359-8311-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

This driver is now used only on platforms which support device tree, so
it is safe to remove legacy platform data based initialization code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/plat-samsung/devs.c |  1 -
 drivers/dma/pl330.c          | 42 ++++++++----------------------------------
 include/linux/amba/pl330.h   | 35 -----------------------------------
 3 files changed, 8 insertions(+), 70 deletions(-)
 delete mode 100644 include/linux/amba/pl330.h

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 03fac123676d..dc269d9143bc 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/amba/pl330.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 740bbb942594..ef367cc26361 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
-#include <linux/amba/pl330.h>
 #include <linux/scatterlist.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -2084,18 +2083,6 @@ static void pl330_tasklet(unsigned long data)
 	}
 }
 
-bool pl330_filter(struct dma_chan *chan, void *param)
-{
-	u8 *peri_id;
-
-	if (chan->device->dev->driver != &pl330_driver.drv)
-		return false;
-
-	peri_id = chan->private;
-	return *peri_id == (unsigned long)param;
-}
-EXPORT_SYMBOL(pl330_filter);
-
 static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 						struct of_dma *ofdma)
 {
@@ -2839,7 +2826,6 @@ static int __maybe_unused pl330_resume(struct device *dev)
 static int
 pl330_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct dma_pl330_platdata *pdat;
 	struct pl330_config *pcfg;
 	struct pl330_dmac *pl330;
 	struct dma_pl330_chan *pch, *_p;
@@ -2849,8 +2835,6 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	int num_chan;
 	struct device_node *np = adev->dev.of_node;
 
-	pdat = dev_get_platdata(&adev->dev);
-
 	ret = dma_set_mask_and_coherent(&adev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
@@ -2863,7 +2847,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	pd = &pl330->ddma;
 	pd->dev = &adev->dev;
 
-	pl330->mcbufsz = pdat ? pdat->mcbuf_sz : 0;
+	pl330->mcbufsz = 0;
 
 	/* get quirk */
 	for (i = 0; i < ARRAY_SIZE(of_quirks); i++)
@@ -2907,10 +2891,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	INIT_LIST_HEAD(&pd->channels);
 
 	/* Initialize channel parameters */
-	if (pdat)
-		num_chan = max_t(int, pdat->nr_valid_peri, pcfg->num_chan);
-	else
-		num_chan = max_t(int, pcfg->num_peri, pcfg->num_chan);
+	num_chan = max_t(int, pcfg->num_peri, pcfg->num_chan);
 
 	pl330->num_peripherals = num_chan;
 
@@ -2922,11 +2903,8 @@ static int __maybe_unused pl330_resume(struct device *dev)
 
 	for (i = 0; i < num_chan; i++) {
 		pch = &pl330->peripherals[i];
-		if (!adev->dev.of_node)
-			pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
-		else
-			pch->chan.private = adev->dev.of_node;
 
+		pch->chan.private = adev->dev.of_node;
 		INIT_LIST_HEAD(&pch->submitted_list);
 		INIT_LIST_HEAD(&pch->work_list);
 		INIT_LIST_HEAD(&pch->completed_list);
@@ -2939,15 +2917,11 @@ static int __maybe_unused pl330_resume(struct device *dev)
 		list_add_tail(&pch->chan.device_node, &pd->channels);
 	}
 
-	if (pdat) {
-		pd->cap_mask = pdat->cap_mask;
-	} else {
-		dma_cap_set(DMA_MEMCPY, pd->cap_mask);
-		if (pcfg->num_peri) {
-			dma_cap_set(DMA_SLAVE, pd->cap_mask);
-			dma_cap_set(DMA_CYCLIC, pd->cap_mask);
-			dma_cap_set(DMA_PRIVATE, pd->cap_mask);
-		}
+	dma_cap_set(DMA_MEMCPY, pd->cap_mask);
+	if (pcfg->num_peri) {
+		dma_cap_set(DMA_SLAVE, pd->cap_mask);
+		dma_cap_set(DMA_CYCLIC, pd->cap_mask);
+		dma_cap_set(DMA_PRIVATE, pd->cap_mask);
 	}
 
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
deleted file mode 100644
index fe93758e8403..000000000000
--- a/include/linux/amba/pl330.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* linux/include/linux/amba/pl330.h
- *
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef	__AMBA_PL330_H_
-#define	__AMBA_PL330_H_
-
-#include <linux/dmaengine.h>
-
-struct dma_pl330_platdata {
-	/*
-	 * Number of valid peripherals connected to DMAC.
-	 * This may be different from the value read from
-	 * CR0, as the PL330 implementation might have 'holes'
-	 * in the peri list or the peri could also be reached
-	 * from another DMAC which the platform prefers.
-	 */
-	u8 nr_valid_peri;
-	/* Array of valid peripherals */
-	u8 *peri_id;
-	/* Operational capabilities */
-	dma_cap_mask_t cap_mask;
-	/* Bytes to allocate for MC buffer */
-	unsigned mcbuf_sz;
-};
-
-extern bool pl330_filter(struct dma_chan *chan, void *param);
-#endif	/* __AMBA_PL330_H_ */
-- 
1.9.1
