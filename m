From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH 5/5] ARM: vexpress/TC2: register vexpress-spc cpufreq device
Date: Wed, 16 Oct 2013 14:52:43 +0100
Message-ID: <1381931563-16785-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54920 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934379Ab3JPNxH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 09:53:07 -0400
In-Reply-To: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Pawel Moll <pawel.moll@arm.com>, Nicolas Pitre <nico@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Pawel Moll <Pawel.Moll@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch adds vexpress-spc platform device to enables the vexpress
SPC cpufreq interface driver.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Cc: Pawel Moll <Pawel.Moll@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-vexpress/spc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index a8b8310..4ddfbfe 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/opp.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/semaphore.h>
 
@@ -532,6 +533,7 @@ static int __init ve_spc_clk_init(void)
 			pr_warn("failed to initialise cpu%d opp table\n", cpu);
 	}
 
+	platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
 	return 0;
 }
 module_init(ve_spc_clk_init);
-- 
1.8.1.2

