From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v2 5/5] ARM: vexpress/TC2: register vexpress-spc cpufreq device
Date: Mon, 21 Oct 2013 10:58:54 +0100
Message-ID: <1382349534-31502-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Pawel Moll <pawel.moll@arm.com>, Nicolas Pitre <nico@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Pawel Moll <Pawel.Moll@arm.com>
List-Id: linux-pm@vger.kernel.org

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
index bd7c2ea..492e8b2 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/opp.h>
+#include <linux/platform_device.h>
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

