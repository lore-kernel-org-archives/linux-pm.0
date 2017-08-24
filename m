From: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 3/5] arm: dts: rockchip: add tsadc node for RV1108 SoC
Date: Thu, 24 Aug 2017 18:27:53 +0800
Message-ID: <1503570475-7850-4-git-send-email-rocky.hao@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1503570475-7850-1-git-send-email-rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, william.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xxx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Add tsadc needed main information for RV1108 SoC.
750000Hz is the max clock rate supported by tsadc module.

Signed-off-by: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 arch/arm/boot/dts/rv1108.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 25fab0b80f53..dbdd8c2180e7 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -275,6 +275,25 @@
 		status = "disabled";
 	};
 
+	tsadc: tsadc@10370000 {
+		compatible = "rockchip,rv1108-tsadc";
+		reg = <0x10370000 0x100>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru SCLK_TSADC>;
+		assigned-clock-rates = <750000>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_gpio>;
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		rockchip,hw-tshut-temp = <120000>;
+		#thermal-sensor-cells = <1>;
+		status = "disabled";
+	};
+
 	adc: adc@1038c000 {
 		compatible = "rockchip,rv1108-saradc", "rockchip,rk3399-saradc";
 		reg = <0x1038c000 0x100>;
@@ -642,6 +661,16 @@
 			};
 		};
 
+		tsadc {
+			otp_out: otp-out {
+				rockchip,pins = <0 RK_PB7 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			otp_gpio: otp-gpio {
+				rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <3 RK_PA6 RK_FUNC_1 &pcfg_pull_up>,
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
