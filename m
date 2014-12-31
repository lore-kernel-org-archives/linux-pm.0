From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCHv2 8/8] ARM: dts: Add memory bus node for Exynos4412-based
 TRATS2 board
Date: Wed, 31 Dec 2014 14:19:52 +0900
Message-ID: <1420003192-5576-9-git-send-email-cw00.choi@samsung.com>
References: <1420003192-5576-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38595 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaLaFUD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Dec 2014 00:20:03 -0500
In-reply-to: <1420003192-5576-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

This patch adds the Exynos4412 memory-bus node which includes the regulator
and devfreq-event phandle. The devfreq-event phandle is used for the
governor of devfreq device and provide the current usage state of
MIF (Memory Interface) / INT (Internal) memory bus group.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index bee0eed..21ba25e 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -917,6 +917,18 @@
 	};
 };
 
+&memory_bus_mif {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-mem-supply = <&buck1_reg>;
+	status = "okay";
+};
+
+&memory_bus_int {
+	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	vdd-mem-supply = <&buck3_reg>;
+	status = "okay";
+};
+
 &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
-- 
1.8.5.5

