From: Tai Nguyen <ttnguyen-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 1/2] power: reset: Add syscon reboot device node for APM X-Gene platform
Date: Fri,  1 May 2015 13:11:13 -0700
Message-ID: <1430511074-32229-2-git-send-email-ttnguyen@apm.com>
References: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430511074-32229-1-git-send-email-ttnguyen-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org
Cc: ttnguyen-qTEPVZfXA3Y@public.gmane.org, Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds syscon reboot device node to support reboot feature on APM X-Gene platform

Signed-off-by: Feng Kan  <fkan-qTEPVZfXA3Y@public.gmane.org>
Signed-off-by: Tai Nguyen <ttnguyen-qTEPVZfXA3Y@public.gmane.org>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index c8d3e0e..16efcf7 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -710,5 +710,17 @@
 			dma-coherent;
 			clocks = <&dmaclk 0>;
 		};
+
+		scu: system-clk-controller@17000000 {
+			compatible = "apm,xgene-scu","syscon";
+			reg = <0x0 0x17000000 0x0 0x400>;
+		};
+
+		reboot: reboot@17000014 {
+			compatible = "syscon-reboot";
+			regmap = <&scu>;
+			offset = <0x14>;
+			mask = <0x1>;
+		};
 	};
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
