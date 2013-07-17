From: Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org
Subject: [RFC PATCH v2 05/15] ARM: mvebu: remove device tree parsing for cpu
 nodes
Date: Wed, 17 Jul 2013 15:06:14 +0100
Message-ID: <1374069984-20567-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>

Currently set_secondary_cpus_clock assume the CPU logical ordering
and the MPDIR in DT are same, which is incorrect.

Since the CPU device nodes can be retrieved in the logical ordering
using the DT helper, we can remove the devices tree parsing.

This patch removes DT parsing by making use of of_get_cpu_node.

Cc: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/mach-mvebu/platsmp.c | 52 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 93f2f3a..12585ad 100644
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
+	struct device_node *np = of_get_cpu_node(cpu);
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
