From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] dt-bindings: rockchip-thermal: fix the misleading description
Date: Tue, 11 Oct 2016 10:07:35 +0800
Message-ID: <1476151655-18415-2-git-send-email-shawn.lin@rock-chips.com>
References: <1476151655-18415-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:58965 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbcJKCCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 22:02:14 -0400
In-Reply-To: <1476151655-18415-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Caesar Wang <wxt@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

"rockchip,hw-tshut-temp", "rockchip,hw-tshut-mode" and
"rockchip,hw-tshut-polarity" are not a required properties
actually as the code could also work by loading the default
settings there. So it is apprently misleading, although we
prefer to get these from DT. And it seems we miss the 'rockchip,grf'
here which should also be an optional property.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index 08efe6b..43003ae 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -22,10 +22,13 @@ Required properties:
 	      TSADC controller.
 - pinctrl-2 : The "sleep" pinctrl state, it will be in for suspend.
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+
+Optional properties:
 - rockchip,hw-tshut-temp : The hardware-controlled shutdown temperature value.
 - rockchip,hw-tshut-mode : The hardware-controlled shutdown mode 0:CRU 1:GPIO.
 - rockchip,hw-tshut-polarity : The hardware-controlled active polarity 0:LOW
 			       1:HIGH.
+- rockchip,grf : The phandle of the syscon node for the general register file.
 
 Exiample:
 tsadc: tsadc@ff280000 {
-- 
2.3.7


