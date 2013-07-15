From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH 04/11] ARM: mvebu: remove device tree parsing for cpu nodes
Date: Mon, 15 Jul 2013 11:22:05 +0100
Message-ID: <1373883732-26303-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, viresh.kumar@linaro.org, rob.herring@calxeda.com, rjw@sisk.pl, grant.likely@linaro.org, cpufreq@vger.kernel.org, kernel@pengutronix.de, gregkh@linuxfoundation.org, olof@lixom.net, gregory.clement@free-electrons.com, shawn.guo@linaro.org
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently set_secondary_cpus_clock assume the CPU logical ordering
and the MPDIR in DT are same, which is incorrect.

Since the CPU device nodes can be retrieved in the logical ordering
using the helper, we can remove the devices tree parsing.

This patch removes DT parsing by making use of arch_of_get_cpu_node.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-mvebu/platsmp.c | 52 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 93f2f3a..b57af6c 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -23,51 +23,47 @@
 #include <linux/of.h>
 #include <linux/mbus.h>
 #include <asm/cacheflush.h>
+#include <asm/prom.h>
 #include <asm/smp_plat.h>
 #include "common.h"
 #include "armada-370-xp.h"
 #include "pmsu.h"
 #include "coherency.h"
 
+static struct clk *__init get_cpu_clk(int cpu)
+{
+	struct clk *cpu_clk;
+	struct device_node *np = arch_of_get_cpu_node(cpu);
+
+	if (WARN(!np, "missing cpu node\n"))
+		return NULL;
+	cpu_clk = of_clk_get(np, 0);
+	if (WARN_ON(IS_ERR(cpu_clk)))
+		return NULL;
+	return cpu_clk;
+}
+
 void __init set_secondary_cpus_clock(void)
 {
-	int thiscpu;
+	int thiscpu, cpu;
 	unsigned long rate;
-	struct clk *cpu_clk = NULL;
-	struct device_node *np = NULL;
+	struct clk *cpu_clk;
 
 	thiscpu = smp_processor_id();
-	for_each_node_by_type(np, "cpu") {
-		int err;
-		int cpu;
-
-		err = of_property_read_u32(np, "reg", &cpu);
-		if (WARN_ON(err))
-			return;
-
-		if (cpu == thiscpu) {
-			cpu_clk = of_clk_get(np, 0);
-			break;
-		}
-	}
-	if (WARN_ON(IS_ERR(cpu_clk)))
+	cpu_clk = get_cpu_clk(thiscpu);
+	if (!cpu_clk)
 		return;
 	clk_prepare_enable(cpu_clk);
 	rate = clk_get_rate(cpu_clk);
 
 	/* set all the other CPU clk to the same rate than the boot CPU */
-	for_each_node_by_type(np, "cpu") {
-		int err;
-		int cpu;
-
-		err = of_property_read_u32(np, "reg", &cpu);
-		if (WARN_ON(err))
+	for_each_possible_cpu(cpu) {
+		if (cpu == thiscpu)
+			continue;
+		cpu_clk = get_cpu_clk(cpu);
+		if (!cpu_clk)
 			return;
-
-		if (cpu != thiscpu) {
-			cpu_clk = of_clk_get(np, 0);
-			clk_set_rate(cpu_clk, rate);
-		}
+		clk_set_rate(cpu_clk, rate);
 	}
 }
 
-- 
1.8.1.2
