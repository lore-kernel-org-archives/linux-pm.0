From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 2/6] ARM: shmobile: Change CPUIdle InterFace
Date: Wed, 4 Mar 2015 13:55:42 +0900
Message-ID: <1425444946-3084-3-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

This patch change the shmobile_cpuidle_init process
to use Renesas CPUIdle driver.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/common.h  |  4 +++-
 arch/arm/mach-shmobile/cpuidle.c | 31 ++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 8faf6e0..4adecd4 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -1,3 +1,5 @@
+#include <linux/platform_data/renesas-cpuidle.h>
+
 #ifndef __ARCH_MACH_COMMON_H
 #define __ARCH_MACH_COMMON_H
 
@@ -23,7 +25,6 @@ struct clk;
 extern int shmobile_clk_init(void);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 struct cpuidle_driver;
-extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
@@ -35,6 +36,7 @@ static inline void shmobile_smp_apmu_suspend_init(void) { }
 
 #ifdef CONFIG_CPU_IDLE
 int shmobile_cpuidle_init(void);
+extern void shmobile_cpuidle_set_driver(struct renesas_cpuidle *drv);
 #else
 static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 0afeb5c..cb81ad6 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -13,25 +13,34 @@
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/device.h>
+#include <linux/platform_data/renesas-cpuidle.h>
+#include <linux/platform_device.h>
 #include <asm/cpuidle.h>
 #include <asm/io.h>
+#include "common.h"
 
-static struct cpuidle_driver shmobile_cpuidle_default_driver = {
-	.name			= "shmobile_cpuidle",
-	.owner			= THIS_MODULE,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.safe_state_index	= 0, /* C1 */
-	.state_count		= 1,
+/* default */
+static struct renesas_cpuidle cpuidle_data = {
+	.num_drvs	= 0,
+	.rcd		= NULL,
 };
 
-static struct cpuidle_driver *cpuidle_drv = &shmobile_cpuidle_default_driver;
-
-void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
+void __init shmobile_cpuidle_set_driver(struct renesas_cpuidle *pd)
 {
-	cpuidle_drv = drv;
+	cpuidle_data = *pd;
 }
 
+static struct platform_device renesas_cpuidle = {
+	.name	= "cpuidle-renesas",
+	.id	= -1,
+	.dev	= {
+		   .platform_data = &cpuidle_data,
+	},
+};
+
 int __init shmobile_cpuidle_init(void)
 {
-	return cpuidle_register(cpuidle_drv, NULL);
+	platform_device_register(&renesas_cpuidle);
+	return 0;
 }
-- 
1.9.1

