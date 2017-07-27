From: <louis.yu@mediatek.com>
Subject: [PATCH v1 1/4] dt-bindings: thermal: Add binding document for Mediatek thermal controller
Date: Thu, 27 Jul 2017 13:46:54 +0800
Message-ID: <1501134417-3505-2-git-send-email-louis.yu@mediatek.com>
References: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:6983 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750965AbdG0Fr7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 01:47:59 -0400
In-Reply-To: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, dawei.chien@mediatek.com, fan.chen@mediatek.com, eddie.huang@mediatek.com, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Louis Yu <louis.yu@mediatek.com>

From: Louis Yu <louis.yu@mediatek.com>

This adds the device tree binding documentation for the mediatek thermal
controller found on Mediatek MT2712.

Signed-off-by: Louis Yu <louis.yu@mediatek.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index e2f494d..0d73ea5 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -11,6 +11,7 @@ Required properties:
 - compatible:
   - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
+  - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
1.9.1
