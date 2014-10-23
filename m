From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] ARM: shmobile: sh7372: Keep D4 pm domain powered
Date: Thu, 23 Oct 2014 13:31:14 +0200
Message-ID: <1414063874-9533-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:53073 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbaJWLbN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Oct 2014 07:31:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

The D4 power domain contains the Coresight-ETM hardware block.
As long as the ARM debug/perf code doesn't use resource management with
runtime PM support, the D4 power domain must be kept powered to avoid a
crash during resume from s2ram (dbg_cpu_pm_notify() calls
reset_ctrl_regs() unconditionally, causing an undefined instruction
oops).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested on real hardware, but a similar workaround is needed on r8a7740.

 arch/arm/mach-shmobile/pm-sh7372.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 7e5c2676c48902f1..cedffdd4b476adb4 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -77,6 +77,16 @@
 
 #define PM_DOMAIN_ON_OFF_LATENCY_NS	250000
 
+static int sh7372_d4_pd_suspend(void)
+{
+	/*
+	 * The D4 domain contains the Coresight-ETM hardware block and
+	 * therefore it should only be turned off if the debug module is
+	 * not in use.
+	 */
+	return -EBUSY;
+}
+
 static int sh7372_a4r_pd_suspend(void)
 {
 	sh7372_intcs_suspend();
@@ -131,6 +141,8 @@ static struct rmobile_pm_domain sh7372_pm_domains[] = {
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 3,
+		.gov = &pm_domain_always_on_gov,
+		.suspend = sh7372_d4_pd_suspend,
 	},
 	{
 		.genpd.name = "A4R",
-- 
1.9.1

