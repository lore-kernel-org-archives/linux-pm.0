From: Rocky Hao <rocky.hao@rock-chips.com>
Subject: [PATCH 1/5] dt-bindings: rockchip-thermal: Support the RK3328 SoC compatible
Date: Tue, 25 Jul 2017 17:09:44 +0800
Message-ID: <1500973788-14627-2-git-send-email-rocky.hao@rock-chips.com>
References: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:33376 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdGYJFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 05:05:48 -0400
In-Reply-To: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com

attempt to new compatible for thermal founding on RK3328 SoC.

Change-Id: Ie6f6d7b4e545891a0035851a923c0412f584140c
Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index 43003aec94bd..e3a6234fb1ac 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible : should be "rockchip,<name>-tsadc"
    "rockchip,rk3228-tsadc": found on RK3228 SoCs
    "rockchip,rk3288-tsadc": found on RK3288 SoCs
+   "rockchip,rk3328-tsadc": found on RK3328 SoCs
    "rockchip,rk3368-tsadc": found on RK3368 SoCs
    "rockchip,rk3399-tsadc": found on RK3399 SoCs
 - reg : physical base address of the controller and length of memory mapped
-- 
1.9.1
