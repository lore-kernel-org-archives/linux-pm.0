From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 2/9] drivers: cpu: Setup CPU devices to do runtime PM
Date: Fri,  3 Mar 2017 12:41:28 -0800
Message-ID: <1488573695-106680-3-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, brendan.jackman@arm.com, sudeep.holla@arm.com, andy.gross@linaro.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

CPU devices just like any other device, can do runtime PM. However, CPU
devices may only do runtime only when IRQs are disabled. The devices
must be set as IRQ safe.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 2c3b359..77451ad 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -18,6 +18,7 @@
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 
@@ -345,6 +346,19 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
+#ifdef CONFIG_PM
+static void cpu_runtime_pm_init(struct device *dev)
+{
+	pm_runtime_irq_safe(dev);
+	pm_runtime_enable(dev);
+	if (cpu_online(dev->id))
+		pm_runtime_set_active(dev);
+}
+#else
+static void cpu_runtime_pm_init(struct device *dev)
+{ }
+#endif
+
 /*
  * register_cpu - Setup a sysfs device for a CPU.
  * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
@@ -379,6 +393,7 @@ int register_cpu(struct cpu *cpu, int num)
 	register_cpu_under_node(num, cpu_to_node(num));
 	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
 
+	cpu_runtime_pm_init(&cpu->dev);
 	return 0;
 }
 
-- 
2.7.4
