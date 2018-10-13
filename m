From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
Date: Sat, 13 Oct 2018 17:17:05 +0200
Message-ID: <20181013151707.32210-7-hch@lst.de>
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
 drivers/gpu/drm/sti/sti_gdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index c32de6cbf061..cdf0a1396e00 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -517,7 +517,7 @@ static void sti_gdp_init(struct sti_gdp *gdp)
 	/* Allocate all the nodes within a single memory page */
 	size = sizeof(struct sti_gdp_node) *
 	    GDP_NODE_PER_FIELD * GDP_NODE_NB_BANK;
-	base = dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL | GFP_DMA);
+	base = dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL);
 
 	if (!base) {
 		DRM_ERROR("Failed to allocate memory for GDP node\n");
-- 
2.19.1
