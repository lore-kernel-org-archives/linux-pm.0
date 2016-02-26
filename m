From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 5/5] arm64: dts: register Hi6220's thermal zone for power allocator
Date: Fri, 26 Feb 2016 11:43:47 +0800
Message-ID: <1456458227-12950-6-git-send-email-leo.yan@linaro.org>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36772 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbcBZDqU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 22:46:20 -0500
Received: by mail-pa0-f47.google.com with SMTP id yy13so43478928pab.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Feb 2016 19:46:20 -0800 (PST)
In-Reply-To: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Leo Yan <leo.yan@linaro.org>

With profiling Hi6220's power modeling so get dynamic coefficient and
sustainable power. So pass these parameters from DT.

Now enable power allocator with only one actor for CPU part, so directly
use cluster0's thermal sensor for monitoring temperature.

Reviewed-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 50ba1b0..d8b963c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi6220-clock.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -87,6 +88,7 @@
 			cooling-max-level = <0>;
 			#cooling-cells = <2>; /* min followed by max */
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu1: cpu@1 {
@@ -322,5 +324,36 @@
 			clock-names = "thermal_clk";
 			#thermal-sensor-cells = <1>;
 		};
+
+		thermal-zones {
+
+			cls0: cls0 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <3326>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 2>;
+
+				trips {
+					threshold: trip-point@0 {
+						temperature = <65000>;
+						type = "passive";
+					};
+
+					target: trip-point@1 {
+						temperature = <75000>;
+						type = "passive";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&target>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
1.9.1

