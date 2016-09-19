From: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 00/14] Partial MIPS Malta DT conversion
Date: Mon, 19 Sep 2016 22:21:17 +0100
Message-ID: <20160919212132.28893-1-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Chris Brand <chris.brand-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>S
List-Id: linux-pm@vger.kernel.org

This series begins converting the MIPS Malta board to use device tree to
probe its various devices & peripherals, with the eventual goal of
including Malta support in generic kernels.

In terms of use the only change should be that kernels will
automatically make use of more than 256MB DDR when built for 64 bit, or
32 bit with highmem enabled.

The series leaves Malta with a significant amount less platform code and
thus closer to being ready for inclusion in a generic MIPS kernel.

Applies atop v4.8-rc7.

Paul Burton (14):
  irqchip: i8259: Add domain before mapping parent irq
  irqchip: i8259: Allow platforms to override poll function
  irqchip: i8259: Remove unused i8259A_irq_pending
  MIPS: Malta: Allow PCI devices DMA to lower 2GB physical
  MIPS: Malta: Use all available DDR by default
  MIPS: Malta: Probe interrupt controllers via DT
  of/platform: Probe "isa" busses by default
  MIPS: Malta: Remove custom DT match table
  MIPS: Malta: Probe RTC via DT
  MIPS: Malta: Probe pflash via DT
  MIPS: Malta: Use syscon-reboot driver to reboot
  MIPS: Malta: Remove custom halt implementation
  power: reset: Add Intel PIIX4 poweroff driver
  MIPS: Malta: Use PIIX4 poweroff driver to power down

 arch/mips/Kconfig                           |   7 +-
 arch/mips/boot/dts/mti/malta.dts            |  99 +++++++++++++++
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
 arch/mips/mti-malta/Makefile                |   2 -
 arch/mips/mti-malta/malta-dt.c              |  15 ---
 arch/mips/mti-malta/malta-dtshim.c          | 187 +++++++++++++++++++++++++++-
 arch/mips/mti-malta/malta-init.c            |  17 ++-
 arch/mips/mti-malta/malta-int.c             |  96 +-------------
 arch/mips/mti-malta/malta-platform.c        |  65 ----------
 arch/mips/mti-malta/malta-pm.c              |  96 --------------
 arch/mips/mti-malta/malta-reset.c           |  47 -------
 drivers/irqchip/irq-i8259.c                 |  30 ++---
 drivers/of/platform.c                       |   1 +
 drivers/power/reset/Kconfig                 |  10 ++
 drivers/power/reset/Makefile                |   1 +
 drivers/power/reset/piix4-poweroff.c        | 104 ++++++++++++++++
 25 files changed, 461 insertions(+), 363 deletions(-)
 delete mode 100644 arch/mips/mti-malta/malta-pm.c
 delete mode 100644 arch/mips/mti-malta/malta-reset.c
 create mode 100644 drivers/power/reset/piix4-poweroff.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
