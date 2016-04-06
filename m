From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 0/7] MIPS: Loongson1B: add NAND, DMA and GPIO support
Date: Wed,  6 Apr 2016 20:09:30 +0800
Message-ID: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Kelvin Cheung <keguang.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patchset is to add NAND, DMA and GPIO support for Loongson1B,
and moreover, include some updates/fixes.

This applies on top of mips-for-linux-next.

Thanks!

Kelvin Cheung (7):
  clk: Loongson1: Update clocks of Loongson1B
  cpufreq: Loongson1: Update cpufreq of Loongson1B
  dmaengine: Loongson1: add Loongson1 dmaengine driver
  mtd: nand: add Loongson1 NAND driver
  gpio: Loongson1: add Loongson1 GPIO driver
  MIPS: Loongson1B: Some updates/fixes for LS1B
  MAINTAINERS: add Loongson1 architecture entry

 MAINTAINERS                                       |   9 +
 arch/mips/Kconfig                                 |   2 +
 arch/mips/configs/loongson1b_defconfig            | 125 +++++
 arch/mips/configs/ls1b_defconfig                  | 110 -----
 arch/mips/include/asm/mach-loongson32/cpufreq.h   |   1 -
 arch/mips/include/asm/mach-loongson32/dma.h       |  25 +
 arch/mips/include/asm/mach-loongson32/irq.h       |   1 -
 arch/mips/include/asm/mach-loongson32/loongson1.h |   4 +-
 arch/mips/include/asm/mach-loongson32/nand.h      |  30 ++
 arch/mips/include/asm/mach-loongson32/platform.h  |  14 +-
 arch/mips/include/asm/mach-loongson32/regs-clk.h  |  24 +-
 arch/mips/include/asm/mach-loongson32/regs-mux.h  |  84 ++--
 arch/mips/include/asm/mach-loongson32/regs-pwm.h  |  12 +-
 arch/mips/loongson32/common/platform.c            | 105 ++++-
 arch/mips/loongson32/common/reset.c               |  13 +-
 arch/mips/loongson32/common/time.c                |  27 +-
 arch/mips/loongson32/ls1b/board.c                 |  67 ++-
 drivers/clk/Makefile                              |   2 +-
 drivers/clk/clk-loongson1.c                       | 163 +++++++
 drivers/clk/clk-ls1x.c                            | 162 -------
 drivers/cpufreq/Makefile                          |   2 +-
 drivers/cpufreq/loongson1-cpufreq.c               | 230 +++++++++
 drivers/cpufreq/ls1x-cpufreq.c                    | 222 ---------
 drivers/dma/Kconfig                               |   9 +
 drivers/dma/Makefile                              |   1 +
 drivers/dma/loongson1-dma.c                       | 546 ++++++++++++++++++++++
 drivers/gpio/Kconfig                              |   7 +
 drivers/gpio/Makefile                             |   1 +
 drivers/gpio/gpio-loongson1.c                     | 102 ++++
 drivers/mtd/nand/Kconfig                          |   8 +
 drivers/mtd/nand/Makefile                         |   1 +
 drivers/mtd/nand/loongson1_nand.c                 | 522 +++++++++++++++++++++
 32 files changed, 2041 insertions(+), 590 deletions(-)
 create mode 100644 arch/mips/configs/loongson1b_defconfig
 delete mode 100644 arch/mips/configs/ls1b_defconfig
 create mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 create mode 100644 arch/mips/include/asm/mach-loongson32/nand.h
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/clk-ls1x.c
 create mode 100644 drivers/cpufreq/loongson1-cpufreq.c
 delete mode 100644 drivers/cpufreq/ls1x-cpufreq.c
 create mode 100644 drivers/dma/loongson1-dma.c
 create mode 100644 drivers/gpio/gpio-loongson1.c
 create mode 100644 drivers/mtd/nand/loongson1_nand.c

-- 
1.9.1

