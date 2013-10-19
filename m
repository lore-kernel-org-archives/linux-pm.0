From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/4] mvebu: Dove: Instantiate cpufreq driver.
Date: Sat, 19 Oct 2013 14:37:39 +0200
Message-ID: <1382186261-14482-3-git-send-email-andrew@lunn.ch>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42490 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816Ab3JSMn1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 19 Oct 2013 08:43:27 -0400
In-Reply-To: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>

Add a platform driver definition to instantiate the dove cpufreq
driver. Also indicate the ARCH has cpufreq support, so allowing the
cpufreq framework to be enabled.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                       |  1 +
 arch/arm/mach-dove/board-dt.c          |  2 ++
 arch/arm/mach-dove/common.c            | 36 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/common.h            |  1 +
 arch/arm/mach-dove/include/mach/dove.h |  1 +
 5 files changed, 41 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..7744415 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -495,6 +495,7 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
+	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 49f72a8..98202de 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -70,6 +70,8 @@ static void __init dove_dt_init(void)
 	/* Setup clocks for legacy devices */
 	dove_legacy_clk_init();
 
+	dove_cpufreq_init();
+
 	/* Internal devices not ported to DT yet */
 	dove_pcie_init(1, 1);
 
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index c122bcf..9e648a8 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -344,6 +344,42 @@ void __init dove_sdio1_init(void)
 	platform_device_register(&dove_sdio1);
 }
 
+/*****************************************************************************
+ * CPU Frequency
+ ****************************************************************************/
+static struct resource dove_cpufreq_resources[] = {
+	[0] = {
+		.start  = DOVE_PMU_PHYS_BASE,
+		.end    = DOVE_PMU_PHYS_BASE + 0x7,
+		.flags  = IORESOURCE_MEM,
+		.name   = "cpufreq: DFS"
+	},
+	[1] = {
+		.start  = DOVE_PMU_PHYS_BASE + 0x8000,
+		.end    = DOVE_PMU_PHYS_BASE + 0x8004,
+		.flags  = IORESOURCE_MEM,
+		.name   = "cpufreq PMU CR"
+	},
+	[2] = {
+		.start  = DOVE_PMU_PHYS_BASE + 0x0044,
+		.end    = DOVE_PMU_PHYS_BASE + 0x0048,
+		.flags  = IORESOURCE_MEM,
+		.name   = "cpufreq: PMU Clk Div"
+	},
+};
+
+static struct platform_device dove_cpufreq_device = {
+	.name		= "dove-cpufreq",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dove_cpufreq_resources),
+	.resource	= dove_cpufreq_resources,
+};
+
+void __init dove_cpufreq_init(void)
+{
+	platform_device_register(&dove_cpufreq_device);
+}
+
 void __init dove_setup_cpu_wins(void)
 {
 	/*
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 1d72522..5c9a77b 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -44,6 +44,7 @@ void dove_spi1_init(void);
 void dove_i2c_init(void);
 void dove_sdio0_init(void);
 void dove_sdio1_init(void);
+void dove_cpufreq_init(void);
 void dove_restart(enum reboot_mode, const char *);
 
 #endif
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index 0c4b35f..48db186 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -144,6 +144,7 @@
 #define  DOVE_SD0_GPIO_SEL		(1 << 0)
 
 /* Power Management */
+#define DOVE_PMU_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE + 0xd0000)
 #define DOVE_PMU_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE + 0xd0000)
 #define DOVE_PMU_SIG_CTRL	(DOVE_PMU_VIRT_BASE + 0x802c)
 
-- 
1.8.4.rc3

