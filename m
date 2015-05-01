From: Tai Nguyen <ttnguyen-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 2/2] power: reset: Add syscon poweroff device node for APM X-Gene platform
Date: Fri,  1 May 2015 13:11:14 -0700
Message-ID: <1430511074-32229-3-git-send-email-ttnguyen@apm.com>
References: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430511074-32229-1-git-send-email-ttnguyen-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org
Cc: ttnguyen-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds syscon poweroff device node to support poweroff feature
on APM X-Gene Mustang platform

Signed-off-by: Tai Nguyen <ttnguyen-qTEPVZfXA3Y@public.gmane.org>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index 83578e7..910d561 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -23,6 +23,18 @@
 		device_type = "memory";
 		reg = < 0x1 0x00000000 0x0 0x80000000 >; /* Updated by bootloader */
 	};
+
+	poweroff_mbox: poweroff_mbox@10548000 {
+		compatible = "syscon";
+		reg = <0x0 0x10548000 0x0 0x30>;
+	};
+
+	poweroff: poweroff@10548010 {
+		compatible = "syscon-poweroff";
+		regmap = <&poweroff_mbox>;
+		offset = <0x10>;
+		mask = <0x1>;
+	};
 };
 
 &pcie0clk {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
