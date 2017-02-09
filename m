From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v8 0/3] DMA Engine: switch PL330 driver to non-irq-safe runtime
 PM
Date: Thu, 09 Feb 2017 15:22:48 +0100
Message-ID: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170209142307eucas1p2592bbad82dbbffc56bbd993f5a890981@eucas1p2.samsung.com>
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
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
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

For more details of the proposed change to the PL330 driver see patch #3.

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

This patchset is based on linux-next from 9th February 2017.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v8:
- reworked slave device assignment, now it is done in separate callbacks as
  requested by Lars-Peter Clausen, no more changes to of_xlate callback
  in every dma engine driver are needed in this approach
- reworked pl330 patch to use new device_{set,release}_slave callbacks
- dropped tags because of the code changes
- rebased onto linux next-20170209

v7: https://www.spinics.net/lists/arm-kernel/msg557696.html
- added missing of_dma_request_slave_channel API change to sound/soc/sh/rcar
  driver
- extended commit message with information about drawbacks of irq-safe
  runtime pm
- added Ulf's reviewed-by tags

v6: https://www.spinics.net/lists/arm-kernel/msg557377.html
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

Marek Szyprowski (3):
  dmaengine: Add new device_{set,release}_slave callbacks
  dmaengine: pl330: remove pdata based initialization
  dmaengine: pl330: Don't require irq-safe runtime PM

 arch/arm/plat-samsung/devs.c |   1 -
 drivers/dma/dmaengine.c      |  27 +++++-
 drivers/dma/pl330.c          | 219 +++++++++++++++++--------------------------
 include/linux/amba/pl330.h   |  35 -------
 include/linux/dmaengine.h    |  10 ++
 5 files changed, 119 insertions(+), 173 deletions(-)
 delete mode 100644 include/linux/amba/pl330.h

-- 
1.9.1
