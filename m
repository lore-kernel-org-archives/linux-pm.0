From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v4 0/4] thermal: add brcmstb AVS TMON driver
Date: Wed,  9 Aug 2017 15:02:53 -0700
Message-ID: <20170809220257.4234-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Doug Berger <opendmb@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

This series adds the brcmstb AVS TMON driver.

The driver was originally written by Brian Norris.

This series is also available at
https://github.com/mmayer/linux/tree/brcmstb-thermal-4.13-v4.

v1 of this series can be found at https://lkml.org/lkml/2017/6/5/921
v2 of this series can be found at https://lkml.org/lkml/2017/7/21/585
v3 of this series can be found at https://lkml.org/lkml/2017/7/31/710

Changes since v3:
- Rebased on v4.13-rc3 to resolve conflicts in the MAINTAINERS file

Changes since v2:
- replaced calls to pr_debug() with calls to dev_dbg() [PATCH 2/4 only]
- all other patches are unchanged from v2

Changes since v1:
- Fixed wording in binding document
- Fixed lincensing to consistently mention GPL v2
- Use thermal_zone_get_slope() and thermal_zone_get_offset()
- Some minor clean-ups

Brian Norris (2):
  Documentation: devicetree: add binding for Broadcom STB AVS TMON
  thermal: add brcmstb AVS TMON driver

Markus Mayer (2):
  ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL
  arm64: defconfig: add CONFIG_BRCMSTB_THERMAL

 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  20 ++
 MAINTAINERS                                        |   8 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/broadcom/Kconfig                   |   7 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/brcmstb_thermal.c         | 386 +++++++++++++++++++++
 8 files changed, 425 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c

-- 
2.7.4
