From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1] ARM: dts: tegra30: Add ACTMON node
Date: Fri, 12 Apr 2019 01:30:42 +0300
Message-ID: <20190411223042.25809-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add ACTMON node to the Tegra30's device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d2b553f76719..e074258d4518 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -370,6 +370,17 @@
 		reg = <0x6000c000 0x150>; /* AHB Arbitration + Gizmo Controller */
 	};
 
+	actmon@6000c800 {
+		compatible = "nvidia,tegra30-actmon";
+		reg = <0x6000c800 0x400>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_ACTMON>,
+			 <&tegra_car TEGRA30_CLK_EMC>;
+		clock-names = "actmon", "emc";
+		resets = <&tegra_car TEGRA30_CLK_ACTMON>;
+		reset-names = "actmon";
+	};
+
 	gpio: gpio@6000d000 {
 		compatible = "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
-- 
2.21.0
