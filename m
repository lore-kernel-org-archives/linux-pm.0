From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 4/4] ARM64: dts: rockchip: add syscon-reboot-mode DT node
Date: Tue, 12 Jan 2016 19:33:47 +0800
Message-ID: <1452598427-8418-1-git-send-email-andy.yan@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:38964 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbcALLeR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 06:34:17 -0500
In-Reply-To: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, arnd@arndb.de, john.stultz@linaro.org
Cc: linux@roeck-us.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, catalin.marinas@arm.com, geert+renesas@glider.be, sre@kernel.org, olof@lixom.net, dbaryshkov@gmail.com, alexandre.belloni@free-electrons.com, jun.nie@linaro.org, pawel.moll@arm.com, f.fainelli@gmail.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, cernekee@gmail.com, linux-kernel@vger.kernel.org, dwmw2@infradead.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, Andy Yan <andy.yan@rock-chips.com>

Add syscon-reboot-mode driver DT node for rk3368 platform

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- make this node as a subnode of pmugrf

Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 33 +++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index cc093a4..20997a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 
 / {
 	compatible = "rockchip,rk3368";
@@ -485,8 +486,38 @@
 	};
 
 	pmugrf: syscon@ff738000 {
-		compatible = "rockchip,rk3368-pmugrf", "syscon";
+		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x200>;
+
+			normal {
+				linux,mode = "normal";
+				loader,magic = <BOOT_NORMAL>;
+			};
+
+			loader {
+				linux,mode = "loader";
+				loader,magic = <BOOT_LOADER>;
+			};
+
+			maskrom {
+				linux,mode = "maskrom";
+				loader,magic = <BOOT_MASKROM>;
+			};
+
+			recovery {
+				linux,mode = "recovery";
+				loader,magic = <BOOT_RECOVERY>;
+			};
+
+			fastboot {
+				linux,mode = "fastboot";
+				loader,magic = <BOOT_FASTBOOT>;
+			};
+		};
 	};
 
 	cru: clock-controller@ff760000 {
-- 
1.9.1


