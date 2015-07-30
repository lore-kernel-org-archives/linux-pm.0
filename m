From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 3/3] ARM: berlin: dts: add the cpufreq-dt bindings on the BG2Q
Date: Thu, 30 Jul 2015 14:35:52 +0200
Message-ID: <1438259752-16320-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The BG2Q uses cpugreq-dt. Add the corresponding bindings. The operating
points can be updated by the bootloader.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 63a48490e2f9..58f6792c0d77 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -53,6 +53,17 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <0>;
+
+			clocks = <&chip_clk CLKID_CPU>;
+			clock-latency = <100000>;
+			/* Can be modified by the bootloader */
+			operating-points = <
+				/* kHz    uV */
+				1200000 1200000
+				1000000 1200000
+				800000  1200000
+				600000  1200000
+			>;
 		};
 
 		cpu@1 {
-- 
2.5.0
