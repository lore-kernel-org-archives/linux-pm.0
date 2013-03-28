From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 07/12] ARM: ux500: Create u8500-clk device
Date: Thu, 28 Mar 2013 17:11:33 +0100
Message-ID: <1364487098-10319-8-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:48826 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756892Ab3C1QMT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Mar 2013 12:12:19 -0400
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: daniel.lezcano@linaro.org, hongbo.zhang@linaro.org, khilman@linaro.org, ulf.hansson@linaro.org, linus.walleij@stericsson.com, rickard.andersson@stericsson.com

Add platform device for u8500-clk. Also add
the device to the generic power domain APE.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/boot/dts/dbx5x0.dtsi        |  9 ++++++++
 arch/arm/mach-ux500/board-mop500.c   |  8 +++++++
 arch/arm/mach-ux500/cpu-db8500.c     |  1 +
 arch/arm/mach-ux500/devices-db8500.c | 41 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/devices-db8500.h |  1 +
 drivers/clk/ux500/u8500_clk.c        |  6 ++++++
 6 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 63f2fbc..b1438d2 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -657,6 +657,15 @@
 			status = "disabled";
 		};
 
+		clk {
+		    compatible = "stericsson,u8500-clk";
+		    reg = <0x8012f000 0x1000>,
+			  <0x8011f000 0x1000>,
+			  <0x8000f000 0x1000>,
+			  <0xa03ff000 0x1000>,
+			  <0xa03cf000 0x1000>;
+		};
+
 		external-bus@50000000 {
 			compatible = "simple-bus";
 			reg = <0x50000000 0x4000000>;
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 77d3d1a..b351f25 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -649,9 +649,17 @@ struct generic_pm_domain ape_domain = {
 	.name = "APE",
 };
 
+static __init void add_platform_device_to_genpd(struct platform_device *pdev,
+						struct generic_pm_domain *genpd)
+{
+	pm_genpd_add_device(genpd, &pdev->dev);
+}
+
 static void __init init_pm_domains(void)
 {
 	pm_genpd_init(&ape_domain, NULL, false);
+
+	add_platform_device_to_genpd(&db8500_clk_device, &ape_domain);
 }
 
 static void __init mop500_init_machine(void)
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 5b286e0..6ead606 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -142,6 +142,7 @@ static struct platform_device db8500_prcmu_device = {
 };
 
 static struct platform_device *platform_devs[] __initdata = {
+	&db8500_clk_device,
 	&u8500_dma40_device,
 	&db8500_pmu_device,
 	&db8500_prcmu_device,
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 318d490..ad6036b 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -194,3 +194,44 @@ struct platform_device u8500_ske_keypad_device = {
 	.num_resources = ARRAY_SIZE(keypad_resources),
 	.resource = keypad_resources,
 };
+
+static struct resource clk_resources[] = {
+	[0] = {
+		.start = U8500_CLKRST1_BASE,
+		.end   = U8500_CLKRST1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "clkrst1_base",
+	},
+	[1] = {
+		.start = U8500_CLKRST2_BASE,
+		.end   = U8500_CLKRST2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "clkrst2_base",
+	},
+	[2] = {
+		.start = U8500_CLKRST3_BASE,
+		.end   = U8500_CLKRST3_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "clkrst3_base",
+	},
+	[3] = {
+		.start = U8500_CLKRST5_BASE,
+		.end   = U8500_CLKRST5_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "clkrst5_base",
+	},
+	[4] = {
+		.start = U8500_CLKRST6_BASE,
+		.end   = U8500_CLKRST6_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "clkrst6_base",
+	},
+};
+
+struct platform_device db8500_clk_device = {
+	.name = "u8500-clk",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(clk_resources),
+	.resource = clk_resources
+
+};
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index a5e05f6..0094f3a 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -14,6 +14,7 @@
 
 struct ske_keypad_platform_data;
 struct pl022_ssp_controller;
+extern struct platform_device db8500_clk_device;
 
 static inline struct platform_device *
 db8500_add_ske_keypad(struct device *parent,
diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 63ed580..8a3ac27 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -566,9 +566,15 @@ static struct notifier_block prcc_context_notifier = {
 	.notifier_call = prcc_context_call,
 };
 
+static const struct of_device_id u8500_clk_match[] = {
+	{ .compatible = "stericsson,u8500-clk", },
+	{},
+};
+
 static struct platform_driver u8500_clk_plat_driver = {
 	.driver = {
 		.name = "u8500-clk",
+		.of_match_table = u8500_clk_match,
 	},
 };
 
-- 
1.8.2

