From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4] SH: cpuidle: check error code at init
Date: Wed, 17 Apr 2013 15:32:57 +0200
Message-ID: <1366205577-11632-4-git-send-email-daniel.lezcano@linaro.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: lethal@linux-sh.org, rjw@sisk.pl
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

Registering the driver, or the device, can fail, let's check the return code
and return the error code to the PM layer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/sh/include/asm/suspend.h         |    4 ++--
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   11 ++++++++---
 arch/sh/kernel/cpu/shmobile/pm.c      |    3 +--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/suspend.h b/arch/sh/include/asm/suspend.h
index e14567a..70ae0b2 100644
--- a/arch/sh/include/asm/suspend.h
+++ b/arch/sh/include/asm/suspend.h
@@ -14,9 +14,9 @@ struct swsusp_arch_regs {
 void sh_mobile_call_standby(unsigned long mode);
 
 #ifdef CONFIG_CPU_IDLE
-void sh_mobile_setup_cpuidle(void);
+int sh_mobile_setup_cpuidle(void);
 #else
-static inline void sh_mobile_setup_cpuidle(void) {}
+static inline int sh_mobile_setup_cpuidle(void) { return 0; }
 #endif
 
 /* notifier chains for pre/post sleep hooks */
diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index f024acf..fdfe57f4 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -90,14 +90,19 @@ static struct cpuidle_driver cpuidle_driver = {
 	.state_count = 3,
 };
 
-void sh_mobile_setup_cpuidle(void)
+int __init sh_mobile_setup_cpuidle(void)
 {
+	int ret;
+
 	if (sh_mobile_sleep_supported & SUSP_SH_SF)
 		cpuidle_driver.states[1].disabled = false;
 
 	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
 		cpuidle_driver.states[2].disabled = false;
 
-	if (!cpuidle_register_driver(&cpuidle_driver))
-		cpuidle_register_device(&cpuidle_dev);
+	ret = cpuidle_register_driver(&cpuidle_driver);
+	if (ret)
+		return ret;
+
+	return cpuidle_register_device(&cpuidle_dev);
 }
diff --git a/arch/sh/kernel/cpu/shmobile/pm.c b/arch/sh/kernel/cpu/shmobile/pm.c
index 08d27fa..ac37b72 100644
--- a/arch/sh/kernel/cpu/shmobile/pm.c
+++ b/arch/sh/kernel/cpu/shmobile/pm.c
@@ -150,8 +150,7 @@ static const struct platform_suspend_ops sh_pm_ops = {
 static int __init sh_pm_init(void)
 {
 	suspend_set_ops(&sh_pm_ops);
-	sh_mobile_setup_cpuidle();
-	return 0;
+	return sh_mobile_setup_cpuidle();
 }
 
 late_initcall(sh_pm_init);
-- 
1.7.9.5

