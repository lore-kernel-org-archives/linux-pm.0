From: Christoph Hellwig <hch@lst.de>
Subject: remove bogus GFP_DMA32 flags for dma allocations
Date: Sat, 13 Oct 2018 17:16:59 +0200
Message-ID: <20181013151707.32210-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

dma_alloc_* internally selects the zone to allocate from based on the
DMA mask.  Remove all explicit uses of GFP_DMA32 with dma_alloc_*.
