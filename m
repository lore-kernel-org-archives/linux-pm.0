From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 3/7] arm: dts: dra7: add bandgap entry
Date: Mon, 6 Jan 2014 08:36:47 -0400
Message-ID: <1389011811-13004-4-git-send-email-eduardo.valentin@ti.com>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds bandgap IP entry on DRA7 dtsi device tree file.

Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..8f21157 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -119,6 +119,18 @@
 			pinctrl-single,function-mask =3D <0x3fffffff>;
 		};
=20
+		bandgap: bandgap {
+			reg =3D <0x4a0021e0 0xc
+				0x4a00232c 0xc
+				0x4a002380 0x2c
+				0x4a0023C0 0x3c
+				0x4a002564 0x8
+				0x4a002574 0x50>;
+			compatible =3D "ti,dra752-bandgap";
+			interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells =3D <1>;
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible =3D "ti,omap4430-sdma";
 			reg =3D <0x4a056000 0x1000>;
--=20
1.8.2.1.342.gfa7285d
