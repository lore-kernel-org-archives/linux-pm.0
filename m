From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 4/4] arm: dts: add omap4430 thermal data
Date: Tue, 9 Jul 2013 10:00:14 -0400
Message-ID: <1373378414-28086-5-git-send-email-eduardo.valentin@ti.com>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39902 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3GIOA7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2013 10:00:59 -0400
In-Reply-To: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, durgadoss.r@intel.com, amit.daniel@samsung.com
Cc: rui.zhang@intel.com, Eduardo Valentin <eduardo.valentin@ti.com>

This patch changes the dtsi entry on omap4430 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index cccf39a..baea44f 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -24,4 +24,35 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
+	bandgap {
+		reg = <0x4a002260 0x4 0x4a00232C 0x4>;
+		compatible = "ti,omap4430-bandgap";
+		thermal_zone {
+			type = "CPU";
+			mask = <0x03>; /* trips writability */
+			passive_delay = <250>; /* milliseconds */
+			polling_delay = <1000>; /* milliseconds */
+			governor = "step_wise";
+			trips {
+				alert@100000{
+					temperature = <100000>; /* milliCelsius */
+					hysteresis = <0>; /* milliCelsius */
+					type = <1>;
+				};
+				crit@125000{
+					temperature = <125000>; /* milliCelsius */
+					hysteresis = <0>; /* milliCelsius */
+					type = <3>;
+				};
+			};
+			bind_params {
+				action@0{
+					cooling_device = "thermal-cpufreq";
+					weight = <100>; /* percentage */
+					mask = <0x01>;
+				};
+			};
+		};
+	};
+
 };
-- 
1.8.2.1.342.gfa7285d

