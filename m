From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 11/27] drivers: cpu: Define CPU devices as IRQ safe
Date: Tue, 17 Nov 2015 15:37:35 -0700
Message-ID: <1447799871-56374-12-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

CPUs may be powered off from CPUIdle or hotplug and are called with
IRQ's disabled. Define CPU devices as IRQ safe, so they may be runtime
suspended/resumed.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 91bbb19..6633210 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 
@@ -371,10 +372,11 @@ int register_cpu(struct cpu *cpu, int num)
 	if (cpu->hotpluggable)
 		cpu->dev.groups = hotplugable_cpu_attr_groups;
 	error = device_register(&cpu->dev);
-	if (!error)
+	if (!error) {
+		pm_runtime_irq_safe(&cpu->dev);
 		per_cpu(cpu_sys_devices, num) = &cpu->dev;
-	if (!error)
 		register_cpu_under_node(num, cpu_to_node(num));
+	}
 
 	return error;
 }
-- 
2.1.4
