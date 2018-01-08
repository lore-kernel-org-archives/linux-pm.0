From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] power: reset: msm: Clarify restart and poweroff
Date: Sun,  7 Jan 2018 19:33:13 -0800
Message-ID: <20180108033313.13538-1-bjorn.andersson@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When PSHOLD in a Qualcomm platform is deasserted the PMIC will perform
either a power off or a restart of the system. The action to take is
configured in the PON block, which is controlled by a separate driver.

As the configuration logic was added to the pm8941-pwrkey driver the
comment in do_msm_poweroff() is no longer valid and the name
do_msm_restart() is misleading. Update the naming and drop the comment.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/power/reset/msm-poweroff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 4702efdfe466..01b8c71697cb 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -23,7 +23,7 @@
 #include <linux/pm.h>
 
 static void __iomem *msm_ps_hold;
-static int do_msm_restart(struct notifier_block *nb, unsigned long action,
+static int deassert_pshold(struct notifier_block *nb, unsigned long action,
 			   void *data)
 {
 	writel(0, msm_ps_hold);
@@ -33,14 +33,13 @@ static int do_msm_restart(struct notifier_block *nb, unsigned long action,
 }
 
 static struct notifier_block restart_nb = {
-	.notifier_call = do_msm_restart,
+	.notifier_call = deassert_pshold,
 	.priority = 128,
 };
 
 static void do_msm_poweroff(void)
 {
-	/* TODO: Add poweroff capability */
-	do_msm_restart(&restart_nb, 0, NULL);
+	deassert_pshold(&restart_nb, 0, NULL);
 }
 
 static int msm_restart_probe(struct platform_device *pdev)
-- 
2.15.0
