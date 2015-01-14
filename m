From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/6] ARM: shmobile: R-Mobile: Special-case PM domains with memory-controllers
Date: Wed, 14 Jan 2015 13:11:22 +0100
Message-ID: <1421237484-16847-5-git-send-email-geert+renesas@glider.be>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a special case for PM domains containing a memory-controller.
Such a PM domain must not be turned off if memory is in use.

On sh73a0 PM domains A4BC0 and A4BC1 each contain an SDRAM Bus State
Controller (SBSC). On r8a73a4 PM domain A3BC contains two DDR Bus
Controllers (DBSC).  In both cases, there are no other devices in these
PM domains, so they were eligible for power down, crashing the system.

On r8a7740 the DDR3 Bus State Controller (DBSC3) is located in A4S,
whose child domain A3SM contains the CPU core. Hence A4S is never turned
off, and no crash happened.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Rename PD_SBSC to PD_MEMCTL,
  - Reword code comments and patch description.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index e4c3f7de48e2ccf2..95018209ff0b37cc 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -222,6 +222,7 @@ enum pd_types {
 	PD_CPU,
 	PD_CONSOLE,
 	PD_DEBUG,
+	PD_MEMCTL,
 };
 
 #define MAX_NUM_SPECIAL_PDS	16
@@ -233,6 +234,14 @@ static struct special_pd {
 
 static unsigned int num_special_pds __initdata;
 
+static const struct of_device_id special_ids[] __initconst = {
+	{ .compatible = "arm,coresight-etm3x", .data = (void *)PD_DEBUG },
+	{ .compatible = "renesas,dbsc-r8a73a4", .data = (void *)PD_MEMCTL, },
+	{ .compatible = "renesas,dbsc3-r8a7740", .data = (void *)PD_MEMCTL, },
+	{ .compatible = "renesas,sbsc-sh73a0", .data = (void *)PD_MEMCTL, },
+	{ /* sentinel */ },
+};
+
 static void __init add_special_pd(struct device_node *np, enum pd_types type)
 {
 	unsigned int i;
@@ -265,6 +274,7 @@ static void __init add_special_pd(struct device_node *np, enum pd_types type)
 static void __init get_special_pds(void)
 {
 	struct device_node *np;
+	const struct of_device_id *id;
 
 	/* PM domains containing CPUs */
 	for_each_node_by_type(np, "cpu")
@@ -274,12 +284,9 @@ static void __init get_special_pds(void)
 	if (of_stdout)
 		add_special_pd(of_stdout, PD_CONSOLE);
 
-	/* PM domain containing Coresight-ETM */
-	np = of_find_compatible_node(NULL, NULL, "arm,coresight-etm3x");
-	if (np) {
-		add_special_pd(np, PD_DEBUG);
-		of_node_put(np);
-	}
+	/* PM domains containing other special devices */
+	for_each_matching_node_and_match(np, special_ids, &id)
+		add_special_pd(np, (enum pd_types)id->data);
 }
 
 static void __init put_special_pds(void)
@@ -334,6 +341,16 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		pd->suspend = rmobile_pd_suspend_busy;
 		break;
 
+	case PD_MEMCTL:
+		/*
+		 * This domain contains a memory-controller and therefore it
+		 * should only be turned off if memory is not in use.
+		 */
+		pr_debug("PM domain %s contains MEMCTL\n", name);
+		pd->gov = &pm_domain_always_on_gov;
+		pd->suspend = rmobile_pd_suspend_busy;
+		break;
+
 	case PD_NORMAL:
 		break;
 	}
-- 
1.9.1

