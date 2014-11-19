From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 4/7] ARM: shmobile: R-Mobile: Special-case PM domains containing SBSCs
Date: Wed, 19 Nov 2014 16:57:31 +0100
Message-ID: <1416412654-6508-5-git-send-email-geert+renesas@glider.be>
References: <1416412654-6508-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416412654-6508-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a special case for PM domains containing a memory controller like
the SDRAM Bus State Controller (SBSC). Such a PM domain must not be
turned off if SDRAM is in use.

On sh73a0 PM domains A4BC0 and A4BC1 each contain an SDRAM Bus State
Controller (SBSC1 resp. SBSC2). On r8a73a4 PM domain A3BC contains a DDR
Bus Controller (DBSC).  In both cases, there are no other devices in
these PM domains, so they were eligible for power down, crashing the
system.

On r8a7740 the DDR3 Bus State Controller (DBSC3) is located in A4S,
whose child domain A3SM contains the CPU core. Hence A4S is never turned
off, and no crash happened.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 774a8e276049a202..4bae656a83b4fca3 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -231,6 +231,7 @@ enum pd_types {
 	PD_CPU,
 	PD_CONSOLE,
 	PD_DEBUG,
+	PD_SBSC,
 };
 
 #define MAX_NUM_SPECIAL_PDS	16
@@ -242,6 +243,14 @@ static struct special_pd {
 
 static unsigned int num_special_pds __initdata;
 
+static const struct of_device_id special_ids[] __initconst = {
+	{ .compatible = "arm,coresight-etm3x", .data = (void *)PD_DEBUG },
+	{ .compatible = "renesas,dbsc-r8a73a4", .data = (void *)PD_SBSC, },
+	{ .compatible = "renesas,dbsc3-r8a7740", .data = (void *)PD_SBSC, },
+	{ .compatible = "renesas,sbsc-sh73a0", .data = (void *)PD_SBSC, },
+	{ /* sentinel */ },
+};
+
 static void __init add_special_pd(struct device_node *np, enum pd_types type)
 {
 	unsigned int i;
@@ -277,6 +286,7 @@ static void __init add_special_pd(struct device_node *np, enum pd_types type)
 static void __init get_special_pds(void)
 {
 	struct device_node *np;
+	const struct of_device_id *id;
 
 	/* PM domains containing CPUs */
 	for_each_node_by_type(np, "cpu")
@@ -286,10 +296,9 @@ static void __init get_special_pds(void)
 	if (of_stdout)
 		add_special_pd(of_stdout, PD_CONSOLE);
 
-	/* PM domain containing Coresight-ETM */
-	np = of_find_compatible_node(NULL, NULL, "arm,coresight-etm3x");
-	if (np)
-		add_special_pd(np, PD_DEBUG);
+	/* PM domains containing other special devices */
+	for_each_matching_node_and_match(np, special_ids, &id)
+		add_special_pd(np, (enum pd_types)id->data);
 }
 
 static void __init put_special_pds(void)
@@ -344,6 +353,17 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		pd->suspend = rmobile_pd_suspend_busy;
 		break;
 
+	case PD_SBSC:
+		/*
+		 * This domain contains the SDRAM Bus State Controller and
+		 * therefore it should only be turned off if SDRAM is not in
+		 * use.
+		 */
+		pr_debug("PM domain %s contains SBSC\n", name);
+		pd->gov = &pm_domain_always_on_gov;
+		pd->suspend = rmobile_pd_suspend_busy;
+		break;
+
 	case PD_NORMAL:
 		break;
 	}
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
