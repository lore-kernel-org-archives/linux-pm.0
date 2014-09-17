From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v5 3/4] ARM: dts: add main Thermal info to rk3288
Date: Wed, 17 Sep 2014 11:59:12 +0800
Message-ID: <1410926353-15674-4-git-send-email-caesar.wang@rock-chips.com>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, dmitry.torokhov@gmail.com, addy.ke@rock-chips.com, zyf@rock-chips.com, cjf@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 36be7bb..ba7ad94 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -215,6 +215,17 @@
 		status = "disabled";
 	};
 
+	tsadc: tsadc@ff280000 {
+		compatible = "rockchip,rk3288-tsadc";
+		reg = <0xff280000 0x100>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-1 = <&otp_out>;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
 		reg = <0xff500000 0x100>;
@@ -611,5 +622,12 @@
 				rockchip,pins = <5 15 3 &pcfg_pull_none>;
 			};
 		};
+
+		tsadc {
+			otp_out: otp-out {
+				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
 	};
 };
-- 
1.9.1


