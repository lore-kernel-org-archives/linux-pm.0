From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: shmobile: R-Mobile: Fix DT refcount bugs in PM domain code
Date: Wed, 14 Jan 2015 11:50:48 +0100
Message-ID: <1421232648-15204-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Fix two DT refcount imbalances in the PM domain code that scans the DT
topology:

  1. Add missing of_node_put() after of_find_compatible_node().

  2. If CONFIG_OF_DYNAMIC=y:

	ERROR: Bad of_node_put() on /system-controller@e6180000
	<backtrace>

     of_find_node_by_name() calls of_node_put() on its "from" parameter,
     which must not be done on the for_each_compatible_node() iterator,
     as it causes a zero refcount later.
     Use of_get_child_by_name() instead to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Fixes: d7a3a10c8391fdcd ("ARM: shmobile: R-Mobile: Add DT support for PM domains")
in Simon's git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
tag renesas-dt-pm-for-v3.20
---
 arch/arm/mach-shmobile/pm-rmobile.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 07fb4ea4d8e94258..85a7fdd9823bc5a6 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -270,8 +270,10 @@ static void __init get_special_pds(void)
 
 	/* PM domain containing Coresight-ETM */
 	np = of_find_compatible_node(NULL, NULL, "arm,coresight-etm3x");
-	if (np)
+	if (np) {
 		debug_pd = of_parse_phandle(np, "power-domains", 0);
+		of_node_put(np);
+	}
 }
 
 static void __init put_special_pds(void)
@@ -363,7 +365,7 @@ static int __init rmobile_init_pm_domains(void)
 			continue;
 		}
 
-		pmd = of_find_node_by_name(np, "pm-domains");
+		pmd = of_get_child_by_name(np, "pm-domains");
 		if (!pmd) {
 			pr_warn("%s lacks pm-domains node\n", np->full_name);
 			continue;
-- 
1.9.1

