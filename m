From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 3/4] ARM: dts: rockchip: add syscon-reboot-mode node
Date: Tue, 12 Jan 2016 19:32:58 +0800
Message-ID: <1452598378-8371-1-git-send-email-andy.yan@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:50468 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933632AbcALLdb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 06:33:31 -0500
In-Reply-To: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, arnd@arndb.de, john.stultz@linaro.org
Cc: linux@roeck-us.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, catalin.marinas@arm.com, geert+renesas@glider.be, sre@kernel.org, olof@lixom.net, dbaryshkov@gmail.com, alexandre.belloni@free-electrons.com, jun.nie@linaro.org, pawel.moll@arm.com, f.fainelli@gmail.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, cernekee@gmail.com, linux-kernel@vger.kernel.org, dwmw2@infradead.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, Andy Yan <andy.yan@rock-chips.com>

Rockchip platform use a SYSCON mapped register store
the reboot mode magic value for bootloader to use when
system reboot. So add syscon-reboot-mode driver DT node
for rk3xxx,rk3288 platform

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- make this node as a subnode of PMU

Changes in v1:
- correct the maskrom magic number
- use macro defined in rockchip_boot-mode.h for reboot-mode DT node

 arch/arm/boot/dts/rk3288.dtsi                | 31 ++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi                | 33 +++++++++++++++++++++++++++-
 include/dt-bindings/soc/rockchip_boot-mode.h | 30 +++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 04ea209..4e49fb7 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/power/rk3288-power.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -712,6 +713,36 @@
 				clocks = <&cru ACLK_GPU>;
 			};
 		};
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x94>;
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
 
 	sgrf: syscon@ff740000 {
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 4497d28..58af546 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -43,6 +43,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include "skeleton.dtsi"
 
 / {
@@ -242,8 +243,38 @@
 	};
 
 	pmu: pmu@20004000 {
-		compatible = "rockchip,rk3066-pmu", "syscon";
+		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
 		reg = <0x20004000 0x100>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x40>;
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
 
 	grf: grf@20008000 {
diff --git a/include/dt-bindings/soc/rockchip_boot-mode.h b/include/dt-bindings/soc/rockchip_boot-mode.h
new file mode 100644
index 0000000..eedf113
--- /dev/null
+++ b/include/dt-bindings/soc/rockchip_boot-mode.h
@@ -0,0 +1,30 @@
+#ifndef __ROCKCHIP_BOOT_MODE_H
+#define __ROCKCHIP_BOOT_MODE_H
+
+/*high 24 bits is tag, low 8 bits is type*/
+#define	REBOOT_FLAG		0x5242C300
+/* normal boot */
+#define	BOOT_NORMAL		(REBOOT_FLAG + 0)
+/* enter loader rockusb mode */
+#define	BOOT_LOADER		(REBOOT_FLAG + 1)
+/* enter maskrom rockusb mode */
+#define	BOOT_MASKROM		(0xEF08A53C)
+/* enter recovery */
+#define	BOOT_RECOVERY		(REBOOT_FLAG + 3)
+/* do not enter recover */
+#define	BOOT_NORECOVER		(REBOOT_FLAG + 4)
+/* boot second OS*/
+#define	BOOT_SECONDOS		(REBOOT_FLAG + 5)
+/* enter recover and wipe data. */
+#define	BOOT_WIPEDATA		(REBOOT_FLAG + 6)
+/* enter recover and wipe all data. */
+#define	BOOT_WIPEALL		(REBOOT_FLAG + 7)
+/* check firmware img with backup part*/
+#define	BOOT_CHECKIMG		(REBOOT_FLAG + 8)
+ /* enter fast boot mode */
+#define	BOOT_FASTBOOT		(REBOOT_FLAG + 9)
+#define	BOOT_SECUREBOOT_DISABLE	(REBOOT_FLAG + 10)
+/* enter charge mode */
+#define	BOOT_CHARGING		(REBOOT_FLAG + 11)
+
+#endif
-- 
1.9.1



