From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 7/9] ARM: cpuidle: Add runtime PM support for CPU idle
Date: Tue,  4 Aug 2015 17:35:37 -0600
Message-ID: <1438731339-58317-8-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35794 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbbHDXgR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 19:36:17 -0400
Received: by pabxd6 with SMTP id xd6so2468698pab.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 16:36:16 -0700 (PDT)
In-Reply-To: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its  PM domain.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..ca118ed 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,12 +11,14 @@
 
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
 
 #include <asm/cpuidle.h>
@@ -37,6 +39,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
+	struct device *cpu_dev = get_cpu_device(dev->cpu);
 
 	if (!idx) {
 		cpu_do_idle();
@@ -46,12 +49,19 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	ret = cpu_pm_enter();
 	if (!ret) {
 		/*
+		* Notify runtime PM as well of this cpu powering down
+		* TODO: Merge CPU_PM and runtime PM.
+		*/
+		pm_runtime_put_sync(cpu_dev);
+
+		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
 		arm_cpuidle_suspend(idx);
 
+		pm_runtime_get_sync(cpu_dev);
 		cpu_pm_exit();
 	}
 
-- 
2.1.4

