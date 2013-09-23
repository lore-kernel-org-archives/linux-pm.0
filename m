From: "Wendy Ng" <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/3] ARM: bcm281xx: Add thermal driver to device tree.
Date: Mon, 23 Sep 2013 10:51:38 -0700
Message-ID: <1379958698-7554-4-git-send-email-wendy.ng@broadcom.com>
References: <1379958698-7554-1-git-send-email-wendy.ng@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379958698-7554-1-git-send-email-wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Wendy Ng <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds the device tree node for Broadcom bcm281xx SoCs thermal
driver.

Signed-off-by: Wendy Ng <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/bcm11351-brt.dts |    4 +++-
 arch/arm/boot/dts/bcm11351.dtsi    |    6 ++++++
 arch/arm/boot/dts/bcm28155-ap.dts  |    4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 9d36eb4..0771b6b 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -43,5 +43,7 @@
 		status = "okay";
 	};
 
-
+	thermal@34008000 {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 05a5aab..aa13353 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -96,4 +96,10 @@
 		status = "disabled";
 	};
 
+	thermal@34008000 {
+		compatible = "brcm,bcm11351-thermal", "brcm,kona-thermal";
+		reg = <0x34008000 0x0024>;
+		thermal-name = "bcm_kona_therm";
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 96ae67a..a39aa47 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -42,4 +42,8 @@
 		max-frequency = <48000000>;
 		status = "okay";
 	};
+
+	thermal@34008000 {
+		status = "okay";
+	};
 };
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
