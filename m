From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 06/16] drivers: cpu: Setup CPU devices to do runtime PM
Date: Fri, 26 Aug 2016 14:17:48 -0600
Message-ID: <1472242678-33700-7-git-send-email-lina.iyer@linaro.org>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

CPU devices just like any other device, can do runtime PM. However, CPU
devices may only do runtime only when IRQs are disabled. The devices
must be set as IRQ safe.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/cpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 691eeea..c1e5e77 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 
@@ -344,6 +345,21 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
+#ifdef CONFIG_PM
+static void cpu_runtime_pm_init(struct device *dev)
+{
+	pm_runtime_irq_safe(dev);
+	pm_runtime_enable(dev);
+	if (cpu_online(dev->id)) {
+		pm_runtime_get_noresume(dev);
+		pm_runtime_set_active(dev);
+	}
+}
+#else
+static void cpu_runtime_pm_init(struct device *dev)
+{ }
+#endif
+
 /*
  * register_cpu - Setup a sysfs device for a CPU.
  * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
@@ -376,6 +392,8 @@ int register_cpu(struct cpu *cpu, int num)
 	if (!error)
 		register_cpu_under_node(num, cpu_to_node(num));
 
+	cpu_runtime_pm_init(&cpu->dev);
+
 	return error;
 }
 
-- 
2.7.4
