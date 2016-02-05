From: Mason <slash.tmp@free.fr>
Subject: [PATCH RFC] Add cpufreq support
Date: Fri, 5 Feb 2016 17:58:38 +0100
Message-ID: <56B4D4BE.2040008@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:59140 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbcBEQ6q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Feb 2016 11:58:46 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>

I'm throwing this out there to ask:
Is this the right way to enable cpufreq on my platform?
---
 arch/arm/boot/dts/tango4-common.dtsi  | 4 ++++
 arch/arm/boot/dts/tango4-smp8758.dtsi | 2 ++
 arch/arm/mach-tango/setup.c           | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
index 41dff0a93419..557cb67d183f 100644
--- a/arch/arm/boot/dts/tango4-common.dtsi
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -193,3 +193,7 @@
 		};
 	};
 };
+
+&cpu0 {
+	clocks = <&clkgen CPU_CLK>;
+};
diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
index 7ed88ee629fb..0db290a8334d 100644
--- a/arch/arm/boot/dts/tango4-smp8758.dtsi
+++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
@@ -11,6 +11,8 @@
 			next-level-cache = <&l2cc>;
 			device_type = "cpu";
 			reg = <0>;
+			clock-latency = <300000>;
+			operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
 		};
 
 		cpu1: cpu@1 {
diff --git a/arch/arm/mach-tango/setup.c b/arch/arm/mach-tango/setup.c
index a796841c039b..0e8f90f70e85 100644
--- a/arch/arm/mach-tango/setup.c
+++ b/arch/arm/mach-tango/setup.c
@@ -1,6 +1,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <linux/platform_device.h>
 #include "smc.h"
 
 static struct map_desc tango_map_desc[] __initdata = {
@@ -23,6 +24,11 @@ static void tango_l2c_write(unsigned long val, unsigned int reg)
 		tango_set_l2_control(val);
 }
 
+static void __init tango_init_late(void)
+{
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+}
+
 static const char *const tango_dt_compat[] = { "sigma,tango4", NULL };
 
 DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
@@ -30,4 +36,5 @@ DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
 	.l2c_aux_mask	= ~0,
 	.l2c_write_sec	= tango_l2c_write,
 	.map_io		= tango_map_io,
+	.init_late	= tango_init_late,
 MACHINE_END
