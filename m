From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] davinci: cpuidle - remove the ops
Date: Fri,  1 Feb 2013 14:48:14 +0100
Message-ID: <1359726495-8024-4-git-send-email-daniel.lezcano@linaro.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1359726495-8024-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

With one function handling the idle state and a single variable,
the usage of the davinci_ops is overkill.

This patch removes these ops and simplify the code.

Furthermore, the 'driver_data' field is no longer used, we have
1 of the 3 remaining user of this field removed.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-davinci/cpuidle.c |   33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 9438672..28cc8e8 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -25,12 +25,6 @@
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
-struct davinci_ops {
-	void (*enter) (void);
-	void (*exit) (void);
-	u32 flags;
-};
-
 static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
 static bool ddr2_pdown = false;
@@ -54,39 +48,17 @@ static void davinci_save_ddr_power(int enter, bool pdown)
 	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
 }
 
-static void davinci_c2state_enter(void)
-{
-	davinci_save_ddr_power(1, ddr2_pdown);
-}
-
-static void davinci_c2state_exit(void)
-{
-	davinci_save_ddr_power(0, ddr2_pdown);
-}
-
-static struct davinci_ops davinci_states[DAVINCI_CPUIDLE_MAX_STATES] = {
-	[1] = {
-		.enter	= davinci_c2state_enter,
-		.exit	= davinci_c2state_exit,
-	},
-};
-
 /* Actual code that puts the SoC in different idle states */
 static int davinci_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 						int index)
 {
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
-
-	if (ops && ops->enter)
-		ops->enter();
+	davinci_save_ddr_power(1, ddr2_pdown);
 
 	index = cpuidle_wrap_enter(dev,	drv, index,
 				arm_cpuidle_simple_enter);
 
-	if (ops && ops->exit)
-		ops->exit();
+	davinci_save_ddr_power(0, ddr2_pdown);
 
 	return index;
 }
@@ -123,7 +95,6 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 	ddr2_reg_base = pdata->ddr2_ctlr_base;
 
 	ddr2_pdown = pdata->ddr2_pdown;
-	cpuidle_set_statedata(&device->states_usage[1], &davinci_states[1]);
 
 	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
 
-- 
1.7.9.5
