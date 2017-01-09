From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 0/4] DMA Engine: switch PL330 driver to non-irq-safe runtime
 PM
Date: Mon, 09 Jan 2017 15:03:14 +0100
Message-ID: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170109140324eucas1p2c2b981ae2222c6a4e3dcb3e5ce3c607d@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
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

This patchset is based on linux-next from 9th January 2017.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v2:
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
 drivers/dma/zx_dma.c            |   2 +-
 include/linux/amba/pl330.h      |  35 ---------
 include/linux/of_dma.h          |  17 ++--
 41 files changed, 140 insertions(+), 176 deletions(-)
 delete mode 100644 include/linux/amba/pl330.h

-- 
1.9.1
