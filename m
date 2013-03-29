From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 9/9] ARM: omap3: cpuidle: enable time keeping
Date: Fri, 29 Mar 2013 11:31:35 +0100
Message-ID: <1364553095-25110-9-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The TIME_VALID flag is specified for the different states but
the time residency computation is not done, no tk flag, no time
computation in the idle function.

Set the en_core_tk_irqen flag to activate it.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 80392fc..4f67a5b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -274,8 +274,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
 static struct cpuidle_driver omap3_idle_driver = {
-	.name =		"omap3_idle",
-	.owner =	THIS_MODULE,
+	.name             = "omap3_idle",
+	.owner            = THIS_MODULE,
+	.en_core_tk_irqen = 1,
 	.states = {
 		{
 			.enter		  = omap3_enter_idle_bm,
-- 
1.7.9.5
