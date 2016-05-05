From: Chris Brand <chris.brand@broadcom.com>
Subject: [PATCH 0/6] Support BCM23550 SoC
Date: Thu,  5 May 2016 13:48:48 -0700
Message-ID: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@arm.linux.org.uk>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

This patchset introduces support for the BCM23550 SoC and the Broadcom
Sparrow development board.

It modifies the BCM21664 support slightly to share code between the two.

With this patchset, a multi-v7 kernel brings up all 4 CPUs on a Sparrow
board, and gets to a shell prompt. Many of the IP blocks that are shared
with BCM28155 and BCM21664 are also functional, although not all have
been thoroughly tested.

Chris Brand (6):
  power: Introduce Broadcom kona reset driver
  arm: bcm21664: Remove reset code
  docs: Document BCM23550 bindings
  arm: Add support for Broadcom BCM23550 SoC
  arm: BCM23550 SMP support
  arm: dt: bcm23550: Add device tree files

 .../bindings/arm/bcm/brcm,bcm23550-cpu-method.txt  |  36 ++
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.txt  |  15 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/bcm23550-sparrow.dts             |  75 ++++
 arch/arm/boot/dts/bcm23550.dtsi                    | 419 +++++++++++++++++++++
 arch/arm/mach-bcm/Kconfig                          |  12 +-
 arch/arm/mach-bcm/Makefile                         |   5 +-
 arch/arm/mach-bcm/board_bcm21664.c                 |  42 ---
 arch/arm/mach-bcm/board_bcm23550.c                 |  25 ++
 arch/arm/mach-bcm/platsmp.c                        |  58 +++
 drivers/power/reset/Kconfig                        |  10 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/brcm-kona-reset.c              |  75 ++++
 14 files changed, 731 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
 create mode 100644 arch/arm/boot/dts/bcm23550-sparrow.dts
 create mode 100644 arch/arm/boot/dts/bcm23550.dtsi
 create mode 100644 arch/arm/mach-bcm/board_bcm23550.c
 create mode 100644 drivers/power/reset/brcm-kona-reset.c

-- 
1.9.1
