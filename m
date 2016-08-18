From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v2 3/3] arm: dts: thermal: add thermal/auxadc node.
Date: Thu, 18 Aug 2016 11:50:53 +0800
Message-ID: <1471492253-7185-4-git-send-email-dawei.chien@mediatek.com>
References: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>, Dawei Chien <dawei.chien@mediatek.com>
List-Id: linux-pm@vger.kernel.org

This adds the thermal controller and auxadc nodes
to the Mediatek MT2701 dtsi file.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
This patch depned on:
https://patchwork.kernel.org/patch/9249589/
---
 arch/arm/boot/dts/mt2701.dtsi |   44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index e9150a4..cee4724 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -87,6 +87,36 @@
 		clock-output-names = "rtc32k";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&thermal 0>;
+			sustainable-power = <1000>;
+
+			trips {
+				threshold: trip-point@0 {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: trip-point@1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu_crit@0 {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&gic>;
@@ -222,4 +252,18 @@
 		clock-names = "baud", "bus";
 		status = "disabled";
 	};
+
+	thermal: thermal@1100b000 {
+		#thermal-sensor-cells = <0>;
+		compatible = "mediatek,mt2701-thermal";
+		reg = <0 0x1100b000 0 0x1000>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "therm", "auxadc";
+		resets = <&pericfg 0x10>;
+		reset-names = "therm";
+		mediatek,auxadc = <&auxadc>;
+		mediatek,apmixedsys = <&apmixedsys>;
+	};
+
 };
-- 
1.7.9.5
