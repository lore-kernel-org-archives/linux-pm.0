From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] ARM: DAVINCI: cpuidle - remove ops
Date: Thu, 10 May 2012 10:44:45 +0200
Message-ID: <1336639485-26955-3-git-send-email-daniel.lezcano@linaro.org>
References: <1336639485-26955-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1336639485-26955-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch removes the ops usage because we have the index
passed as parameter to the idle function and we can determine
if we do WFI or memory retention.

The benefit of this cleanup is the removal of:
 * the ops
 * the statedata usage because we want to get rid of it in all the drivers
 * extra structure definition
 * extra functions definition
 * pointless macro definition BIT(0)

It also benefits the readability.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-davinci/cpuidle.c |   81 +++++++++++++--------------------------
 1 files changed, 27 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index f0f179c..61f4e52 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -25,35 +25,46 @@
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
-struct davinci_ops {
-	void (*enter) (u32 flags);
-	void (*exit) (u32 flags);
-	u32 flags;
-};
+static bool ddr2_pwdn = false;
+
+static void __iomem *ddr2_reg_base;
+
+static void davinci_save_ddr_power(int enter, bool pdown)
+{
+	u32 val;
+
+	val = __raw_readl(ddr2_reg_base + DDR2_SDRCR_OFFSET);
+
+	if (enter) {
+		if (pdown)
+			val |= DDR2_SRPD_BIT;
+		else
+			val &= ~DDR2_SRPD_BIT;
+		val |= DDR2_LPMODEN_BIT;
+	} else {
+		val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
+	}
+
+	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
+}
 
 /* Actual code that puts the SoC in different idle states */
 static int davinci_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 						int index)
 {
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
-
-	if (ops && ops->enter)
-		ops->enter(ops->flags);
+	if (index)
+		davinci_save_ddr_power(1, ddr2_pwdn);
 
 	index = cpuidle_wrap_enter(dev,	drv, index,
 				arm_cpuidle_simple_enter);
 
-	if (ops && ops->exit)
-		ops->exit(ops->flags);
+	if (index)
+		davinci_save_ddr_power(0, ddr2_pwdn);
 
 	return index;
 }
 
-/* fields in davinci_ops.flags */
-#define DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN	BIT(0)
-
 static struct cpuidle_driver davinci_idle_driver = {
 	.name			= "cpuidle-davinci",
 	.owner			= THIS_MODULE,
@@ -71,43 +82,6 @@ static struct cpuidle_driver davinci_idle_driver = {
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
-static void __iomem *ddr2_reg_base;
-
-static void davinci_save_ddr_power(int enter, bool pdown)
-{
-	u32 val;
-
-	val = __raw_readl(ddr2_reg_base + DDR2_SDRCR_OFFSET);
-
-	if (enter) {
-		if (pdown)
-			val |= DDR2_SRPD_BIT;
-		else
-			val &= ~DDR2_SRPD_BIT;
-		val |= DDR2_LPMODEN_BIT;
-	} else {
-		val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
-	}
-
-	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
-}
-
-static void davinci_c2state_enter(u32 flags)
-{
-	davinci_save_ddr_power(1, !!(flags & DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN));
-}
-
-static void davinci_c2state_exit(u32 flags)
-{
-	davinci_save_ddr_power(0, !!(flags & DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN));
-}
-
-static struct davinci_ops davinci_states[DAVINCI_CPUIDLE_MAX_STATES] = {
-	[1] = {
-		.enter	= davinci_c2state_enter,
-		.exit	= davinci_c2state_exit,
-	},
-};
 
 static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 {
@@ -125,8 +99,7 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 	ddr2_reg_base = pdata->ddr2_ctlr_base;
 
 	if (pdata->ddr2_pdown)
-		davinci_states[1].flags |= DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN;
-	cpuidle_set_statedata(&device->states_usage[1], &davinci_states[1]);
+		ddr2_pwdn = true;
 
 	ret = cpuidle_register_driver(&davinci_idle_driver);
 	if (ret) {
-- 
1.7.5.4
