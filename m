From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v9 11/17] ARM: tegra: Enable the DFLL on the Jetson TK1
Date: Wed, 13 May 2015 17:58:45 +0300
Message-ID: <1431529131-16710-12-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:59377 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965480AbbEMPBO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 May 2015 11:01:14 -0400
In-Reply-To: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

Add the board-specific properties of the DFLL for the Jetson TK1 board.
On this board, the DFLL will take control of the sd0 regulator on the
on-board AS3722 PMIC.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index bd43ed6..192111a 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1462,7 +1462,7 @@
 				vin-ldo9-10-supply = <&vdd_5v0_sys>;
 				vin-ldo11-supply = <&vdd_3v3_run>;
 
-				sd0 {
+				vdd_cpu: sd0 {
 					regulator-name = "+VDD_CPU_AP";
 					regulator-min-microvolt = <700000>;
 					regulator-max-microvolt = <1400000>;
@@ -1694,6 +1694,13 @@
 		non-removable;
 	};
 
+	/* CPU DFLL clock */
+	clock@0,70110000 {
+		status = "okay";
+		vdd-cpu-supply = <&vdd_cpu>;
+		nvidia,i2c-fs-rate = <400000>;
+	};
+
 	ahub@0,70300000 {
 		i2s@0,70301100 {
 			status = "okay";
-- 
2.3.0

