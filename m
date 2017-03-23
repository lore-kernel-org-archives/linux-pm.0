From: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [RFC 2/3] ARM: dts: NSP: Add Thermal Support
Date: Thu, 23 Mar 2017 15:18:47 -0400
Message-ID: <1490296728-14733-3-git-send-email-jon.mason@broadcom.com>
References: <1490296728-14733-1-git-send-email-jon.mason@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490296728-14733-1-git-send-email-jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Add thermal support via the ns-thermal driver and create a single
thermal zone for the entire SoC.

Signed-off-by: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 37076a2..89eb470 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -398,6 +398,12 @@
 			      <0x3f408 0x04>;
 		};
 
+		pvtmon: thermal@3f2c0 {
+			compatible = "brcm,ns-thermal";
+			reg = <0x3f2c0 0x10>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		sata_phy: sata_phy@40100 {
 			compatible = "brcm,iproc-nsp-sata-phy";
 			reg = <0x40100 0x340>;
@@ -548,4 +554,13 @@
 			brcm,pcie-msi-inten;
 		};
 	};
+
+	thermal-zones {
+		soc {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&pvtmon>;
+		};
+	};
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
