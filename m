From: Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC RESEND PATCH 2/7] dt-bindings: soc: Add opp table on scpsys bindings
Date: Wed, 2 Jan 2019 22:09:53 +0800
Message-ID: <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Henry Chen <henryc.chen@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Add opp table on scpsys dt-bindings for Mediatek SoC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 Documentation/devicetree/bindings/opp/mtk-opp.txt  | 24 +++++++++++++
 .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/mtk-opp.txt b/Documentation/devicetree/bindings/opp/mtk-opp.txt
new file mode 100644
index 0000000..036be1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/mtk-opp.txt
@@ -0,0 +1,24 @@
+Mediatek OPP bindings to descibe OPP nodes with level values
+
+OPP tables for devices on Mediatek platforms require an additional
+platform specific level value to be specified.
+This value is passed on to the mediatek Power Management Unit by the
+CPU, which then takes the necessary actions to set a voltage rail
+to an appropriate voltage based on the value passed.
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-mtk-level"
+
+* OPP Node
+
+Required properties:
+- mtk,level: On Mediatek platforms an OPP node can describe a positive value
+representing a level that's communicated with a our power management hardware
+which then translates it into a certain voltage on a voltage rail.
diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index b4728ce..299b526 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -63,6 +63,10 @@ Optional properties:
 - mfg_2d-supply: Power supply for the mfg_2d power domain
 - mfg-supply: Power supply for the mfg power domain
 
+- operating-points-v2: Phandle to the OPP table for the Power domain.
+	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	and Documentation/devicetree/bindings/opp/mtk-opp.txt for more details
+
 Example:
 
 	scpsys: scpsys@10006000 {
@@ -75,6 +79,27 @@ Example:
 			 <&topckgen CLK_TOP_VENC_SEL>,
 			 <&topckgen CLK_TOP_VENC_LT_SEL>;
 		clock-names = "mfg", "mm", "venc", "venc_lt";
+		operating-points-v2 = <&dvfsrc_opp_table>;
+
+		dvfsrc_opp_table: opp-table {
+			compatible = "operating-points-v2-mtk-level";
+
+			dvfsrc_vol_min: opp1 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
+			};
+
+			dvfsrc_freq_medium: opp2 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
+			};
+
+			dvfsrc_freq_max: opp3 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
+			};
+
+			dvfsrc_vol_max: opp4 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
+			};
+		};
 	};
 
 Example consumer:
@@ -82,4 +107,21 @@ Example consumer:
 	afe: mt8173-afe-pcm@11220000 {
 		compatible = "mediatek,mt8173-afe-pcm";
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
+		operating-points-v2 = <&aud_opp_table>;
+	};
+
+	aud_opp_table: aud-opp-table {
+		compatible = "operating-points-v2";
+		opp1 {
+			opp-hz = /bits/ 64 <793000000>;
+			required-opps = <&dvfsrc_vol_min>;
+		};
+		opp2 {
+			opp-hz = /bits/ 64 <910000000>;
+			required-opps = <&dvfsrc_vol_max>;
+		};
+		opp3 {
+			opp-hz = /bits/ 64 <1014000000>;
+			required-opps = <&dvfsrc_vol_max>;
+		};
 	};
-- 
1.9.1
