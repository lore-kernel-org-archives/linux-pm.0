From: Jon Mason <jon.mason@broadcom.com>
Subject: [PATCH v3 3/3] ARM: dts: NSP: Add Thermal Support
Date: Fri, 28 Apr 2017 16:11:31 -0400
Message-ID: <1493410291-16679-4-git-send-email-jon.mason@broadcom.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36879 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033183AbdD1ULn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 16:11:43 -0400
Received: by mail-it0-f44.google.com with SMTP id x188so49254138itb.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Apr 2017 13:11:43 -0700 (PDT)
In-Reply-To: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Add thermal support via the ns-thermal driver and create a single
thermal zone for the entire SoC.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 832795b..be6fcfb 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -383,6 +383,12 @@
 			      <0x3f408 0x04>;
 		};
 
+		thermal: thermal@3f2c0 {
+			compatible = "brcm,ns-thermal";
+			reg = <0x3f2c0 0x10>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		sata_phy: sata_phy@40100 {
 			compatible = "brcm,iproc-nsp-sata-phy";
 			reg = <0x40100 0x340>;
@@ -533,4 +539,24 @@
 			brcm,pcie-msi-inten;
 		};
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			coefficients = <(-556) 418000>;
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature     = <125000>;
+					hysteresis      = <0>;
+					type            = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
 };
-- 
2.7.4
