From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 13/27] ARM: cpuidle: Add runtime PM support for CPU idle
Date: Tue, 17 Nov 2015 15:37:37 -0700
Message-ID: <1447799871-56374-14-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its PM domain.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..8e72a23 100644
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
 
@@ -45,6 +48,10 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 
 	ret = cpu_pm_enter();
 	if (!ret) {
+		struct device *cpu_dev = get_cpu_device(dev->cpu);
+
+		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
+
 		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
@@ -52,6 +59,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 		 */
 		arm_cpuidle_suspend(idx);
 
+		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
 		cpu_pm_exit();
 	}
 
-- 
2.1.4
