From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 5/6] ARM: berlin: dts: add the cpufreq-dt bindings on the BG2CD
Date: Tue, 18 Aug 2015 13:46:07 +0200
Message-ID: <1439898368-11543-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The BG2CD uses cpugreq-dt. Add the corresponding bindings.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 900213d78a32..3c7a7404f10c 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -56,6 +56,14 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <0>;
+
+			clocks = <&chip_clk CLKID_CPU>;
+			clock-latency = <100000>;
+			operating-points = <
+				/* kHz    uV */
+				800000  1200000
+				600000  1200000
+			>;
 		};
 	};
 
-- 
2.5.0
