From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/3] DMA Engine: switch PL330 driver to non-irq-safe runtime PM
Date: Thu, 22 Dec 2016 13:11:26 +0100
Message-ID: <1482408689-21971-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161222121148epcas5p11d4e49a3724e375a989aa173f731346f@epcas5p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32881 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938739AbcLVMLv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 07:11:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

Hello,

This patchset changes the way the runtime PM is implemented in PL330 DMA
engine driver. The main goal of such change is to add support for audio
power domain to Exynos5 SoCs (5250, 542x, 5433, probably others) and let
it to be properly turned off, when no audio is being used. Switching to
non-irq-safe runtime PM is needed to properly let power domain to be
turned off (irqsafe runtime PM keeps power domain turned on all the time)
and to integrate with clock controller's runtime PM (this cannot be
workarounded any other way, PL330 uses clocks from the controller, which
belongs to the same power domain).

For more details of the proposed change to PL330 driver see patch #3.

Audio power domain on Exynos5 SoCs contains following hardware modules:
1. clock controller
2. pin controller
3. PL330 DMA controller
4. I2S audio controller

Patches for adding/fixing runtime PM for each of the above device will be
handled separately.

Runtime PM patches for clock controllers is possible and has been proposed
in the following thread (pending review, patch for runtime PM for Exynos
Audio subsystem will be added in v4 soon):
https://www.spinics.net/lists/arm-kernel/msg538122.html

Runtime PM support for Exynos pin controller will be posted soon in
a separate thread.

Exynos I2S driver already supports runtime PM, but some fixes are needed
for it and they will be also posted soon.

Patches are based on linux-next with my PL330 runtime PM fix patch
applied (which I assume will be merged as a fix to v4.10):
https://patchwork.kernel.org/patch/9477695/

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (3):
  dmaengine: pl330: remove pdata based initialization
  dmaengine: Forward slave device pointer to of_xlate callback
  dmaengine: pl330: Don't require irq-safe runtime PM

 drivers/dma/amba-pl08x.c        |   2 +-
 drivers/dma/at_hdmac.c          |   4 +-
 drivers/dma/at_xdmac.c          |   2 +-
 drivers/dma/bcm2835-dma.c       |   2 +-
 drivers/dma/coh901318.c         |   2 +-
 drivers/dma/cppi41.c            |   2 +-
 drivers/dma/dma-jz4780.c        |   2 +-
 drivers/dma/dmaengine.c         |   2 +-
 drivers/dma/dw/platform.c       |   2 +-
 drivers/dma/edma.c              |   4 +-
 drivers/dma/fsl-edma.c          |   2 +-
 drivers/dma/img-mdc-dma.c       |   2 +-
 drivers/dma/imx-dma.c           |   2 +-
 drivers/dma/imx-sdma.c          |   2 +-
 drivers/dma/k3dma.c             |   2 +-
 drivers/dma/mmp_pdma.c          |   2 +-
 drivers/dma/mmp_tdma.c          |   2 +-
 drivers/dma/moxart-dma.c        |   2 +-
 drivers/dma/mxs-dma.c           |   2 +-
 drivers/dma/nbpfaxi.c           |   2 +-
 drivers/dma/of-dma.c            |  20 +++--
 drivers/dma/pl330.c             | 166 +++++++++++++++++++---------------------
 drivers/dma/pxa_dma.c           |   2 +-
 drivers/dma/qcom/bam_dma.c      |   2 +-
 drivers/dma/sh/rcar-dmac.c      |   2 +-
 drivers/dma/sh/shdma-of.c       |   2 +-
 drivers/dma/sh/usb-dmac.c       |   2 +-
 drivers/dma/sirf-dma.c          |   2 +-
 drivers/dma/st_fdma.c           |   2 +-
 drivers/dma/ste_dma40.c         |   2 +-
 drivers/dma/stm32-dma.c         |   2 +-
 drivers/dma/sun4i-dma.c         |   2 +-
 drivers/dma/sun6i-dma.c         |   2 +-
 drivers/dma/tegra20-apb-dma.c   |   2 +-
 drivers/dma/tegra210-adma.c     |   2 +-
 drivers/dma/xilinx/xilinx_dma.c |   2 +-
 drivers/dma/xilinx/zynqmp_dma.c |   2 +-
 drivers/dma/zx296702_dma.c      |   2 +-
 include/linux/amba/pl330.h      |  35 ---------
 include/linux/of_dma.h          |  17 ++--
 40 files changed, 139 insertions(+), 175 deletions(-)
 delete mode 100644 include/linux/amba/pl330.h

-- 
1.9.1

