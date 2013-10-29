From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v3 4/4] ARM: vexpress/TC2: register vexpress-spc cpufreq device
Date: Tue, 29 Oct 2013 12:18:40 +0000
Message-ID: <1383049120-8336-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1383049120-8336-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42529 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978Ab3J2MS1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2013 08:18:27 -0400
In-Reply-To: <1383049120-8336-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep.KarkadaNagesha@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch adds vexpress-spc platform device to enables the vexpress
SPC cpufreq interface driver.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Acked-by: Pawel Moll <Pawel.Moll@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-vexpress/spc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 3532e26..033d34d 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/semaphore.h>
@@ -537,6 +538,7 @@ static int __init ve_spc_clk_init(void)
 			pr_warn("failed to initialise cpu%d opp table\n", cpu);
 	}
 
+	platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
 	return 0;
 }
 module_init(ve_spc_clk_init);
-- 
1.8.1.2

