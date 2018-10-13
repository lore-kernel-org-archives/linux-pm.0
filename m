From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/8] sound: intel/sst: don't pass GFP_DMA32 to dma_alloc_coherent
Date: Sat, 13 Oct 2018 17:17:04 +0200
Message-ID: <20181013151707.32210-6-hch@lst.de>
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
 sound/soc/intel/common/sst-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 11041aedea31..1e067504b604 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -355,7 +355,7 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 
 	/* allocate DMA buffer to store FW data */
 	sst_fw->dma_buf = dma_alloc_coherent(dsp->dma_dev, sst_fw->size,
-				&sst_fw->dmable_fw_paddr, GFP_DMA | GFP_KERNEL);
+				&sst_fw->dmable_fw_paddr, GFP_KERNEL);
 	if (!sst_fw->dma_buf) {
 		dev_err(dsp->dev, "error: DMA alloc failed\n");
 		kfree(sst_fw);
-- 
2.19.1
