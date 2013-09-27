From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH 1/6] cpuidle: calxeda: add support to use PSCI calls
Date: Thu, 26 Sep 2013 21:24:49 -0500
Message-ID: <1380248694-13388-2-git-send-email-robherring2@gmail.com>
References: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rob Herring <rob.herring@calxeda.com>

This updates the Calxeda cpuidle driver to use PSCI calls to powergate
cores. This is needed to enable cpuidle for the ECX-2000.

This could possibly become a generic PSCI driver, but there are no other
PSCI users in the kernel other than mach-virt.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpuidle/Kconfig.arm       |  2 +-
 drivers/cpuidle/cpuidle-calxeda.c | 40 ++++++---------------------------------
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..d6f57d5 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -4,7 +4,7 @@
 
 config ARM_HIGHBANK_CPUIDLE
 	bool "CPU Idle Driver for Calxeda processors"
-	depends on ARCH_HIGHBANK
+	depends on ARM_PSCI
 	select ARM_CPU_SUSPEND
 	help
 	  Select this to enable cpuidle on Calxeda processors.
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index 3460584..01cfecf3 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -22,51 +22,23 @@
 
 #include <linux/cpuidle.h>
 #include <linux/init.h>
-#include <linux/io.h>
 #include <linux/of.h>
-#include <linux/time.h>
-#include <linux/delay.h>
-#include <linux/suspend.h>
 #include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-#include <asm/smp_scu.h>
 #include <asm/suspend.h>
-#include <asm/cacheflush.h>
-#include <asm/cp15.h>
-
-extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
-extern void __iomem *scu_base_addr;
-
-static noinline void calxeda_idle_restore(void)
-{
-	set_cr(get_cr() | CR_C);
-	set_auxcr(get_auxcr() | 0x40);
-	scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
-}
+#include <asm/psci.h>
 
 static int calxeda_idle_finish(unsigned long val)
 {
-	/* Already flushed cache, but do it again as the outer cache functions
-	 * dirty the cache with spinlocks */
-	flush_cache_all();
-
-	set_auxcr(get_auxcr() & ~0x40);
-	set_cr(get_cr() & ~CR_C);
-
-	scu_power_mode(scu_base_addr, SCU_PM_DORMANT);
-
-	cpu_do_idle();
-
-	/* Restore things if we didn't enter power-gating */
-	calxeda_idle_restore();
-	return 1;
+	const struct psci_power_state ps = {
+		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+	};
+	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
 }
 
 static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	highbank_set_cpu_jump(smp_processor_id(), cpu_resume);
 	cpu_suspend(0, calxeda_idle_finish);
 	return index;
 }
@@ -90,7 +62,7 @@ static struct cpuidle_driver calxeda_idle_driver = {
 
 static int __init calxeda_cpuidle_init(void)
 {
-	if (!of_machine_is_compatible("calxeda,highbank"))
+	if (!of_machine_is_compatible("calxeda,highbank") || !psci_ops.cpu_suspend)
 		return -ENODEV;
 
 	return cpuidle_register(&calxeda_idle_driver, NULL);
-- 
1.8.1.2
