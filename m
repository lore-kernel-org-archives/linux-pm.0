From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v9 4/4] ARM64: dts: rockchip: add syscon-reboot-mode DT node
Date: Mon, 20 Jun 2016 14:40:12 +0800
Message-ID: <1466404812-3590-1-git-send-email-andy.yan@rock-chips.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:55909 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbcFTGkp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 02:40:45 -0400
In-Reply-To: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc: k.kozlowski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at, Andy Yan <andy.yan@rock-chips.com>

Add syscon-reboot-mode driver DT node for rk3368 platform

Tested-by: Caesar Wang <caesar.upstream@gmail.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- descirbe all reboot mode as property instead of subnode

Changes in v2:
- make this node as a subnode of pmugrf

Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 8b4a7c9..8041067 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -632,8 +633,17 @@
 	};
 
 	pmugrf: syscon@ff738000 {
-		compatible = "rockchip,rk3368-pmugrf", "syscon";
+		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x200>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-bootloader = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_BL_DOWNLOAD>;
+		};
 	};
 
 	cru: clock-controller@ff760000 {
-- 
2.7.4


