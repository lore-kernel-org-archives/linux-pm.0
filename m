From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 1/4] arm: dts: rk322x: add some assigned-clocks
Date: Wed, 17 May 2017 18:16:14 +0800
Message-ID: <1495016177-2413-2-git-send-email-frank.wang@rock-chips.com>
References: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, charles.chen@rock-chips.com, linux-pm@vger.kernel.org, kevan.lan@rock-chips.com, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Frank Wang <frank.wang@rock-chips.com>, finley.xiao@rock-chips.com, cody.xie@rock-chips.com, wmc@rock-chips.com, rocky.hao@rock-chips.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add CPLL, GPLL and some other assigned-clocks for rk322x SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index f7498b3..64368b0 100644
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
