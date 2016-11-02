From: kernel@martin.sperl.org
Subject: [PATCH V8 3/6] ARM: bcm2835: dts: add thermal node to device-tree of
 bcm283x
Date: Wed,  2 Nov 2016 10:18:23 +0000
Message-ID: <1478081906-12009-4-git-send-email-kernel@martin.sperl.org>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: linux-pm@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the node for the thermal sensor of the bcm2835-soc
to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Changelog:
V1 -> V5: generic settings is shared in bcm283x.dtsi, but disabled
	  moved the compatible string to the SOC specific dtsi
            for arm and arm64
V5 -> V6: fix remove 0x prefix from thermal@0x7e212000

Note: there is no arm/boot/dts/bcm2837.dtsi as of now,
      so the 32-bit rpi3 dt is not modified.
---
 arch/arm/boot/dts/bcm2835.dtsi | 6 ++++++
 arch/arm/boot/dts/bcm2836.dtsi | 6 ++++++
 arch/arm/boot/dts/bcm283x.dtsi | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index a78759e..0890d97 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -23,3 +23,9 @@
 		};
 	};
 };
+
+/* enable thermal sensor with the correct compatible property set */
+&thermal {
+	compatible = "brcm,bcm2835-thermal";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index 9d0651d..519a44f 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -76,3 +76,9 @@
 	interrupt-parent = <&local_intc>;
 	interrupts = <8>;
 };
+
+/* enable thermal sensor with the correct compatible property set */
+&thermal {
+	compatible = "brcm,bcm2836-thermal";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 46d46d8..f794a18 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -187,6 +187,13 @@
 			interrupts = <2 14>; /* pwa1 */
 		};
 
+		thermal: thermal@7e212000 {
+			compatible = "brcm,bcm2835-thermal";
+			reg = <0x7e212000 0x8>;
+			clocks = <&clocks BCM2835_CLOCK_TSENS>;
+			status = "disabled";
+		};
+
 		aux: aux@0x7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
-- 
2.1.4
