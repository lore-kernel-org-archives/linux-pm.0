From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v4 3/4] ARM: dts: add main Thermal info to rk3288
Date: Wed,  3 Sep 2014 10:10:38 +0800
Message-ID: <1409710239-19941-4-git-send-email-caesar.wang@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:34450 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbaICCLJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 22:11:09 -0400
In-Reply-To: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, dmitry.torokhov@gmail.com, Caesar Wang <caesar.wang@rock-chips.com>

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 36be7bb..3d672e3 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -224,6 +224,17 @@
 		status = "disabled";
 	};
 
+	tsadc: tsadc@ff280000 {
+		compatible = "rockchip,rk3288-tsadc";
+		reg = <0xff280000 0x100>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-1 = <&tsadc_int>;
+		status = "disabled";
+	};
+
 	/* NOTE: ohci@ff520000 doesn't actually work on hardware */
 
 	usb_hsic: usb@ff5c0000 {
@@ -611,5 +622,12 @@
 				rockchip,pins = <5 15 3 &pcfg_pull_none>;
 			};
 		};
+
+		tsadc {
+			tsadc_int: tsadc-int {
+				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
 	};
 };
-- 
1.9.1


