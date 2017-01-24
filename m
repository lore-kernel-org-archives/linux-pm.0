From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v6 0/4] DMA Engine: switch PL330 driver to non-irq-safe runtime
 PM
Date: Tue, 24 Jan 2017 10:27:31 +0100
Message-ID: <1485250055-22137-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170124092750eucas1p2b806ec3340d9d57439cc6d8975b516ef@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

This patchset changes the way the runtime PM is implemented in the PL330 DMA
engine driver. The main goal of such change is to add support for the audio
power domain to Exynos5 SoCs (5250, 542x, 5433, probably others) and let
it to be properly turned off, when no audio is being used. Switching to
non-irq-safe runtime PM is required to properly let power domain to be
turned off (irq-safe runtime PM keeps power domain turned on all the time)
and to integrate with clock controller's runtime PM (this cannot be
workarounded any other way, PL330 uses clocks from the controller, which
belongs to the same power domain).

For more details of the proposed change to the PL330 driver see patch #4.

Audio power domain on Exynos5 SoCs contains following hardware modules:
1. clock controller
2. pin controller
3. PL330 DMA controller
4. I2S audio controller

Patches for adding or fixing runtime PM for each of the above devices is
handled separately.

Runtime PM patches for clock controllers is possible and has been proposed
in the following thread (pending review): "[PATCH v4 0/4] Add runtime PM
support for clocks (on Exynos SoC example)",
http://www.spinics.net/lists/arm-kernel/msg550747.html

Runtime PM support for Exynos pin controller has been posted in the
following thread: "[PATCH 0/9] Runtime PM for Exynos pin controller driver",
http://www.spinics.net/lists/arm-kernel/msg550161.html

Exynos I2S driver supports runtime PM, but some fixes were needed for it
and they are already queued to linux-next.

This patchset is based on linux-next from 24th January 2017 with "dmaengine:
pl330: fix double lock" patch applied.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v6:
- fixed pl330 system sleep suspend/resume callbacks, previous implementation
  incorrectly tried to unprepare clocks unconditionally - after a fix pl330
  suspend/resume callbacks can be simply replaced by generic
  pm_runtime_force_{suspend,resume} helpers, what simplifies code even more

v5: https://www.spinics.net/lists/arm-kernel/msg555001.html
- added Acks
- additional mutex is indeed not needed, rely on dma_list_mutex in dmaengine
  core, added comment about locking

v4: http://www.spinics.net/lists/dmaengine/msg12329.html
- rebased onto "dmaengine: pl330: fix double lock" patch:
  http://www.spinics.net/lists/dmaengine/msg12289.html
- added a mutex to protect runtime PM links creation/removal to avoid races
- moved mem2mem channel case handing to pl330_{add,del}_slave_pm_link
  functions to simplify code and error paths

v3: http://www.spinics.net/lists/dmaengine/msg12245.html
- removed pl330_filter function as suggested by Arnd Bergmann
- removed pl330.h from arch/arm/plat-samsung/devs.c
- fixes some minor style issues pointed by Krzysztof Kozlowski

v2: https://www.spinics.net/lists/arm-kernel/msg552772.html
- rebased onto linux next-20170109
- improved patch description
- separated patch #3 from #4 (storing a pointer to slave device for each
  DMA channel) as requested by Krzysztof Kozlowski

v1: https://www.spinics.net/lists/arm-kernel/msg550008.html
- initial version


Patch summary:

Marek Szyprowski (4):
  dmaengine: pl330: remove pdata based initialization
  dmaengine: Forward slave device pointer to of_xlate callback
  dmaengine: pl330: Store pointer to slave device
  dmaengine: pl330: Don't require irq-safe runtime PM

 arch/arm/plat-samsung/devs.c    |   1 -
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
 drivers/dma/lpc18xx-dmamux.c    |   2 +-
 drivers/dma/mmp_pdma.c          |   2 +-
 drivers/dma/mmp_tdma.c          |   2 +-
 drivers/dma/moxart-dma.c        |   2 +-
 drivers/dma/mxs-dma.c           |   2 +-
 drivers/dma/nbpfaxi.c           |   2 +-
 drivers/dma/of-dma.c            |  20 ++--
 drivers/dma/pl330.c             | 220 ++++++++++++++++------------------------
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
 drivers/dma/zx_dma.c            |   2 +-
 include/linux/amba/pl330.h      |  35 -------
 include/linux/of_dma.h          |  17 ++--
 42 files changed, 145 insertions(+), 226 deletions(-)
 delete mode 100644 include/linux/amba/pl330.h

-- 
1.9.1
