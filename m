From: David Lechner <david@lechnology.com>
Subject: [PATCH 3/3] ARM: dts: da850: Add node for LEGO MINDSTORMS EV3 Battery
Date: Mon,  3 Apr 2017 15:23:49 -0500
Message-ID: <1491251029-23256-4-git-send-email-david@lechnology.com>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1491251029-23256-1-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

This adds a new node to the LEGO MINDSTORMS EV3 device tree for the battery.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index c20580a..99cd561 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -172,6 +172,18 @@
 		gpio = <&gpio 111 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	/*
+	 * The EV3 can use 6-AA batteries or a rechargable Li-ion battery pack.
+	 */
+	battery {
+		pinctrl-names = "default";
+		pintctrl-0 = <&battery_pins>;
+		compatible = "lego,ev3-battery";
+		io-channels = <&adc 4>, <&adc 3>;
+		io-channel-names = "voltage", "current";
+		rechargeable-gpios = <&gpio 136 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &pmx_core {
@@ -235,6 +247,15 @@
 			0x34 0x00000008 0x0000000f
 		>;
 	};
+
+	battery_pins: pinmux_battery_pins {
+		pinctrl-single,bits = <
+			/* GP0[6] */
+			0x04 0x00000080 0x000000f0
+			/* GP8[8] */
+			0x4c 0x00000080 0x000000f0
+		>;
+	};
 };
 
 &pinconf {
@@ -349,6 +370,13 @@
 
 &gpio {
 	status = "okay";
+
+	/* Don't pull down battery voltage adc io channel */
+	batt_volt_en {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		output-low;
+	};
 };
 
 &usb_phy {
-- 
2.7.4
