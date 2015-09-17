From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v3 3/6] ARM: berlin: dts: add the cpufreq-dt bindings on the BG2Q
Date: Thu, 17 Sep 2015 12:15:02 +0200
Message-ID: <1442484905-15656-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57053 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751922AbbIQKPI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 06:15:08 -0400
In-Reply-To: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

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
2.5.2

