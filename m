From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 0/5] arm64: dts: NXP: add basic dts file for LX2160A SoC
Date: Mon, 20 Aug 2018 12:17:11 +0530
Message-ID: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc: linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
List-Id: linux-pm@vger.kernel.org

- Add compatible string for LX2160A clockgen support
- Add compatible string to initialize LX2160A guts driver
- Add compatible string for LX2160A support in dt-bindings
- Add dts file to enable support for LX2160A SoC and LX2160A RDB
  (Reference design board)

Vabhav Sharma (4):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add compatible string for LX2160A
  arm64: dts: add QorIQ LX2160A SoC support
  arm64: dts: add LX2160ARDB board support

Yogesh Gaur (1):
  drivers: clk-qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt     |  12 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  95 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 572 ++++++++++++++++++++++
 drivers/clk/clk-qoriq.c                           |  14 +-
 drivers/cpufreq/qoriq-cpufreq.c                   |   1 +
 drivers/soc/fsl/guts.c                            |   1 +
 7 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4
