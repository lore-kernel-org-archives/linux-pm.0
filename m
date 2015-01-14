From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/6] ARM: shmobile: R-Mobile: Generalize adding/looking up special PM domains
Date: Wed, 14 Jan 2015 13:11:21 +0100
Message-ID: <1421237484-16847-4-git-send-email-geert+renesas@glider.be>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Make adding special PM domains to an array, and looking them up
later, more generic, so it can be used for all special hardware blocks.
The type of PM domain is also stored, so rmobile_setup_pm_domain() can
use a switch() statement instead of a chain of if/else statements.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Rebase on top of "ARM: shmobile: R-Mobile: Fix DT refcount bugs in
    PM domain code",
  - Merge "break" and "i < num_special_pds" block in add_special_pd().
---
 arch/arm/mach-shmobile/pm-rmobile.c | 102 ++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index e1be4b8919efe30e..e4c3f7de48e2ccf2 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -217,50 +217,67 @@ static int rmobile_pd_suspend_console(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
-#define MAX_NUM_CPU_PDS		8
+enum pd_types {
+	PD_NORMAL,
+	PD_CPU,
+	PD_CONSOLE,
+	PD_DEBUG,
+};
 
-static unsigned int num_cpu_pds __initdata;
-static struct device_node *cpu_pds[MAX_NUM_CPU_PDS] __initdata;
-static struct device_node *console_pd __initdata;
-static struct device_node *debug_pd __initdata;
+#define MAX_NUM_SPECIAL_PDS	16
 
-static void __init get_special_pds(void)
-{
-	struct device_node *np, *pd;
-	unsigned int i;
+static struct special_pd {
+	struct device_node *pd;
+	enum pd_types type;
+} special_pds[MAX_NUM_SPECIAL_PDS] __initdata;
 
-	/* PM domains containing CPUs */
-	for_each_node_by_type(np, "cpu") {
-		pd = of_parse_phandle(np, "power-domains", 0);
-		if (!pd)
-			continue;
+static unsigned int num_special_pds __initdata;
 
-		for (i = 0; i < num_cpu_pds; i++)
-			if (pd == cpu_pds[i])
-				break;
+static void __init add_special_pd(struct device_node *np, enum pd_types type)
+{
+	unsigned int i;
+	struct device_node *pd;
 
-		if (i < num_cpu_pds) {
-			of_node_put(pd);
-			continue;
-		}
+	pd = of_parse_phandle(np, "power-domains", 0);
+	if (!pd)
+		return;
 
-		if (num_cpu_pds == MAX_NUM_CPU_PDS) {
-			pr_warn("Too many CPU PM domains\n");
+	for (i = 0; i < num_special_pds; i++)
+		if (pd == special_pds[i].pd && type == special_pds[i].type) {
 			of_node_put(pd);
-			continue;
+			return;
 		}
 
-		cpu_pds[num_cpu_pds++] = pd;
+	if (num_special_pds == ARRAY_SIZE(special_pds)) {
+		pr_warn("Too many special PM domains\n");
+		of_node_put(pd);
+		return;
 	}
 
+	pr_debug("Special PM domain %s type %d for %s\n", pd->name, type,
+		 np->full_name);
+
+	special_pds[num_special_pds].pd = pd;
+	special_pds[num_special_pds].type = type;
+	num_special_pds++;
+}
+
+static void __init get_special_pds(void)
+{
+	struct device_node *np;
+
+	/* PM domains containing CPUs */
+	for_each_node_by_type(np, "cpu")
+		add_special_pd(np, PD_CPU);
+
 	/* PM domain containing console */
 	if (of_stdout)
-		console_pd = of_parse_phandle(of_stdout, "power-domains", 0);
+		add_special_pd(of_stdout, PD_CONSOLE);
 
 	/* PM domain containing Coresight-ETM */
 	np = of_find_compatible_node(NULL, NULL, "arm,coresight-etm3x");
 	if (np) {
-		debug_pd = of_parse_phandle(np, "power-domains", 0);
+		add_special_pd(np, PD_DEBUG);
 		of_node_put(np);
 	}
 }
@@ -269,21 +286,19 @@ static void __init put_special_pds(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < num_cpu_pds; i++)
-		of_node_put(cpu_pds[i]);
-	of_node_put(console_pd);
-	of_node_put(debug_pd);
+	for (i = 0; i < num_special_pds; i++)
+		of_node_put(special_pds[i].pd);
 }
 
-static bool __init pd_contains_cpu(const struct device_node *pd)
+static enum pd_types __init pd_type(const struct device_node *pd)
 {
 	unsigned int i;
 
-	for (i = 0; i < num_cpu_pds; i++)
-		if (pd == cpu_pds[i])
-			return true;
+	for (i = 0; i < num_special_pds; i++)
+		if (pd == special_pds[i].pd)
+			return special_pds[i].type;
 
-	return false;
+	return PD_NORMAL;
 }
 
 static void __init rmobile_setup_pm_domain(struct device_node *np,
@@ -291,7 +306,8 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 {
 	const char *name = pd->genpd.name;
 
-	if (pd_contains_cpu(np)) {
+	switch (pd_type(np)) {
+	case PD_CPU:
 		/*
 		 * This domain contains the CPU core and therefore it should
 		 * only be turned off if the CPU is not in use.
@@ -299,11 +315,15 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		pr_debug("PM domain %s contains CPU\n", name);
 		pd->gov = &pm_domain_always_on_gov;
 		pd->suspend = rmobile_pd_suspend_busy;
-	} else if (np == console_pd) {
+		break;
+
+	case PD_CONSOLE:
 		pr_debug("PM domain %s contains serial console\n", name);
 		pd->gov = &pm_domain_always_on_gov;
 		pd->suspend = rmobile_pd_suspend_console;
-	} else if (np == debug_pd) {
+		break;
+
+	case PD_DEBUG:
 		/*
 		 * This domain contains the Coresight-ETM hardware block and
 		 * therefore it should only be turned off if the debug module
@@ -312,6 +332,10 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		pr_debug("PM domain %s contains Coresight-ETM\n", name);
 		pd->gov = &pm_domain_always_on_gov;
 		pd->suspend = rmobile_pd_suspend_busy;
+		break;
+
+	case PD_NORMAL:
+		break;
 	}
 
 	rmobile_init_pm_domain(pd);
-- 
1.9.1

