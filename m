From: Robin Gong <b38343@freescale.com>
Subject: [PATCH v2 0/3] add power off driver for i.mx6
Date: Fri, 12 Sep 2014 16:48:56 +0800
Message-ID: <1410511739-31122-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@freescale.com, kernel@pengutronix.de, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, grant.likely@linaro.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add simple power off driver for i.mx6, including:
- add basic imx-snvs-poweroff driver in drivers/power/reset
- add device node in all dts files of i.mx6.
- enable in config file

Robin Gong (3):
  ARM: dts: imx6: add pm_power_off support for i.mx6 chips
  power: reset: imx-snvs-poweroff: add power off driver for i.mx6
  ARM: configs: imx_v6_v7_defconfig: add power off driver

 arch/arm/boot/dts/imx6qdl.dtsi          |  5 +++
 arch/arm/boot/dts/imx6sl.dtsi           |  5 +++
 arch/arm/boot/dts/imx6sx.dtsi           |  5 +++
 arch/arm/configs/imx_v6_v7_defconfig    |  3 ++
 drivers/power/reset/Kconfig             |  5 +++
 drivers/power/reset/Makefile            |  1 +
 drivers/power/reset/imx-snvs-poweroff.c | 69 +++++++++++++++++++++++++++++++++
 7 files changed, 93 insertions(+)
 create mode 100644 drivers/power/reset/imx-snvs-poweroff.c

-- 
1.9.1
