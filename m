From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH RFC 5/5] ARM: mvebu: Update Armada 38x DT for dynamic frequency scaling
Date: Fri,  3 Jul 2015 08:11:57 +0200
Message-ID: <1435903917-20486-6-git-send-email-gregory.clement@free-electrons.com>
References: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55216 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754128AbbGCGMR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 02:12:17 -0400
In-Reply-To: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

In order to support dynamic frequency scaling:

- the cpuclk Device Tree node must be added

- the clock property of the CPUs must be filled including the
  clock-latency property.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi | 3 +++
 arch/arm/boot/dts/armada-385.dtsi | 6 ++++++
 arch/arm/boot/dts/armada-38x.dtsi | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 5102d19cc8f4..f9dbc75bea73 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -61,6 +61,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
+			clock-names = "cpu0";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 8e67d2c083dd..62660dd377be 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -61,11 +61,17 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
+			clock-names = "cpu0";
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
+			clock-names = "cpu1";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 04ecfe6e2bc6..08409e92f3f3 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -369,6 +369,15 @@
 				#clock-cells = <1>;
 			};
 
+			cpuclk: clock-complex@18700 {
+				compatible = "marvell,armada-380-cpu-clock",
+				"marvell,armada-xp-cpu-clock";
+				reg = <0x18700 0xA0>, <0x1c054 0x40>,
+				<0xe4260 0x8>;
+				clocks = <&coreclk 1>;
+				#clock-cells = <1>;
+			};
+
 			mbusc: mbus-controller@20000 {
 				compatible = "marvell,mbus-controller";
 				reg = <0x20000 0x100>, <0x20180 0x20>;
-- 
2.1.0

