From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 0/4] add reboot mode driver
Date: Tue,  2 Feb 2016 17:56:21 +0800
Message-ID: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:36938 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbcBBJ6m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 04:58:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, arnd@arndb.de, john.stultz@linaro.org
Cc: moritz.fischer@ettus.com, matthias.bgg@gmail.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, heiko@sntech.de, sre@kernel.org, dbaryshkov@gmail.com, alexandre.belloni@free-electrons.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, wxt@rock-chips.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, richard@nod.at, dwmw2@infradead.org, mark.rutland@arm.com, Andy Yan <andy.yan@rock-chips.com>


This driver parse the reboot commands like "reboot loader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the corresponding  write interfae
to store the boot mode in some place like special register
or ram , which can be read by the bootloader after system
reboot.

This is commonly done on Android based devices, in order to
reboot the device into fastboot or recovery mode.

Changes in v3:
- descirbe all reboot mode as properity instead of subnode
- add mask value for some platform which only use some bits of the register
  to store boot mode magic value
- add rk3036 support

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
  ARM: dts: rockchip: add syscon-reboot-mode node
  ARM64: dts: rockchip: add syscon-reboot-mode DT node

 .../bindings/power/reset/reboot-mode.txt           |  26 +++++
 .../bindings/power/reset/syscon-reboot-mode.txt    |  36 +++++++
 arch/arm/boot/dts/rk3036.dtsi                      |  10 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  11 +++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  13 ++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  14 ++-
 drivers/power/reset/Kconfig                        |  16 ++++
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/reboot-mode.c                  | 105 +++++++++++++++++++++
 drivers/power/reset/reboot-mode.h                  |   6 ++
 drivers/power/reset/syscon-reboot-mode.c           |  64 +++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h       |  30 ++++++
 12 files changed, 330 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

-- 
1.9.1


