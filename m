From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/6] ARM: shmobile: R-Mobile: Consolidate rmobile_pd_suspend_*()
Date: Wed, 14 Jan 2015 13:11:20 +0100
Message-ID: <1421237484-16847-3-git-send-email-geert+renesas@glider.be>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:34664 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbbANMLc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jan 2015 07:11:32 -0500
In-Reply-To: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Consolidate the identical rmobile_pd_suspend_*() routines that just
return -EBUSY to prevent a PM domain from being powered down into a
single rmobile_pd_suspend_busy().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Break long comment.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 85a7fdd9823bc5a6..e1be4b8919efe30e 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -200,11 +200,10 @@ void rmobile_add_devices_to_domains(struct pm_domain_device data[],
 
 #else /* !CONFIG_ARCH_SHMOBILE_LEGACY */
 
-static int rmobile_pd_suspend_cpu(void)
+static int rmobile_pd_suspend_busy(void)
 {
 	/*
-	 * This domain contains the CPU core and therefore it should
-	 * only be turned off if the CPU is not in use.
+	 * This domain should not be turned off.
 	 */
 	return -EBUSY;
 }
@@ -218,16 +217,6 @@ static int rmobile_pd_suspend_console(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
-static int rmobile_pd_suspend_debug(void)
-{
-	/*
-	 * This domain contains the Coresight-ETM hardware block and
-	 * therefore it should only be turned off if the debug module is
-	 * not in use.
-	 */
-	return -EBUSY;
-}
-
 #define MAX_NUM_CPU_PDS		8
 
 static unsigned int num_cpu_pds __initdata;
@@ -303,17 +292,26 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 	const char *name = pd->genpd.name;
 
 	if (pd_contains_cpu(np)) {
+		/*
+		 * This domain contains the CPU core and therefore it should
+		 * only be turned off if the CPU is not in use.
+		 */
 		pr_debug("PM domain %s contains CPU\n", name);
 		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_cpu;
+		pd->suspend = rmobile_pd_suspend_busy;
 	} else if (np == console_pd) {
 		pr_debug("PM domain %s contains serial console\n", name);
 		pd->gov = &pm_domain_always_on_gov;
 		pd->suspend = rmobile_pd_suspend_console;
 	} else if (np == debug_pd) {
+		/*
+		 * This domain contains the Coresight-ETM hardware block and
+		 * therefore it should only be turned off if the debug module
+		 * is not in use.
+		 */
 		pr_debug("PM domain %s contains Coresight-ETM\n", name);
 		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_debug;
+		pd->suspend = rmobile_pd_suspend_busy;
 	}
 
 	rmobile_init_pm_domain(pd);
-- 
1.9.1

