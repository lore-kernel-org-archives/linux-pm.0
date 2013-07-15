From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/3] ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
Date: Tue, 16 Jul 2013 01:25:26 +0200
Message-ID: <1373930726-15475-3-git-send-email-daniel.lezcano@linaro.org>
References: <1373930726-15475-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:62997 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab3GOXZd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 19:25:33 -0400
Received: by mail-wg0-f47.google.com with SMTP id l18so23563wgh.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 16:25:32 -0700 (PDT)
In-Reply-To: <1373930726-15475-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linus.walleij@linaro.org, patches@linaro.org

There is no more dependency with arch/arm headers, so we can safely move the
driver to the drivers/cpuidle directory.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile                       |    1 -
 drivers/cpuidle/Kconfig.arm                        |    8 ++++++++
 drivers/cpuidle/Makefile                           |    1 +
 .../cpuidle.c => drivers/cpuidle/cpuidle-ux500.c   |    0
 4 files changed, 9 insertions(+), 1 deletion(-)
 rename arch/arm/mach-ux500/cpuidle.c => drivers/cpuidle/cpuidle-ux500.c (100%)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index bf9b6be..fe1f3e2 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -4,7 +4,6 @@
 
 obj-y				:= cpu.o devices.o devices-common.o \
 				   id.o usb.o timer.o pm.o
-obj-$(CONFIG_CPU_IDLE)          += cpuidle.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 2c8f17d..b330219 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -19,3 +19,11 @@ config ARM_ZYNQ_CPUIDLE
 	bool "CPU Idle Driver for Xilinx Zynq processors"
 	depends on ARCH_ZYNQ
 	help
+	  Select this to enable cpuidle on Xilinx Zynq processors.
+
+config ARM_U8500_CPUIDLE
+	bool "Cpu Idle Driver for the ST-E u8500 processors"
+	depends on ARCH_U8500
+	help
+	  Select this to enable cpuidle for ST-E u8500 processors
+
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 77cf767..0b9d200 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
+obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
diff --git a/arch/arm/mach-ux500/cpuidle.c b/drivers/cpuidle/cpuidle-ux500.c
similarity index 100%
rename from arch/arm/mach-ux500/cpuidle.c
rename to drivers/cpuidle/cpuidle-ux500.c
-- 
1.7.9.5

