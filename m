From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 1/5] dt-bindings: thermal: Support the RK3368 SoCs compatible
Date: Mon, 21 Sep 2015 12:16:07 +0800
Message-ID: <1442808971-2619-2-git-send-email-wxt@rock-chips.com>
References: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35874 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbIUEQj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 00:16:39 -0400
In-Reply-To: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, will.deacon@arm.com, robh+dt@kernel.org, inux-kernel@vger.kernel.org, galak@codeaurora.org, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, mark.rutland@arm.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ijc+devicetree@hellion.org.uk, Caesar Wang <wxt@rock-chips.com>

This patchset attempts to new compatible for thermal founding
on RK3368 SoCs.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index ef802de..52682db 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -1,7 +1,9 @@
 * Temperature Sensor ADC (TSADC) on rockchip SoCs
 
 Required properties:
-- compatible : "rockchip,rk3288-tsadc"
+- compatible : should be "rockchip,<name>-tsadc"
+   "rockchip,rk3288-tsadc": found on RK3288 SoCs
+   "rockchip,rk3368-tsadc": found on RK3368 SoCs
 - reg : physical base address of the controller and length of memory mapped
 	region.
 - interrupts : The interrupt number to the cpu. The interrupt specifier format
-- 
1.9.1

