From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/3] dmaengine: pl330: remove pdata based initialization
Date: Thu, 22 Dec 2016 13:11:27 +0100
Message-ID: <1482408689-21971-2-git-send-email-m.szyprowski@samsung.com>
References: <1482408689-21971-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161222121151epcas1p298f81862fc4370f3cbf2b10e4da5344a@epcas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36269 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938739AbcLVMLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 07:11:55 -0500
In-reply-to: <1482408689-21971-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

This driver is now used only on platforms which supports device tree, so
it is safe to remove legacy platform data based initialization code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/pl330.c        | 30 ++++++++----------------------
 include/linux/amba/pl330.h | 35 -----------------------------------
 2 files changed, 8 insertions(+), 57 deletions(-)
 delete mode 100644 include/linux/amba/pl330.h

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 740bbb9..27cc5d2 100644
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
@@ -2839,7 +2838,6 @@ static int __maybe_unused pl330_resume(struct device *dev)
 static int
 pl330_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct dma_pl330_platdata *pdat;
 	struct pl330_config *pcfg;
 	struct pl330_dmac *pl330;
 	struct dma_pl330_chan *pch, *_p;
@@ -2849,8 +2847,6 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	int num_chan;
 	struct device_node *np = adev->dev.of_node;
 
-	pdat = dev_get_platdata(&adev->dev);
-
 	ret = dma_set_mask_and_coherent(&adev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
@@ -2863,7 +2859,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	pd = &pl330->ddma;
 	pd->dev = &adev->dev;
 
-	pl330->mcbufsz = pdat ? pdat->mcbuf_sz : 0;
+	pl330->mcbufsz = 0;
 
 	/* get quirk */
 	for (i = 0; i < ARRAY_SIZE(of_quirks); i++)
@@ -2907,10 +2903,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	INIT_LIST_HEAD(&pd->channels);
 
 	/* Initialize channel parameters */
-	if (pdat)
-		num_chan = max_t(int, pdat->nr_valid_peri, pcfg->num_chan);
-	else
-		num_chan = max_t(int, pcfg->num_peri, pcfg->num_chan);
+	num_chan = max_t(int, pcfg->num_peri, pcfg->num_chan);
 
 	pl330->num_peripherals = num_chan;
 
@@ -2922,11 +2915,8 @@ static int __maybe_unused pl330_resume(struct device *dev)
 
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
@@ -2939,15 +2929,11 @@ static int __maybe_unused pl330_resume(struct device *dev)
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
index fe93758..0000000
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

