From: <sean.wang@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: soc: add SCPSYS binding for MT7623 and MT7623A SoC
Date: Thu, 1 Feb 2018 18:12:47 +0800
Message-ID: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:55073 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751748AbeBAKNA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Feb 2018 05:13:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>

From: Sean Wang <sean.wang@mediatek.com>

document the binding for enabling SCPSYS on MediaTek MT7623 and MT7623A
SoC. Where MT7623 SoC has the same definition about power domains with
MT2701, so it's fine to using MT2701 ones as MT7623's fallback.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 76bf45b..d6fe16f 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -21,6 +21,8 @@ Required properties:
 	- "mediatek,mt2712-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
+	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
+	- "mediatek,mt7623a-scpsys": For MT7623A SoC
 	- "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
@@ -28,10 +30,11 @@ Required properties:
 - clock, clock-names: clocks according to the common clock binding.
                       These are clocks which hardware needs to be
                       enabled before enabling certain power domains.
-	Required clocks for MT2701: "mm", "mfg", "ethif"
+	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
 	Required clocks for MT7622: "hif_sel"
+	Required clocks for MT7622A: "ethif"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
 Optional properties:
-- 
2.7.4
