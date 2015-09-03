From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 5/7] ARM: cpuidle: Add runtime PM support for CPU idle
Date: Thu,  3 Sep 2015 13:58:32 -0600
Message-ID: <1441310314-8857-6-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36741 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbbICT6y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 15:58:54 -0400
Received: by pacwi10 with SMTP id wi10so210446pac.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2015 12:58:53 -0700 (PDT)
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its  PM domain.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..7c791f9 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,13 +11,16 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 
 #include <asm/cpuidle.h>
 
@@ -37,6 +40,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
+	struct device *cpu_dev = get_cpu_device(dev->cpu);
 
 	if (!idx) {
 		cpu_do_idle();
@@ -46,12 +50,19 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	ret = cpu_pm_enter();
 	if (!ret) {
 		/*
+		 * Notify runtime PM as well of this cpu powering down
+		 * TODO: Merge CPU_PM and runtime PM.
+		 */
+		RCU_NONIDLE(pm_runtime_put_sync(cpu_dev));
+
+		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
 		arm_cpuidle_suspend(idx);
 
+		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
 		cpu_pm_exit();
 	}
 
-- 
2.1.4

