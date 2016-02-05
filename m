From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH] arm64: dts: mt8173: add node for thermal calibration
Date: Fri, 5 Feb 2016 13:47:38 +0800
Message-ID: <1454651258-41990-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Kurtz <djkurtz@chromium.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

Add this for supporting thermal calibration by e-fuse data.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
Because MTK thermal/efuse patches hadn't landed on mainline, this patch
must base on following patchset:
https://lkml.org/lkml/2015/11/17/251
https://lkml.org/lkml/2015/11/19/169
https://lkml.org/lkml/2015/11/30/239
https://lkml.org/lkml/2015/12/16/195
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index ffcca66..0c9d17e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -391,6 +391,11 @@
 		efuse: efuse@10206000 {
 			compatible = "mediatek,mt8173-efuse";
 			reg = <0 0x10206000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			thermal_calibration: calib@528 {
+				reg = <0x528 0xc>;
+			};
 		};
 
 		apmixedsys: clock-controller@10209000 {
@@ -744,6 +749,8 @@
 			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
 			mediatek,auxadc = <&auxadc>;
 			mediatek,apmixedsys = <&apmixedsys>;
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
 		};
 	};
 };
-- 
1.7.9.5
