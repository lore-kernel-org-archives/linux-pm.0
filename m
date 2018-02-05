From: <sean.wang@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: thermal: add binding for MT7622 SoC
Date: Mon, 5 Feb 2018 16:11:51 +0800
Message-ID: <0b7dabc3b2c7ed93b88ec0923c2cce2f84fba5b1.1517817887.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:46655 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeBEIMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Feb 2018 03:12:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, Shunli Wang <shunli.wang@mediatek.com>

From: Sean Wang <sean.wang@mediatek.com>

Add devicetree bindings for MediaTek MT7622 thermal controller

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 0d73ea5..41d6a44 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -12,6 +12,7 @@ Required properties:
   - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
+  - "mediatek,mt7622-thermal" : For MT7622 SoC
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
2.7.4
