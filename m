From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/8] spi: pic32-sqi: don't pass GFP_DMA32 to dma_alloc_coherent
Date: Sat, 13 Oct 2018 17:17:02 +0200
Message-ID: <20181013151707.32210-4-hch@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181013151707.32210-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The DMA API does its own zone decisions based on the coherent_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/spi/spi-pic32-sqi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index bd1c6b53283f..ab53e461d80f 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -468,7 +468,7 @@ static int ring_desc_ring_alloc(struct pic32_sqi *sqi)
 	/* allocate coherent DMAable memory for hardware buffer descriptors. */
 	sqi->bd = dma_zalloc_coherent(&sqi->master->dev,
 				      sizeof(*bd) * PESQI_BD_COUNT,
-				      &sqi->bd_dma, GFP_DMA32);
+				      &sqi->bd_dma, GFP_KERNEL);
 	if (!sqi->bd) {
 		dev_err(&sqi->master->dev, "failed allocating dma buffer\n");
 		return -ENOMEM;
-- 
2.19.1
