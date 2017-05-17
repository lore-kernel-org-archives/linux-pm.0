From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 4/4] arm: dts: rk322x: update tsadc's frequence setting
Date: Wed, 17 May 2017 12:45:23 +0800
Message-ID: <1494996323-4678-5-git-send-email-frank.wang@rock-chips.com>
References: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, charles.chen@rock-chips.com, cody.xie@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com, finley.xiao@rock-chips.com, zhangqing@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Rocky Hao <rocky.hao@rock-chips.com>

Update freq of tsadc's working clock as 32768 hz, if not set, tsadc
will work at a default frequence.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 7809e56..d2e9641 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -434,6 +434,8 @@
 		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
 		clock-names = "tsadc", "apb_pclk";
+		assigned-clocks = <&cru SCLK_TSADC>;
+		assigned-clock-rates = <32768>;
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
 		pinctrl-names = "init", "default", "sleep";
-- 
2.0.0
