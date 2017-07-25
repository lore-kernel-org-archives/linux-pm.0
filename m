From: Rocky Hao <rocky.hao@rock-chips.com>
Subject: [PATCH 3/5] arm64: dts: rockchip: add tsadc node for rk3328 SoC
Date: Tue, 25 Jul 2017 17:09:46 +0800
Message-ID: <1500973788-14627-4-git-send-email-rocky.hao@rock-chips.com>
References: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

add tsadc needed main information for rk3328 SoC.
50000Hz is the max clock rate supported by tsadc module.

Change-Id: I2429c24edccd4c797e2f4577151be76372adfbe5
Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index db4b2708084d..186fb93fdffd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -308,6 +308,26 @@
 		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	tsadc: tsadc@ff250000 {
+		compatible = "rockchip,rk3328-tsadc";
+		reg = <0x0 0xff250000 0x0 0x100>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
+		rockchip,grf = <&grf>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		assigned-clocks = <&cru SCLK_TSADC>;
+		assigned-clock-rates = <50000>;
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_gpio>;
+		#thermal-sensor-cells = <1>;
+		rockchip,hw-tshut-temp = <100000>;
+		status = "disabled";
+	};
+
 	saradc: adc@ff280000 {
 		compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
 		reg = <0x0 0xff280000 0x0 0x100>;
-- 
1.9.1
