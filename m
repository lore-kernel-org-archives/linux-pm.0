From: kernel@martin.sperl.org
Subject: [PATCH V7 3/6] ARM: bcm2835: dts: add thermal node to device-tree of bcm283x
Date: Wed, 21 Sep 2016 08:23:44 +0000
Message-ID: <1474446227-1147-4-git-send-email-kernel@martin.sperl.org>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:60898
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbcIUIYC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 04:24:02 -0400
In-Reply-To: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

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
index b982522..d9acf21 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -186,6 +186,13 @@
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

