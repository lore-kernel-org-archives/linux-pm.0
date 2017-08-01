From: <sean.wang@mediatek.com>
Subject: [PATCH v2 1/3] dt-bindings: soc: update the binding document for SCPSYS on MediaTek MT7622 SoC
Date: Tue, 1 Aug 2017 18:06:11 +0800
Message-ID: <978aad669c09316ee6d18f84e2b5ac8b161aa12c.1501581552.git.sean.wang@mediatek.com>
References: <cover.1501581552.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501581552.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update the binding document for enabling SCPSYS on MediaTek MT7622 SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index b1d165b..40056f7 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -12,11 +12,13 @@ power/power_domain.txt. It provides the power domains defined in
 - include/dt-bindings/power/mt8173-power.h
 - include/dt-bindings/power/mt6797-power.h
 - include/dt-bindings/power/mt2701-power.h
+- include/dt-bindings/power/mt7622-power.h
 
 Required properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-scpsys"
 	- "mediatek,mt6797-scpsys"
+	- "mediatek,mt7622-scpsys"
 	- "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
@@ -26,6 +28,7 @@ Required properties:
                       enabled before enabling certain power domains.
 	Required clocks for MT2701: "mm", "mfg", "ethif"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
+	Required clocks for MT7622: "hif_sel"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
 Optional properties:
-- 
2.7.4
