From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [PATCH 4/6] ARM: shmobile: Add initialization cpuidle
Date: Fri, 1 Aug 2014 18:48:44 +0900
Message-ID: <53DB627C.40104@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/cpuidle.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 0afeb5c..19c0c98 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -8,13 +8,17 @@
  * for more details.
  */

+#include <linux/cpu.h>
 #include <linux/pm.h>
 #include <linux/cpuidle.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <asm/cpuidle.h>
 #include <asm/io.h>
+#include "common.h"

 static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
@@ -31,7 +35,25 @@ void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
 	cpuidle_drv = drv;
 }

+static struct platform_device shmobile_cpuidle = {
+	.name              = "cpuidle-shmobile",
+	.dev.platform_data = shmobile_smp_apmu_enter_cpuidle,
+	.id                = -1,
+};
+
 int __init shmobile_cpuidle_init(void)
 {
+	int cpu;
+
+	/* Make sure boot CPU also gets CPUIdle initialized */
+	for_each_online_cpu(cpu) {
+		shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
+	}
+
+#ifdef CONFIG_ARCH_SHMOBILE_MULTI
+	platform_device_register(&shmobile_cpuidle);
+	return 0;
+#else
 	return cpuidle_register(cpuidle_drv, NULL);
+#endif
 }
-- 
1.7.9.5
