From: Chris Brand <chris.brand@broadcom.com>
Subject: [PATCH v2 4/6] arm: Add support for Broadcom BCM23550 SoC
Date: Wed, 11 May 2016 14:36:20 -0700
Message-ID: <1463002582-6875-5-git-send-email-chris.brand@broadcom.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

BCM23550 is a quad-A7 SoC used on the Broadcom "Sparrow" board.
It shares many IP blocks with other Broadcom Kona chips.

Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig          | 12 ++++++++++--
 arch/arm/mach-bcm/Makefile         |  5 ++++-
 arch/arm/mach-bcm/board_bcm23550.c | 25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-bcm/board_bcm23550.c

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef121472cdd..cb1281f115a9 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -111,9 +111,17 @@ config ARCH_BCM_21664
 	  Enable support for the BCM21664 family, which includes
 	  BCM21663 and BCM21664 variants.
 
+config ARCH_BCM_23550
+	bool "Broadcom BCM23550 SoC"
+	depends on ARCH_MULTI_V7
+	select ARCH_BCM_MOBILE
+	select HAVE_SMP
+	help
+	  Enable support for the BCM23550.
+
 config ARCH_BCM_MOBILE_L2_CACHE
 	bool "Broadcom mobile SoC level 2 cache support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_281XX || ARCH_BCM_21664
 	default y
 	select CACHE_L2X0
 	select ARCH_BCM_MOBILE_SMC
@@ -128,7 +136,7 @@ config ARCH_BCM_MOBILE_SMP
 	select HAVE_ARM_SCU
 	select ARM_ERRATA_764369
 	help
-	  SMP support for the BCM281XX and BCM21664 SoC families.
+	  SMP support for the BCM281XX, BCM21664 and BCM23550 SoC families.
 	  Provided as an option so SMP support for SoCs of this type
 	  can be disabled for an SMP-enabled kernel.
 
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 7d665151c772..980f5850097c 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -26,7 +26,10 @@ obj-$(CONFIG_ARCH_BCM_281XX)	+= board_bcm281xx.o
 # BCM21664
 obj-$(CONFIG_ARCH_BCM_21664)	+= board_bcm21664.o
 
-# BCM281XX and BCM21664 SMP support
+# BCM23550
+obj-$(CONFIG_ARCH_BCM_23550)	+= board_bcm23550.o
+
+# BCM281XX, BCM21664 and BCM23550 SMP support
 obj-$(CONFIG_ARCH_BCM_MOBILE_SMP) += platsmp.o
 
 # BCM281XX and BCM21664 L2 cache control
diff --git a/arch/arm/mach-bcm/board_bcm23550.c b/arch/arm/mach-bcm/board_bcm23550.c
new file mode 100644
index 000000000000..0ac01debd077
--- /dev/null
+++ b/arch/arm/mach-bcm/board_bcm23550.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+
+static const char * const bcm23550_dt_compat[] = {
+	"brcm,bcm23550",
+	NULL,
+};
+
+DT_MACHINE_START(BCM23550_DT, "BCM23550 Broadcom Application Processor")
+	.dt_compat = bcm23550_dt_compat,
+MACHINE_END
-- 
1.9.1
