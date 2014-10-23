From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 08/11] ARM: shmobile: r8a7740: Add D4 pm domain support
Date: Thu, 23 Oct 2014 13:18:58 +0200
Message-ID: <1414063141-8856-9-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the D4 power domain.
This domain contains the Coresight-ETM hardware block.

As long as the ARM debug/perf code doesn't use resource management with
runtime PM support, the D4 power domain must be kept powered to avoid a
crash during resume from s2ram (dbg_cpu_pm_notify() calls
reset_ctrl_regs() unconditionally, causing an undefined instruction
oops).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Always keep D4 powered, until the new Coresight code handles runtime
    PM,
v2:
  - Really add D4 and drop the FIXME, as a fix for the crash is
    available.
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 081a4f9726a0c909..8b1af2a585ab99d4 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -32,6 +32,16 @@ static int r8a7740_pd_a3sp_suspend(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
+static int r8a7740_pd_d4_suspend(void)
+{
+	/*
+	 * The D4 domain contains the Coresight-ETM hardware block and
+	 * therefore it should only be turned off if the debug module is
+	 * not in use.
+	 */
+	return -EBUSY;
+}
+
 static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	{
 		.genpd.name	= "A4LC",
@@ -40,6 +50,11 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4MP",
 		.bit_shift	= 2,
 	}, {
+		.genpd.name	= "D4",
+		.bit_shift	= 3,
+		.gov		= &pm_domain_always_on_gov,
+		.suspend	= r8a7740_pd_d4_suspend,
+	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
-- 
1.9.1

