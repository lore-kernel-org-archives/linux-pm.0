From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 08/13] ARM: shmobile: smp: Add function to prioritize DT SMP
Date: Tue, 28 Jun 2016 16:10:37 +0200
Message-ID: <1467123042-8468-9-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:33606 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbcF1OKt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 10:10:49 -0400
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Magnus Damm <damm+renesas@opensource.se>

Add a function to check if other DT based method is available, and
if so return false to not hook up smp_ops from the machine vector.

This results in that DT-based SMP support has priority over older
C-based smp_ops code, and in case DT-based SMP support code does not
exist in the DTB then the old smp_ops code will still work as-is.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - No changes,

v4:
  - Remove empty line at end of file,

v3:
  - No changes,

v2:
  - Rework r8a7791-specific version to become reusable function.
---
 arch/arm/mach-shmobile/common.h  | 1 +
 arch/arm/mach-shmobile/platsmp.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 3b562d87826d7410..1a8f7b3ab449db56 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -10,6 +10,7 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
+extern bool shmobile_smp_init_fallback_ops(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
 					  unsigned int max_cpus);
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index b23378f3d7e1726b..f3dba6f356e29446 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -36,3 +36,9 @@ bool shmobile_smp_cpu_can_disable(unsigned int cpu)
 	return true; /* Hotplug of any CPU is supported */
 }
 #endif
+
+bool __init shmobile_smp_init_fallback_ops(void)
+{
+	/* fallback on PSCI/smp_ops if no other DT based method is detected */
+	return platform_can_secondary_boot() ? true : false;
+}
-- 
1.9.1

