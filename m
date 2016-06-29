From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH v4 1/2] ARM: tango: add HOTPLUG_CPU support
Date: Wed, 29 Jun 2016 14:21:42 +0200
Message-ID: <5773BD56.5040104@sigmadesigns.com>
References: <57726597.8030501@sigmadesigns.com>
 <577266AD.8000006@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <577266AD.8000006@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm-soc <arm@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

cpu_die() and cpu_kill() are implemented in firmware.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
New in v4:
o panic() if tango_cpu_die() returns unexpectedly
o timeout after 10 tries in tango_cpu_kill()
---
 arch/arm/mach-tango/platsmp.c | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tango/smc.h     |  4 +++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
index a21f55e000d2..8380699d4fa3 100644
--- a/arch/arm/mach-tango/platsmp.c
+++ b/arch/arm/mach-tango/platsmp.c
@@ -1,3 +1,4 @@
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
 #include "smc.h"
@@ -9,8 +10,43 @@ static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * cpu_kill() and cpu_die() run concurrently on different cores.
+ * Firmware will only "kill" a core once it has properly "died".
+ * Try a few times to kill a core before giving up, and sleep
+ * between tries to give that core enough time to die.
+ */
+static int tango_cpu_kill(unsigned int cpu)
+{
+	int i, err;
+
+	for (i = 0; i < 10; ++i) {
+		msleep(10);
+		err = tango_aux_core_kill(cpu);
+		if (!err)
+			return true;
+	}
+
+	return false;
+}
+
+static void tango_cpu_die(unsigned int cpu)
+{
+	while (tango_aux_core_die(cpu) < 0)
+		cpu_relax();
+
+	panic("cpu %d failed to die\n", cpu);
+}
+#else
+#define tango_cpu_kill	NULL
+#define tango_cpu_die	NULL
+#endif
+
 static const struct smp_operations tango_smp_ops __initconst = {
 	.smp_boot_secondary	= tango_boot_secondary,
+	.cpu_kill		= tango_cpu_kill,
+	.cpu_die		= tango_cpu_die,
 };
 
 CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango_smp_ops);
diff --git a/arch/arm/mach-tango/smc.h b/arch/arm/mach-tango/smc.h
index 7a4af35cc390..3d31f984f44c 100644
--- a/arch/arm/mach-tango/smc.h
+++ b/arch/arm/mach-tango/smc.h
@@ -2,4 +2,6 @@ extern int tango_smc(unsigned int val, unsigned int service);
 
 #define tango_set_l2_control(val)	tango_smc(val, 0x102)
 #define tango_start_aux_core(val)	tango_smc(val, 0x104)
-#define tango_set_aux_boot_addr(val)	tango_smc((unsigned int)val, 0x105)
+#define tango_set_aux_boot_addr(val)	tango_smc(val, 0x105)
+#define tango_aux_core_die(val)		tango_smc(val, 0x121)
+#define tango_aux_core_kill(val)	tango_smc(val, 0x122)
-- 
2.9.0
