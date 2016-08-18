From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v2 1/3] dt-bindings: thermal: Add binding document for Mediatek thermal controller
Date: Thu, 18 Aug 2016 11:50:51 +0800
Message-ID: <1471492253-7185-2-git-send-email-dawei.chien@mediatek.com>
References: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:26702 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753542AbcHRDvr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2016 23:51:47 -0400
In-Reply-To: <1471492253-7185-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Erin Lo <erin.lo@mediatek.com>, Dawei Chien <dawei.chien@mediatek.com>

This adds the device tree binding documentation for the mediatek thermal
controller found on Mediatek MT2701.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 .../bindings/thermal/mediatek-thermal.txt          |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 81f9a51..e2f494d 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -8,7 +8,9 @@ apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
 is also needed.
 
 Required properties:
-- compatible: "mediatek,mt8173-thermal"
+- compatible:
+  - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
+  - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
1.7.9.5

