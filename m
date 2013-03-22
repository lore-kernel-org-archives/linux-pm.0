From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [RFC PATCH 7/8] ARM: ux500: Create u8500-clk device
Date: Fri, 22 Mar 2013 17:20:11 +0100
Message-ID: <1363969212-14864-8-git-send-email-rickard.andersson@stericsson.com>
References: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog122.obsmtp.com ([207.126.144.153]:36354 "EHLO
	eu1sys200aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161057Ab3CVQla (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 12:41:30 -0400
In-Reply-To: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org
Cc: daniel.lezcano@linaro.org, hongbo.zhang@linaro.org, khilman@linaro.org, ulf.hansson@linaro.org, linus.walleij@stericsson.com, rickard.andersson@stericsson.com

Add platform device for u8500-clk. Also add
the device to the generic power domain APE.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c   | 8 ++++++++
 arch/arm/mach-ux500/cpu-db8500.c     | 1 +
 arch/arm/mach-ux500/devices-db8500.c | 5 +++++
 arch/arm/mach-ux500/devices-db8500.h | 1 +
 4 files changed, 15 insertions(+)

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
index 318d490..f57c694 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -194,3 +194,8 @@ struct platform_device u8500_ske_keypad_device = {
 	.num_resources = ARRAY_SIZE(keypad_resources),
 	.resource = keypad_resources,
 };
+
+struct platform_device db8500_clk_device = {
+	.name = "u8500-clk",
+	.id = -1,
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
-- 
1.8.2

