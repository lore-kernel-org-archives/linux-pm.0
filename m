From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 09/16] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock
 Domain
Date: Wed,  1 Jul 2015 17:58:03 +0200
Message-ID: <1435766290-3005-10-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add an appropriate "#power-domain-cells" property to the cpg_clocks
device node, to create the CPG/MSTP Clock Domain.

Add "power-domains" properties to all device nodes for devices that are
part of the CPG/MSTP Clock Domain and can be power-managed through an
MSTP clock.  This applies to most on-SoC devices, which have a
one-to-one mapping from SoC device to DT device node.  Notable
exceptions are the "display" and "sound" nodes, which represent multiple
SoC devices, each having their own MSTP clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v3:
  - Add "power-domains" property to recently introduced Ethernet AVB
    device node,
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - Add Reviewed-by,
  - Add "power-domains" properties to recently introduced USB-DMAC
    device nodes,
  - Drop adding "power-domains" properties to the GIC device node, as
    adding the INTC_SYS clock is postponed.
---
 arch/arm/boot/dts/r8a7790.dtsi | 79 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 3ae0c3bfb9b96130..83cb6b4de8332118 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -134,6 +134,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO0>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -146,6 +147,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -158,6 +160,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -170,6 +173,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -182,6 +186,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO4>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -194,6 +199,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO5>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	thermal@e61f0000 {
@@ -201,6 +207,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	timer {
@@ -218,6 +225,7 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -237,6 +245,7 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -253,6 +262,7 @@
 			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7790_CLK_IRQC>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -281,6 +291,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -311,6 +322,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -339,6 +351,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -367,6 +380,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -378,6 +392,7 @@
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC0>;
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -389,6 +404,7 @@
 			      0 110 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC1>;
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -400,6 +416,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -410,6 +427,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -420,6 +438,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -430,6 +449,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -440,6 +460,7 @@
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -452,6 +473,7 @@
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -464,6 +486,7 @@
 		reg = <0 0xe6520000 0 0x425>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x69>, <&dmac0 0x6a>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -476,6 +499,7 @@
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -486,6 +510,7 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
@@ -498,6 +523,7 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>;
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
@@ -515,6 +541,7 @@
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -525,6 +552,7 @@
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -535,6 +563,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -545,6 +574,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -558,6 +588,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -569,6 +600,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -580,6 +612,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -591,6 +624,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -602,6 +636,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -613,6 +648,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -624,6 +660,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -635,6 +672,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -646,6 +684,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -657,6 +696,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -665,6 +705,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -676,6 +717,7 @@
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHERAVB>;
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -686,6 +728,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -694,6 +737,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -702,6 +746,7 @@
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		power-domains = <&cpg_clocks>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -718,6 +763,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
 		clock-names = "usbhs";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -732,33 +778,37 @@
 
 	vin0: video@e6ef0000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin1: video@e6ef1000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin2: video@e6ef2000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin3: video@e6ef3000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
 		reg = <0 0xe6ef3000 0 0x1000>;
 		interrupts = <0 191 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -767,6 +817,7 @@
 		reg = <0 0xfe920000 0 0x8000>;
 		interrupts = <0 266 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-sru;
 		renesas,#rpf = <5>;
@@ -779,6 +830,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -792,6 +844,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -805,6 +858,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -859,6 +913,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -869,6 +924,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -946,6 +1002,7 @@
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "sd1",
 					     "z", "rcan", "adsp";
+			#power-domain-cells = <0>;
 		};
 
 		/* Variable factor clocks */
@@ -1333,6 +1390,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1346,6 +1404,7 @@
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1358,6 +1417,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1370,6 +1430,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1382,6 +1443,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
 		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1392,6 +1454,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
+		power-domains = <&cpg_clocks>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1400,10 +1463,11 @@
 	pci0: pci@ee090000 {
 		compatible = "renesas,pci-r8a7790";
 		device_type = "pci";
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1434,10 +1498,11 @@
 	pci1: pci@ee0b0000 {
 		compatible = "renesas,pci-r8a7790";
 		device_type = "pci";
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		reg = <0 0xee0b0000 0 0xc00>,
 		      <0 0xee0a0000 0 0x1100>;
 		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1455,6 +1520,7 @@
 		compatible = "renesas,pci-r8a7790";
 		device_type = "pci";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
@@ -1507,6 +1573,7 @@
 		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
-- 
1.9.1
