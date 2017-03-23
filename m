From: Jon Mason <jon.mason@broadcom.com>
Subject: [RFC 3/3] ARM: dts: BCM5301X: Add Thermal Support
Date: Thu, 23 Mar 2017 15:18:48 -0400
Message-ID: <1490296728-14733-4-git-send-email-jon.mason@broadcom.com>
References: <1490296728-14733-1-git-send-email-jon.mason@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35692 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753764AbdCWTTL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 15:19:11 -0400
Received: by mail-wm0-f48.google.com with SMTP id u132so69835088wmg.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 12:19:10 -0700 (PDT)
In-Reply-To: <1490296728-14733-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: zajec5@gmail.com
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

Add thermal support via the ns-thermal driver and create a single
thermal zone for the entire SoC.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index ceca664..ba4bcef 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -351,6 +351,12 @@
 				     "sata2";
 	};
 
+	pvtmon: thermal@1800c2c0 {
+		compatible = "brcm,ns-thermal";
+		reg = <0x1800c2c0 0x10>;
+		#thermal-sensor-cells = <0>;
+	};
+
 	srab: srab@18007000 {
 		compatible = "brcm,bcm5301x-srab";
 		reg = <0x18007000 0x1000>;
@@ -414,4 +420,13 @@
 			status = "disabled";
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
