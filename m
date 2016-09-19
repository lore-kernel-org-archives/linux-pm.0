From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V6 3/6] ARM: bcm2835: dts: add thermal node to device-tree of bcm283x
Date: Mon, 19 Sep 2016 08:59:57 +0000
Message-ID: <1474275600-19378-4-git-send-email-kernel@martin.sperl.org>
References: <1474275600-19378-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474275600-19378-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add the node for the thermal sensor of the bcm2835-soc
to the device tree.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Acked-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>

Changelog:
V1 -> V5: generic settings is shared in bcm283x.dtsi, but disabled
	  moved the compatible string to the SOC specific dtsi
            for arm and arm64
V5 -> V6: removed 0x in node name

---
 arch/arm/boot/dts/bcm2835.dtsi | 6 ++++++
 arch/arm/boot/dts/bcm2836.dtsi | 6 ++++++
 arch/arm/boot/dts/bcm283x.dtsi | 7 +++++++
 3 files changed, 19 insertions(+)

Note: there is no arm/boot/dts/bcm2837.dtsi as of now,
      so the 32-bit rpi3 dt is not modified.

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
