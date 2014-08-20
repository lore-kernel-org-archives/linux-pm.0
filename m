From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: [PATCH v4 14/16] ARM: tegra: Add entries for cpufreq on Tegra124
Date: Thu, 21 Aug 2014 00:04:42 +0300
Message-ID: <1408568684-11016-15-git-send-email-ttynkkynen@nvidia.com>
References: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3601 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaHTVF4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Aug 2014 17:05:56 -0400
In-Reply-To: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Walmsley <pwalmsley@nvidia.com>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The Tegra124 cpufreq driver relies on certain clocks being present
in the /cpus/cpu@0 node.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 608fa29..62f8778 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -829,10 +829,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			clocks = <&tegra_car TEGRA124_CLK_CCLK_G>,
+				 <&tegra_car TEGRA124_CLK_CCLK_LP>,
+				 <&tegra_car TEGRA124_CLK_PLL_X>,
+				 <&tegra_car TEGRA124_CLK_PLL_P>,
+				 <&dfll>;
+			clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
+			/* FIXME: what's the actual transition time? */
+			clock-latency = <300000>;
 		};
 
 		cpu@1 {
-- 
1.8.1.5

