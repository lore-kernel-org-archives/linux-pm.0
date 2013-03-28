From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 08/12] ARM: ux500: Add ApSleep state to suspend
Date: Thu, 28 Mar 2013 17:11:34 +0100
Message-ID: <1364487098-10319-9-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hongbo.zhang@linaro.org, ulf.hansson@linaro.org, khilman@linaro.org, linus.walleij@stericsson.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com
List-Id: linux-pm@vger.kernel.org

Support for power save state ApSleep is
added to the platform suspend operation
hook.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/mach-ux500/suspend.c | 57 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/suspend.c b/arch/arm/mach-ux500/suspend.c
index d1ac203..875a92d 100644
--- a/arch/arm/mach-ux500/suspend.c
+++ b/arch/arm/mach-ux500/suspend.c
@@ -10,11 +10,60 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/pm_domain.h>
+#include <linux/mfd/dbx500-prcmu.h>
+
+static u32 suspend_wakeups;
+static u32 running_wakeups;
+static struct generic_pm_domain *ape_domain;
 
 static int ux500_suspend_enter(suspend_state_t state)
 {
+	int ret = 0;
+
+	/* Configure the PRCMU for a sleep wakeup */
+	prcmu_enable_wakeups(suspend_wakeups);
+
+	pm_genpd_notify_power_on_off(ape_domain, false);
+
+	prcmu_gic_decouple();
+
+	/* Copy GIC interrupt settings to PRCMU interrupt settings */
+	prcmu_copy_gic_settings();
+
+	if (prcmu_gic_pending_irq()) {
+		pr_info("suspend/resume: pending interrupt\n");
+
+		/* Recouple GIC with the interrupt bus */
+		prcmu_gic_recouple();
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	if (prcmu_pending_irq()) {
+		pr_info("suspend/resume: pending interrupt prcmu\n");
+
+		/* Recouple GIC with the interrupt bus */
+		prcmu_gic_recouple();
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	prcmu_set_ioforce(true);
+
+	prcmu_set_power_state(PRCMU_AP_SLEEP, false, false);
+
 	cpu_do_idle();
-	return 0;
+
+	pm_genpd_notify_power_on_off(ape_domain, true);
+
+	prcmu_set_ioforce(false);
+
+ exit:
+	/* Configure the prcmu with the wake-ups that cpuidle needs */
+	prcmu_enable_wakeups(running_wakeups);
+
+	return ret;
 }
 
 static int ux500_suspend_valid(suspend_state_t state)
@@ -29,6 +78,12 @@ static const struct platform_suspend_ops ux500_suspend_ops = {
 
 static __init int ux500_suspend_init(void)
 {
+	suspend_wakeups = PRCMU_WAKEUP(ABB) | PRCMU_WAKEUP(RTC);
+	running_wakeups = (PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
+				   PRCMU_WAKEUP(ABB));
+
+	ape_domain = pm_genpd_lookup_name("APE");
+
 	suspend_set_ops(&ux500_suspend_ops);
 	return 0;
 }
-- 
1.8.2
