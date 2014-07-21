From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: [PATCH v2 15/16] ARM: tegra: Add entries for cpufreq on Tegra124
Date: Mon, 21 Jul 2014 18:39:01 +0300
Message-ID: <1405957142-19416-16-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Walmsley <pwalmsley@nvidia.com>, devicetree@vger.kernel.org, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The Tegra124 cpufreq driver relies on certain clocks being present
in the /cpus/cpu@0 node.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
v2 changes:
    - The clock-latency property was added, as cpufreq-cpu0 wants that

 arch/arm/boot/dts/tegra124.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 8ff4332..db51438 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -786,6 +786,15 @@
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
