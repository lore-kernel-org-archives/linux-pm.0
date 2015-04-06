From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 3/4] ARM: shmobile: dtsi: Add cpuidle parameters into each cpu for r8a7791
Date: Mon, 6 Apr 2015 12:50:43 +0900
Message-ID: <1428292244-2160-4-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:19258 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752687AbbDFDvl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2015 23:51:41 -0400
In-Reply-To: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

This patch add enable-method node and idle-states node for r8a7791.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 4696062..fd17866 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -46,11 +46,13 @@
 		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
+			enable-method = "renesas,rcar-idle";
 			reg = <0>;
 			clock-frequency = <1500000000>;
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7791_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			cpu-idle-states = <&CORE_STANDBY>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -64,8 +66,19 @@
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
+			enable-method = "renesas,rcar-idle";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			cpu-idle-states = <&CORE_STANDBY>;
+		};
+
+		idle-states {
+			CORE_STANDBY: CoreStandby {
+				compatible = "arm,idle-state";
+				entry-latency-us = <500>;
+				exit-latency-us = <2300>;
+				min-residency-us = <2800>;
+			};
 		};
 	};
 
-- 
1.9.1

