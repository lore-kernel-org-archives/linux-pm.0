From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v9 0/4] add reboot mode driver
Date: Mon, 20 Jun 2016 14:34:50 +0800
Message-ID: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:40564 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbcFTGwL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 02:52:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: k.kozlowski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at, Andy Yan <andy.yan@rock-chips.com>


This driver parses the reboot commands like "reboot bootloader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the corresponding  write interfae
to store the boot mode in some place like special register
or ram , which can be read by the bootloader after system
reboot.

This is commonly done on Android based devices, in order to
reboot the device into fastboot or recovery mode.


Changes in v9:
- select MFD_SYSCON when syscon-reboot-mode driver enabled
- refactoring error handling in reboot_mode_register

Changes in v8:
- do some cleanup when driver ubind

Changes in v7:
- fix some spelling mistakes
- declare that the mode magic should be none-zero value
- address some suggestions from Krzysztof, make syscon-reboot-mode driver data self-contained.

Changes in v6:
- fix a typo with "property"
- describe property "mask" more clear

Changes in v5:
- delete a unnecessary blank line in syscon-reboot-mode.txt
- rename mode-fastoboot to mode-bootloader in syscon-reboot-mode.txt
- rename macro BOOT_LOADER to BOOT_BL_DOWNLOAD, which gives a more clear mean
- use two blank space under help in Kconfig
- use unsigned int instead of int for member magic in struct mode_info

Changes in v4:
- remove mode-maskrom
- rename mode-fastboot to mode-bootloader to keep compatible with the exiting Android device
- make this driver depends on OF to avoid kbuild test error

Changes in v3:
- descirbe all reboot mode as properity instead of subnode
- scan multi properities
- add mask value for some platform which only use some bits of the register
  to store boot mode magic value
- descirbe all reboot mode as property instead of subnode
- add rk3036 support
- descirbe all reboot mode as property instead of subnode

Changes in v2:
- move to dir drivers/power/reset/
- make syscon-reboot-mode a generic driver
- make this node as a subnode of PMU
- make this node as a subnode of pmugrf

Changes in v1:
- fix the embarrassed compile warning
- correct the maskrom magic number
- check for the normal reboot
- correct the maskrom magic number
- use macro defined in rockchip_boot-mode.h for reboot-mode DT node

Andy Yan (4):
  dt-bindings: power: reset: add document for reboot-mode driver
  power: reset: add reboot mode driver
  ARM: dts: rockchip: add syscon-reboot-mode DT node
  ARM64: dts: rockchip: add syscon-reboot-mode DT node

 .../bindings/power/reset/reboot-mode.txt           |  25 ++++
 .../bindings/power/reset/syscon-reboot-mode.txt    |  35 ++++++
 arch/arm/boot/dts/rk3036.dtsi                      |  11 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  10 ++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  12 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  12 +-
 drivers/power/reset/Kconfig                        |  14 +++
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/reboot-mode.c                  | 128 +++++++++++++++++++++
 drivers/power/reset/reboot-mode.h                  |  14 +++
 drivers/power/reset/syscon-reboot-mode.c           | 100 ++++++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h       |  15 +++
 12 files changed, 375 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

-- 
2.7.4


