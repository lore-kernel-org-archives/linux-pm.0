From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v9 3/4] ARM: dts: rockchip: add syscon-reboot-mode DT node
Date: Mon, 20 Jun 2016 14:39:29 +0800
Message-ID: <1466404769-3534-1-git-send-email-andy.yan@rock-chips.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:48932 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbcFTGkp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 02:40:45 -0400
In-Reply-To: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc: k.kozlowski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at, Andy Yan <andy.yan@rock-chips.com>

Rockchip platform use a SYSCON mapped register store
the reboot mode magic value for bootloader to use when
system reboot. So add syscon-reboot-mode driver DT node
for rk3xxx/rk3036/rk3288 based platform

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
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
- add rk3036 support

Changes in v2:
- make this node as a subnode of PMU

Changes in v1:
- correct the maskrom magic number
- use macro defined in rockchip_boot-mode.h for reboot-mode DT node

 arch/arm/boot/dts/rk3036.dtsi                | 11 ++++++++++-
 arch/arm/boot/dts/rk3288.dtsi                | 10 ++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi                | 12 +++++++++++-
 include/dt-bindings/soc/rockchip_boot-mode.h | 15 +++++++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 843d2be..f22b7df 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3036-cru.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -313,8 +314,16 @@
 	};
 
 	grf: syscon@20008000 {
-		compatible = "rockchip,rk3036-grf", "syscon";
+		compatible = "rockchip,rk3036-grf", "syscon", "simple-mfd";
 		reg = <0x20008000 0x1000>;
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x1d8>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-bootloader = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_BL_DOWNLOAD>;
+		};
 	};
 
 	acodec: acodec-ana@20030000 {
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 3b44ef3..8c3defd 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/power/rk3288-power.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -790,6 +791,15 @@
 				clocks = <&cru ACLK_GPU>;
 			};
 		};
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x94>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-bootloader = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_BL_DOWNLOAD>;
+		};
 	};
 
 	sgrf: syscon@ff740000 {
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 99bbcc2..cc4bc7f 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -43,6 +43,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -246,8 +247,17 @@
 	};
 
 	pmu: pmu@20004000 {
-		compatible = "rockchip,rk3066-pmu", "syscon";
+		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
 		reg = <0x20004000 0x100>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x40>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-bootloader = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_BL_DOWNLOAD>;
+		};
 	};
 
 	grf: grf@20008000 {
diff --git a/include/dt-bindings/soc/rockchip_boot-mode.h b/include/dt-bindings/soc/rockchip_boot-mode.h
new file mode 100644
index 0000000..ae7c867
--- /dev/null
+++ b/include/dt-bindings/soc/rockchip_boot-mode.h
@@ -0,0 +1,15 @@
+#ifndef __ROCKCHIP_BOOT_MODE_H
+#define __ROCKCHIP_BOOT_MODE_H
+
+/*high 24 bits is tag, low 8 bits is type*/
+#define REBOOT_FLAG		0x5242C300
+/* normal boot */
+#define BOOT_NORMAL		(REBOOT_FLAG + 0)
+/* enter bootloader rockusb mode */
+#define BOOT_BL_DOWNLOAD	(REBOOT_FLAG + 1)
+/* enter recovery */
+#define BOOT_RECOVERY		(REBOOT_FLAG + 3)
+ /* enter fastboot mode */
+#define BOOT_FASTBOOT		(REBOOT_FLAG + 9)
+
+#endif
-- 
2.7.4


