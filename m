From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v7 15/16] ARM: tegra: Add CPU regulator to the Jetson TK1 device tree
Date: Thu,  8 Jan 2015 15:22:18 +0200
Message-ID: <1420723339-30735-16-git-send-email-mikko.perttunen@kapsi.fi>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:56940 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756595AbbAHN2G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Jan 2015 08:28:06 -0500
In-Reply-To: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

Specify the CPU voltage regulator for the cpufreq driver.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index f539990..1a3a88c 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1774,6 +1774,12 @@
 		};
 	};
 
+	cpus {
+		cpu@0 {
+			vdd-cpu-supply = <&vdd_cpu>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
2.2.1

