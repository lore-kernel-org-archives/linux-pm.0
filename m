From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCH 04/15] ARM: dts: Add DMC bus freqeuncy for
 exynos3250-rinato/monk
Date: Thu, 26 Nov 2015 22:47:28 +0900
Message-ID: <1448545659-32287-5-git-send-email-cw00.choi@samsung.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42645 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbKZNrn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 08:47:43 -0500
In-reply-to: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, k.kozlowski@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

This patch adds the DMC (DRAM Memory Controller) bus frequency node
which includes the devfreq-events and regulator properties. The bus
frequency support the DVFS (Dynamic Voltage Frequency Scaling) feature
with ondemand governor.

The devfreq-events (ppmu_dmc0*) can monitor the utilization of DMC bus
on runtime and the buck1_reg (VDD_MIF power line) supplies the power to
the DMC block.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts   | 6 ++++++
 arch/arm/boot/dts/exynos3250-rinato.dts | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 443a35085846..d982586a6533 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -498,6 +498,12 @@
 	};
 };
 
+&bus_dmc {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
 &xusbxti {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 3e64d5dcdd60..61477943015b 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -675,6 +675,12 @@
 	};
 };
 
+&bus_dmc {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
 &xusbxti {
 	clock-frequency = <24000000>;
 };
-- 
1.9.1

