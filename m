From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/12] Partial MIPS Malta DT conversion
Date: Fri, 2 Sep 2016 16:48:46 +0100
Message-ID: <20160902154859.24269-1-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andy Yan <andy.yan@rock-chips.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, John Stultz <john.stultz@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Brand <chris.brand@broadcom.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Stephan Linz <linz@li-pro.net>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-pm@vger.kernel.org

This series begins converting the MIPS Malta board to use device tree to
probe its various devices & peripherals, with the eventual goal of
including Malta support in generic kernels.

In terms of use the only change should be that kernels will
automatically make use of more than 256MB DDR when built for 64 bit, or
32 bit with highmem enabled.

The series leaves Malta with a significant amount less platform code and
thus closer to being ready for inclusion in a generic MIPS kernel.

Applies atop v4.8-rc4.

Paul Burton (12):
  irqchip: i8259: Add domain before mapping parent irq
  irqchip: i8259: Allow platforms to override poll function
  irqchip: i8259: Remove unused i8259A_irq_pending
  MIPS: Malta: Allow PCI devices DMA to lower 2GB physical
  MIPS: Malta: Use all available DDR by default
  MIPS: Malta: Probe interrupt controllers via DT
  MIPS: Malta: Probe RTC via DT
  MIPS: Malta: Probe pflash via DT
  MIPS: Malta: Use syscon-reboot driver to reboot
  MIPS: Malta: Remove custom halt implementation
  power: reset: Add Intel PIIX4 poweroff driver
  MIPS: Malta: Use PIIX4 poweroff driver to power down

 arch/mips/Kconfig                           |   7 +-
 arch/mips/boot/dts/mti/malta.dts            |  93 ++++++++++++++
 arch/mips/configs/malta_defconfig           |   5 +-
 arch/mips/configs/malta_kvm_defconfig       |   5 +-
 arch/mips/configs/malta_kvm_guest_defconfig |   5 +-
 arch/mips/configs/malta_qemu_32r6_defconfig |   3 +
 arch/mips/configs/maltaaprp_defconfig       |   3 +
 arch/mips/configs/maltasmvp_defconfig       |   3 +
 arch/mips/configs/maltasmvp_eva_defconfig   |   3 +
 arch/mips/configs/maltaup_defconfig         |   3 +
 arch/mips/configs/maltaup_xpa_defconfig     |   5 +-
 arch/mips/include/asm/i8259.h               |  12 +-
 arch/mips/mti-malta/Makefile                |   3 -
 arch/mips/mti-malta/malta-dtshim.c          | 187 +++++++++++++++++++++++++++-
 arch/mips/mti-malta/malta-init.c            |  17 ++-
 arch/mips/mti-malta/malta-int.c             |  96 +-------------
 arch/mips/mti-malta/malta-platform.c        |  65 ----------
 arch/mips/mti-malta/malta-pm.c              |  96 --------------
 arch/mips/mti-malta/malta-reset.c           |  47 -------
 drivers/irqchip/irq-i8259.c                 |  30 ++---
 drivers/power/reset/Kconfig                 |   9 ++
 drivers/power/reset/Makefile                |   1 +
 drivers/power/reset/piix4-poweroff.c        | 103 +++++++++++++++
 23 files changed, 452 insertions(+), 349 deletions(-)
 delete mode 100644 arch/mips/mti-malta/malta-pm.c
 delete mode 100644 arch/mips/mti-malta/malta-reset.c
 create mode 100644 drivers/power/reset/piix4-poweroff.c

-- 
2.9.3
