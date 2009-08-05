From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/5] pda-power: switch to new dev_pm_ops
Date: Wed,  5 Aug 2009 20:29:28 +0200
Message-ID: <1249496971-9019-2-git-send-email-daniel__39123.7455922694$1249507281$gmane$org@caiaq.de>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Ian Molton <spyro@f2s.com>, Anton Vorontsov <cbou@mail.ru>, linux-pm@lists.linux-foundation.org, Matt Reimer <mreimer@vpop.net>, Daniel Mack <daniel@caiaq.de>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Ian Molton <spyro@f2s.com>
Cc: Anton Vorontsov <cbou@mail.ru>
Cc: Matt Reimer <mreimer@vpop.net>
---
 drivers/power/pda_power.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/power/pda_power.c b/drivers/power/pda_power.c
index a232de6..34af275 100644
--- a/drivers/power/pda_power.c
+++ b/drivers/power/pda_power.c
@@ -402,9 +402,9 @@ static int pda_power_remove(struct platform_device *pdev)
 static int ac_wakeup_enabled;
 static int usb_wakeup_enabled;
 
-static int pda_power_suspend(struct platform_device *pdev, pm_message_t state)
+static int pda_power_suspend(struct device *dev)
 {
-	if (device_may_wakeup(&pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		if (ac_irq)
 			ac_wakeup_enabled = !enable_irq_wake(ac_irq->start);
 		if (usb_irq)
@@ -414,9 +414,9 @@ static int pda_power_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int pda_power_resume(struct platform_device *pdev)
+static int pda_power_resume(struct device *dev)
 {
-	if (device_may_wakeup(&pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		if (usb_irq && usb_wakeup_enabled)
 			disable_irq_wake(usb_irq->start);
 		if (ac_irq && ac_wakeup_enabled)
@@ -425,21 +425,30 @@ static int pda_power_resume(struct platform_device *pdev)
 
 	return 0;
 }
+
+static struct dev_pm_ops pda_power_pm_ops = {
+	.suspend	= pda_power_suspend,
+	.freeze		= pda_power_freeze,
+	.resume		= pda_power_resume,
+	.thaw		= pda_power_resume,
+};
+
+#define PDA_POWER_PM_OPS (&pda_power_pm_ops)
+
 #else
-#define pda_power_suspend NULL
-#define pda_power_resume NULL
+#define PDA_POWER_PM_OPS NULL
 #endif /* CONFIG_PM */
 
 MODULE_ALIAS("platform:pda-power");
 
 static struct platform_driver pda_power_pdrv = {
 	.driver = {
-		.name = "pda-power",
+		.name	= "pda-power",
+		.owner	= THIS_MODULE,
+		.pm	= PDA_POWER_PM_OPS,
 	},
 	.probe = pda_power_probe,
 	.remove = pda_power_remove,
-	.suspend = pda_power_suspend,
-	.resume = pda_power_resume,
 };
 
 static int __init pda_power_init(void)
-- 
1.6.3.3
