From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 3/4] dmaengine: pl330: Store pointer to slave device
Date: Tue, 17 Jan 2017 13:48:57 +0100
Message-ID: <1484657338-26338-4-git-send-email-m.szyprowski@samsung.com>
References: <1484657338-26338-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124922eucas1p1d4037d80229e55007169cf85c19e5eec@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:10332 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAQMtx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 07:49:53 -0500
In-reply-to: <1484657338-26338-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

Store the pointer to slave device, which requested our channel. It will be
later used to implement runtime PM of PL330 DMA controller. Although
DMA channels might be requested many times, each DMA peripheral channel is
physically dedicated only for specific hardware, so there should be only
one slave device for each channel.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/pl330.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index b6b2cc912380..c77a3494659c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -450,6 +450,7 @@ struct dma_pl330_chan {
 
 	/* for runtime pm tracking */
 	bool active;
+	struct device *slave;
 };
 
 struct pl330_dmac {
@@ -2093,6 +2094,14 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	if (chan_id >= pl330->num_peripherals)
 		return NULL;
 
+	if (!pl330->peripherals[chan_id].slave) {
+		pl330->peripherals[chan_id].slave = slave;
+	} else if (pl330->peripherals[chan_id].slave != slave) {
+		dev_err(pl330->ddma.dev,
+			"Can't use same channel with multiple slave devices!\n");
+		return NULL;
+	}
+
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
-- 
1.9.1

