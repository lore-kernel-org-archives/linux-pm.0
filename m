From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/9] ARM: davinci: cpuidle: fix wrong enter function
Date: Fri, 29 Mar 2013 11:31:33 +0100
Message-ID: <1364553095-25110-7-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The davinci_enter_idle is called from the cpuidle with the
cpuidle_wrap_enter function. This one does the time compution
for entering and exiting the idle function and then we call
again cpuidle_wrap_enter for cpu_do_idle. This is wrong, we
are calling recursively cpuidle_wrap_enter for nothing and
furthermore reenabling the local irq.

Remove this and replace it by the cpu_do_idle function.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-davinci/cpuidle.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 5ac9e93..22d6d4a 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -50,14 +50,10 @@ static void davinci_save_ddr_power(int enter, bool pdown)
 
 /* Actual code that puts the SoC in different idle states */
 static int davinci_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-						int index)
+			      struct cpuidle_driver *drv, int index)
 {
 	davinci_save_ddr_power(1, ddr2_pdown);
-
-	index = cpuidle_wrap_enter(dev,	drv, index,
-				arm_cpuidle_simple_enter);
-
+	cpu_do_idle();
 	davinci_save_ddr_power(0, ddr2_pdown);
 
 	return index;
-- 
1.7.9.5
