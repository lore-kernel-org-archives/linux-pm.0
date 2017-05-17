From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 1/4] arm: dts: rk322x: add some assigned-clocks
Date: Wed, 17 May 2017 12:45:20 +0800
Message-ID: <1494996323-4678-2-git-send-email-frank.wang@rock-chips.com>
References: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, charles.chen@rock-chips.com, cody.xie@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com, finley.xiao@rock-chips.com, zhangqing@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add CPLL, GPLL and some other assigned-clocks for rk322x SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 221251a..40044e8 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -346,8 +346,18 @@
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-		assigned-clocks = <&cru PLL_GPLL>;
-		assigned-clock-rates = <594000000>;
+		assigned-clocks =
+			<&cru PLL_GPLL>, <&cru ARMCLK>,
+			<&cru PLL_CPLL>, <&cru ACLK_PERI>,
+			<&cru HCLK_PERI>, <&cru PCLK_PERI>,
+			<&cru ACLK_CPU>, <&cru HCLK_CPU>,
+			<&cru PCLK_CPU>;
+		assigned-clock-rates =
+			<594000000>, <816000000>,
+			<500000000>, <150000000>,
+			<150000000>, <75000000>,
+			<150000000>, <150000000>,
+			<75000000>;
 	};
 
 	thermal-zones {
-- 
2.0.0
