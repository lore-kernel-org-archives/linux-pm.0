From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v7 5/6] arm64: dts: add QorIQ LX2160A SoC support
Date: Mon, 29 Oct 2018 08:57:54 +0000
Message-ID: <1540759926-3641-6-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel-owner@vger.kernel.org
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Ramneek Mehresh <ramneek.mehresh@nxp.com>, Ying Zhang <ying.zhang22455@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Sriram Dash <sriram.dash@nxp.com>, Horia Geanta <horia.geanta@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
List-Id: linux-pm@vger.kernel.org

LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.

LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor cores
in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8 I2C
controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011 SBSA
UARTs etc.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 766 +++++++++++++++++++++=
++++
 1 file changed, 766 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
new file mode 100644
index 0000000..a79f5c1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -0,0 +1,766 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree Include file for Layerscape-LX2160A family SoC.
+//
+// Copyright 2018 NXP
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	compatible =3D "fsl,lx2160a";
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		// 8 clusters having 2 Cortex-A72 cores each
+		cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x0>;
+			clocks =3D <&clockgen 1 0>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster0_l2>;
+		};
+
+		cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x1>;
+			clocks =3D <&clockgen 1 0>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster0_l2>;
+		};
+
+		cpu@100 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x100>;
+			clocks =3D <&clockgen 1 1>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster1_l2>;
+		};
+
+		cpu@101 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x101>;
+			clocks =3D <&clockgen 1 1>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster1_l2>;
+		};
+
+		cpu@200 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x200>;
+			clocks =3D <&clockgen 1 2>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster2_l2>;
+		};
+
+		cpu@201 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x201>;
+			clocks =3D <&clockgen 1 2>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster2_l2>;
+		};
+
+		cpu@300 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x300>;
+			clocks =3D <&clockgen 1 3>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster3_l2>;
+		};
+
+		cpu@301 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x301>;
+			clocks =3D <&clockgen 1 3>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster3_l2>;
+		};
+
+		cpu@400 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x400>;
+			clocks =3D <&clockgen 1 4>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster4_l2>;
+		};
+
+		cpu@401 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x401>;
+			clocks =3D <&clockgen 1 4>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster4_l2>;
+		};
+
+		cpu@500 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x500>;
+			clocks =3D <&clockgen 1 5>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster5_l2>;
+		};
+
+		cpu@501 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x501>;
+			clocks =3D <&clockgen 1 5>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster5_l2>;
+		};
+
+		cpu@600 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x600>;
+			clocks =3D <&clockgen 1 6>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster6_l2>;
+		};
+
+		cpu@601 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x601>;
+			clocks =3D <&clockgen 1 6>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster6_l2>;
+		};
+
+		cpu@700 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x700>;
+			clocks =3D <&clockgen 1 7>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster7_l2>;
+		};
+
+		cpu@701 {
+			device_type =3D "cpu";
+			compatible =3D "arm,cortex-a72";
+			enable-method =3D "psci";
+			reg =3D <0x701>;
+			clocks =3D <&clockgen 1 7>;
+			d-cache-size =3D <0x8000>;
+			d-cache-line-size =3D <64>;
+			d-cache-sets =3D <128>;
+			i-cache-size =3D <0xC000>;
+			i-cache-line-size =3D <64>;
+			i-cache-sets =3D <192>;
+			next-level-cache =3D <&cluster7_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster4_l2: l2-cache4 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster5_l2: l2-cache5 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster6_l2: l2-cache6 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+
+		cluster7_l2: l2-cache7 {
+			compatible =3D "cache";
+			cache-size =3D <0x100000>;
+			cache-line-size =3D <64>;
+			cache-sets =3D <1024>;
+			cache-level =3D <2>;
+		};
+	};
+
+	gic: interrupt-controller@6000000 {
+		compatible =3D "arm,gic-v3";
+		reg =3D <0x0 0x06000000 0 0x10000>, // GIC Dist
+			<0x0 0x06200000 0 0x200000>, // GICR (RD_base +
+						     // SGI_base)
+			<0x0 0x0c0c0000 0 0x2000>, // GICC
+			<0x0 0x0c0d0000 0 0x1000>, // GICH
+			<0x0 0x0c0e0000 0 0x20000>; // GICV
+		#interrupt-cells =3D <3>;
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+		interrupt-controller;
+		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its: gic-its@6020000 {
+			compatible =3D "arm,gic-v3-its";
+			msi-controller;
+			reg =3D <0x0 0x6020000 0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible =3D "arm,cortex-a72-pmu";
+		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible =3D "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	memory@80000000 {
+		// DRAM space - 1, size : 2 GB DRAM
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x80000000 0 0x80000000>;
+	};
+
+	ddr1: memory-controller@1080000 {
+		compatible =3D "fsl,qoriq-memory-controller";
+		reg =3D <0x0 0x1080000 0x0 0x1000>;
+		interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	ddr2: memory-controller@1090000 {
+		compatible =3D "fsl,qoriq-memory-controller";
+		reg =3D <0x0 0x1090000 0x0 0x1000>;
+		interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	// One clock unit-sysclk node which bootloader require during DT fix-up
+	sysclk: sysclk {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <100000000>; // fixed up by bootloader
+		clock-output-names =3D "sysclk";
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		crypto: crypto@8000000 {
+			compatible =3D "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era =3D <10>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0x0 0x00 0x8000000 0x100000>;
+			reg =3D <0x00 0x8000000 0x0 0x100000>;
+			interrupts =3D <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+			status =3D "disabled";
+
+			sec_jr0: jr@10000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x10000 0x10000>;
+				interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr@20000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x20000 0x10000>;
+				interrupts =3D <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr@30000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x30000 0x10000>;
+				interrupts =3D <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr@40000 {
+				compatible =3D "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        =3D <0x40000 0x10000>;
+				interrupts =3D <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		clockgen: clock-controller@1300000 {
+			compatible =3D "fsl,lx2160a-clockgen";
+			reg =3D <0 0x1300000 0 0xa0000>;
+			#clock-cells =3D <2>;
+			clocks =3D <&sysclk>;
+		};
+
+		dcfg: syscon@1e00000 {
+			compatible =3D "fsl,lx2160a-dcfg", "syscon";
+			reg =3D <0x0 0x1e00000 0x0 0x10000>;
+			little-endian;
+		};
+
+		i2c0: i2c@2000000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2000000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			scl-gpio =3D <&gpio2 15 GPIO_ACTIVE_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@2010000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2010000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@2020000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2020000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@2030000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2030000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@2040000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2040000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			scl-gpio =3D <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c5: i2c@2050000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2050000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c6: i2c@2060000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2060000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		i2c7: i2c@2070000 {
+			compatible =3D "fsl,vf610-i2c";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x2070000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names =3D "i2c";
+			clocks =3D <&clockgen 4 7>;
+			status =3D "disabled";
+		};
+
+		esdhc0: esdhc@2140000 {
+			compatible =3D "fsl,esdhc";
+			reg =3D <0x0 0x2140000 0x0 0x10000>;
+			interrupts =3D <0 28 0x4>; /* Level high type */
+			clocks =3D <&clockgen 4 1>;
+			voltage-ranges =3D <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
+		esdhc1: esdhc@2150000 {
+			compatible =3D "fsl,esdhc";
+			reg =3D <0x0 0x2150000 0x0 0x10000>;
+			interrupts =3D <0 63 0x4>; /* Level high type */
+			clocks =3D <&clockgen 4 1>;
+			voltage-ranges =3D <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			broken-cd;
+			little-endian;
+			bus-width =3D <4>;
+			status =3D "disabled";
+		};
+
+		uart0: serial@21c0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21c0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@21d0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21d0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		uart2: serial@21e0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21e0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		uart3: serial@21f0000 {
+			compatible =3D "arm,sbsa-uart","arm,pl011";
+			reg =3D <0x0 0x21f0000 0x0 0x1000>;
+			interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed =3D <115200>;
+			status =3D "disabled";
+		};
+
+		gpio0: gpio@2300000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2300000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		gpio1: gpio@2310000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2310000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		gpio2: gpio@2320000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2320000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		gpio3: gpio@2330000 {
+			compatible =3D "fsl,qoriq-gpio";
+			reg =3D <0x0 0x2330000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells =3D <2>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+
+		watchdog@23a0000 {
+			compatible =3D "arm,sbsa-gwdt";
+			reg =3D <0x0 0x23a0000 0 0x1000>,
+			      <0x0 0x2390000 0 0x1000>;
+			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			timeout-sec =3D <30>;
+		};
+
+		usb0: usb@3100000 {
+			compatible =3D "snps,dwc3";
+			reg =3D <0x0 0x3100000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode =3D "host";
+			snps,quirk-frame-length-adjustment =3D <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status =3D "disabled";
+		};
+
+		usb1: usb@3110000 {
+			compatible =3D "snps,dwc3";
+			reg =3D <0x0 0x3110000 0x0 0x10000>;
+			interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode =3D "host";
+			snps,quirk-frame-length-adjustment =3D <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status =3D "disabled";
+		};
+
+		smmu: iommu@5000000 {
+			compatible =3D "arm,mmu-500";
+			reg =3D <0 0x5000000 0 0x800000>;
+			#iommu-cells =3D <1>;
+			#global-interrupts =3D <14>;
+				     // global secure fault
+			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined secure
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     // global non-secure fault
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined non-secure
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     // performance counter interrupts 0-9
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     // per context interrupt, 64 interrupts
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+		};
+	};
+};
--=20
2.7.4
