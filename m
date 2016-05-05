From: Chris Brand <chris.brand@broadcom.com>
Subject: [PATCH 6/6] arm: dt: bcm23550: Add device tree files
Date: Thu,  5 May 2016 13:48:54 -0700
Message-ID: <1462481334-8943-7-git-send-email-chris.brand@broadcom.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@arm.linux.org.uk>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

Add device tree files for the Broadcom BCM23550 SoC and the
Broadcom Sparrow board.

Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/bcm23550-sparrow.dts |  75 ++++++
 arch/arm/boot/dts/bcm23550.dtsi        | 419 +++++++++++++++++++++++++++++++++
 3 files changed, 496 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm23550-sparrow.dts
 create mode 100644 arch/arm/boot/dts/bcm23550.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923ce6fa..72ab80fa9079 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -95,7 +95,8 @@ dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
 	bcm958305k.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
 	bcm28155-ap.dtb \
-	bcm21664-garnet.dtb
+	bcm21664-garnet.dtb \
+	bcm23550-sparrow.dtb
 dtb-$(CONFIG_ARCH_BCM_NSP) += \
 	bcm958625k.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
diff --git a/arch/arm/boot/dts/bcm23550-sparrow.dts b/arch/arm/boot/dts/bcm23550-sparrow.dts
new file mode 100644
index 000000000000..ed9c51592e5e
--- /dev/null
+++ b/arch/arm/boot/dts/bcm23550-sparrow.dts
@@ -0,0 +1,75 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2016 Broadcom.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "bcm23550.dtsi"
+
+/ {
+	model = "BCM23550 Sparrow board";
+	compatible = "brcm,bcm23550-sparrow", "brcm,bcm23550";
+
+	memory {
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+};
+
+&uartb {
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
+
+&sdio1 {
+	max-frequency = <48000000>;
+	status = "okay";
+};
+
+&sdio2 {
+	non-removable;
+	max-frequency = <48000000>;
+	status = "okay";
+};
+
+&sdio4 {
+	max-frequency = <48000000>;
+	cd-gpios = <&gpio 91 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/bcm23550.dtsi
new file mode 100644
index 000000000000..2287c56bd8a9
--- /dev/null
+++ b/arch/arm/boot/dts/bcm23550.dtsi
@@ -0,0 +1,419 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2016 Broadcom.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/* BCM23550 and BCM21664 have almost identical clocks */
+#include "dt-bindings/clock/bcm21664.h"
+
+#include "skeleton.dtsi"
+
+/ {
+	model = "BCM23550 SoC";
+	compatible = "brcm,bcm23550";
+	interrupt-parent = <&gic>;
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			enable-method = "brcm,bcm23550-cpu-method";
+			secondary-boot-reg = <0x35004178>;
+			reg = <1>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			enable-method = "brcm,bcm23550-cpu-method";
+			secondary-boot-reg = <0x35004178>;
+			reg = <2>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			enable-method = "brcm,bcm23550-cpu-method";
+			secondary-boot-reg = <0x35004178>;
+			reg = <3>;
+			clock-frequency = <1000000000>;
+		};
+	};
+
+	/* Hub bus */
+	hub@34000000 {
+		compatible = "simple-bus";
+		ranges = <0 0x34000000 0x102f83ac>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		smc@4e000 {
+			compatible = "brcm,bcm23550-smc", "brcm,kona-smc";
+			reg = <0x0004e000 0x400>; /* 1 KiB in SRAM */
+		};
+
+		resetmgr: reset-controller@1001f00 {
+			compatible = "brcm,bcm21664-resetmgr";
+			reg = <0x01001f00 0x24>;
+		};
+
+		gpio: gpio@1003000 {
+			compatible = "brcm,bcm23550-gpio", "brcm,kona-gpio";
+			reg = <0x01003000 0x524>;
+			interrupts =
+			       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
+				GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
+				GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
+				GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+		};
+
+		timer@1006000 {
+			compatible = "brcm,kona-timer";
+			reg = <0x01006000 0x1c>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&aon_ccu BCM21664_AON_CCU_HUB_TIMER>;
+		};
+	};
+
+	/* Slaves bus */
+	slaves@3e000000 {
+		compatible = "simple-bus";
+		ranges = <0 0x3e000000 0x0001c070>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uartb: serial@0 {
+			compatible = "snps,dw-apb-uart";
+			status = "disabled";
+			reg = <0x00000000 0x118>;
+			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uartb2: serial@1000 {
+			compatible = "snps,dw-apb-uart";
+			status = "disabled";
+			reg = <0x00001000 0x118>;
+			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB2>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uartb3: serial@2000 {
+			compatible = "snps,dw-apb-uart";
+			status = "disabled";
+			reg = <0x00002000 0x118>;
+			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB3>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		bsc1: i2c@16000 {
+			compatible = "brcm,kona-i2c";
+			reg = <0x00016000 0x70>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC1>;
+			status = "disabled";
+		};
+
+		bsc2: i2c@17000 {
+			compatible = "brcm,kona-i2c";
+			reg = <0x00017000 0x70>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC2>;
+			status = "disabled";
+		};
+
+		bsc3: i2c@18000 {
+			compatible = "brcm,kona-i2c";
+			reg = <0x00018000 0x70>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC3>;
+			status = "disabled";
+		};
+
+		bsc4: i2c@1c000 {
+			compatible = "brcm,kona-i2c";
+			reg = <0x0001c000 0x70>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC4>;
+			status = "disabled";
+		};
+	};
+
+	/* Apps bus */
+	apps@3e300000 {
+		compatible = "simple-bus";
+		ranges = <0 0x3e300000 0x01b77000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		usbotg: usb@e20000 {
+			compatible = "snps,dwc2";
+			reg = <0x00e20000 0x10000>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_otg_ahb_clk>;
+			clock-names = "otg";
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
+			status = "disabled";
+		};
+
+		usbphy: usb-phy@e30000 {
+			compatible = "brcm,kona-usb2-phy";
+			reg = <0x00e30000 0x28>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		sdio1: sdio@e80000 {
+			compatible = "brcm,kona-sdhci";
+			reg = <0x00e80000 0x801c>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO1>;
+			status = "disabled";
+		};
+
+		sdio2: sdio@e90000 {
+			compatible = "brcm,kona-sdhci";
+			reg = <0x00e90000 0x801c>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO2>;
+			status = "disabled";
+		};
+
+		sdio3: sdio@ea0000 {
+			compatible = "brcm,kona-sdhci";
+			reg = <0x00ea0000 0x801c>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO3>;
+			status = "disabled";
+		};
+
+		sdio4: sdio@eb0000 {
+			compatible = "brcm,kona-sdhci";
+			reg = <0x00eb0000 0x801c>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO4>;
+			status = "disabled";
+		};
+
+		cdc: cdc@1b0e000 {
+			compatible = "brcm,bcm23550-cdc";
+			reg = <0x01b0e000 0x78>;
+		};
+
+		gic: interrupt-controller@1b21000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x01b21000 0x1000>,
+			      <0x01b22000 0x1000>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * Fixed clocks are defined before CCUs whose
+		 * clocks may depend on them.
+		 */
+
+		ref_32k_clk: ref_32k {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		bbl_32k_clk: bbl_32k {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		ref_13m_clk: ref_13m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <13000000>;
+		};
+
+		var_13m_clk: var_13m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <13000000>;
+		};
+
+		dft_19_5m_clk: dft_19_5m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <19500000>;
+		};
+
+		ref_crystal_clk: ref_crystal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <26000000>;
+		};
+
+		ref_52m_clk: ref_52m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <52000000>;
+		};
+
+		var_52m_clk: var_52m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <52000000>;
+		};
+
+		usb_otg_ahb_clk: usb_otg_ahb {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <52000000>;
+		};
+
+		ref_96m_clk: ref_96m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <96000000>;
+		};
+
+		var_96m_clk: var_96m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <96000000>;
+		};
+
+		ref_104m_clk: ref_104m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <104000000>;
+		};
+
+		var_104m_clk: var_104m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <104000000>;
+		};
+
+		ref_156m_clk: ref_156m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <156000000>;
+		};
+
+		var_156m_clk: var_156m {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <156000000>;
+		};
+
+		root_ccu: root_ccu {
+			compatible = BCM21664_DT_ROOT_CCU_COMPAT;
+			reg = <0x35001000 0x0f00>;
+			#clock-cells = <1>;
+			clock-output-names = "frac_1m";
+		};
+
+		aon_ccu: aon_ccu {
+			compatible = BCM21664_DT_AON_CCU_COMPAT;
+			reg = <0x35002000 0x0f00>;
+			#clock-cells = <1>;
+			clock-output-names = "hub_timer";
+		};
+
+		slave_ccu: slave_ccu {
+			compatible = BCM21664_DT_SLAVE_CCU_COMPAT;
+			reg = <0x3e011000 0x0f00>;
+			#clock-cells = <1>;
+			clock-output-names = "uartb",
+					     "uartb2",
+					     "uartb3",
+					     "bsc1",
+					     "bsc2",
+					     "bsc3",
+					     "bsc4";
+		};
+
+		master_ccu: master_ccu {
+			compatible = BCM21664_DT_MASTER_CCU_COMPAT;
+			reg = <0x3f001000 0x0f00>;
+			#clock-cells = <1>;
+			clock-output-names = "sdio1",
+					     "sdio2",
+					     "sdio3",
+					     "sdio4",
+					     "sdio1_sleep",
+					     "sdio2_sleep",
+					     "sdio3_sleep",
+					     "sdio4_sleep";
+		};
+	};
+};
-- 
1.9.1
