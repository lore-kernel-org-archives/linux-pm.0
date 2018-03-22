From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: [PATCH v2 0/8] arm: Base support for Renesas RZN1D-DB Board
Date: Thu, 22 Mar 2018 11:44:37 +0000
Message-ID: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <michel.pollet@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series adds the plain basic support for booting a bare
kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
minimum as a 'base', further patches that will add the
rest of the support, pinctrl, clock architecture and quite
a few others.

Thanks for the comments on the previous version!

v2: 
 + Fixes for suggestions by Simon Horman
 + Fixes for suggestions by Rob Herring
 + Fixes for suggestions by Geert Uytterhoeven
 + Removed the mach file
 + Added a MFD base for the sysctrl block
 + Added a regmap based sub driver for the reboot handler
 + Renamed the files to match shmobile conventions
 + Adapted the compatible= strings to reflect 'family' vs 'part'
   distinction.
 + Removed the sysctrl.h file entirelly. 
 + Fixed every warnings from the DTC compiler on W=12 mode.
 + Split the device-tree patches from the code.
 
Michel Pollet (8):
  DT: mfd: renesas,rzn1-sysctrl: document RZ/N1 sysctrl node
  DT: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
  DT: arm: renesas,r9a06g032: add the RZ/N1 bindings
  reset: Renesas RZ/N1 reboot driver
  arm: rzn1: Add the RZ/N1 arch to the shmobile Kconfig
  DT: arm: Add Renesas RZ/N1 SoC base device tree file
  DT: arm: Add Renesas RZN1D-DB Board base file
  DT: arm: Add the RZN1D-DB Board to Renesas Makefile target

 Documentation/devicetree/bindings/arm/shmobile.txt |   5 +-
 .../bindings/mfd/renesas,rzn1-sysctrl.txt          |  22 +++++
 .../bindings/power/renesas,rzn1-reboot.txt         |  22 +++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  26 +++++
 arch/arm/boot/dts/r9a06g0xx.dtsi                   |  96 ++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   5 +
 drivers/power/reset/Kconfig                        |   7 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/rzn1-reboot.c                  | 109 +++++++++++++++++++++
 10 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
 create mode 100644 arch/arm/boot/dts/r9a06g0xx.dtsi
 create mode 100644 drivers/power/reset/rzn1-reboot.c

-- 
2.7.4
