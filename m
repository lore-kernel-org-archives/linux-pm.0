From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/5] ds2760: switch to new dev_pm_ops
Date: Wed,  5 Aug 2009 20:29:29 +0200
Message-ID: <1249496971-9019-3-git-send-email-daniel__28435.1782677279$1249507275$gmane$org@caiaq.de>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1249496971-9019-2-git-send-email-daniel@caiaq.de>
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
Cc: Matt Reimer <mreimer@vpop.net>, linux-pm@lists.linux-foundation.org, Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>, Daniel Mack <daniel@caiaq.de>, Anton Vorontsov <cbou@mail.ru>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>
Cc: Matt Reimer <mreimer@vpop.net>
Cc: Anton Vorontsov <cbou@mail.ru>
---
 drivers/power/ds2760_battery.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/power/ds2760_battery.c b/drivers/power/ds2760_battery.c
index ca43b1c..3c9d8cd 100644
--- a/drivers/power/ds2760_battery.c
+++ b/drivers/power/ds2760_battery.c
@@ -557,19 +557,18 @@ static int ds2760_battery_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_PM
 
-static int ds2760_battery_suspend(struct platform_device *pdev,
-				  pm_message_t state)
+static int ds2760_battery_suspend(struct device *dev)
 {
-	struct ds2760_device_info *di = platform_get_drvdata(pdev);
+	struct ds2760_device_info *di = dev_get_drvdata(dev);
 
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
 
 	return 0;
 }
 
-static int ds2760_battery_resume(struct platform_device *pdev)
+static int ds2760_battery_resume(struct device *dev)
 {
-	struct ds2760_device_info *di = platform_get_drvdata(pdev);
+	struct ds2760_device_info *di = dev_get_drvdata(dev);
 
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
 	power_supply_changed(&di->bat);
@@ -580,23 +579,29 @@ static int ds2760_battery_resume(struct platform_device *pdev)
 	return 0;
 }
 
-#else
+static struct dev_pm_ops ds2760_battery_pm_ops = {
+	.suspend        = ds2760_battery_suspend,
+	.freeze		= ds2760_battery_suspend,
+	.resume         = ds2760_battery_resume,
+	.thaw		= ds2760_battery_resume,
+};
 
-#define ds2760_battery_suspend NULL
-#define ds2760_battery_resume NULL
+#define DS2760_PM_OPS (&ds2760_battery_pm_ops)
 
+#else
+#define DS2760_PM_OPS NULL
 #endif /* CONFIG_PM */
 
 MODULE_ALIAS("platform:ds2760-battery");
 
 static struct platform_driver ds2760_battery_driver = {
 	.driver = {
-		.name = "ds2760-battery",
+		.owner	= THIS_MODULE,
+		.name	= "ds2760-battery",
+		.pm	= DS2760_PM_OPS,
 	},
 	.probe	  = ds2760_battery_probe,
 	.remove   = ds2760_battery_remove,
-	.suspend  = ds2760_battery_suspend,
-	.resume	  = ds2760_battery_resume,
 };
 
 static int __init ds2760_battery_init(void)
-- 
1.6.3.3
