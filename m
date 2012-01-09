From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] mmc: core: move suspend/resume to dev_pm_ops and
	add hibernation support
Date: Mon, 9 Jan 2012 14:22:49 +0800
Message-ID: <1326090169-4942-1-git-send-email-Barry.Song__30907.2356940762$1326090233$gmane$org@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: cjb@laptop.org
Cc: Bin Shi <Bin.Shi@csr.com>, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, workgroup.linux@csr.com
List-Id: linux-pm@vger.kernel.org

From: Bin Shi <Bin.Shi@csr.com>

This patch moves suspend/resume to dev_pm_ops and add hibernation support.
It was tested on CSR SiRFprimaII cortex-a9 platform. A sd partition is used
as swsusp partition.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 drivers/mmc/core/bus.c |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 6be4924..bab50f7 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -122,14 +122,14 @@ static int mmc_bus_remove(struct device *dev)
 	return 0;
 }
 
-static int mmc_bus_suspend(struct device *dev, pm_message_t state)
+static int mmc_bus_suspend(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	int ret = 0;
 
 	if (dev->driver && drv->suspend)
-		ret = drv->suspend(card, state);
+		ret = drv->suspend(card, PMSG_SUSPEND);
 	return ret;
 }
 
@@ -144,6 +144,17 @@ static int mmc_bus_resume(struct device *dev)
 	return ret;
 }
 
+static int mmc_bus_freeze(struct device *dev)
+{
+	struct mmc_driver *drv = to_mmc_driver(dev->driver);
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	int ret = 0;
+
+	if (dev->driver && drv->suspend)
+		ret = drv->suspend(card, PMSG_FREEZE);
+	return ret;
+}
+
 #ifdef CONFIG_PM_RUNTIME
 
 static int mmc_runtime_suspend(struct device *dev)
@@ -165,20 +176,23 @@ static int mmc_runtime_idle(struct device *dev)
 	return pm_runtime_suspend(dev);
 }
 
+#else /* !CONFIG_PM_RUNTIME */
+#define mmc_runtime_suspend	NULL
+#define mmc_runtime_resume	NULL
+#define mmc_runtime_idle	NULL
+#endif /* !CONFIG_PM_RUNTIME */
+
 static const struct dev_pm_ops mmc_bus_pm_ops = {
 	.runtime_suspend	= mmc_runtime_suspend,
 	.runtime_resume		= mmc_runtime_resume,
 	.runtime_idle		= mmc_runtime_idle,
+	.suspend		= mmc_bus_suspend,
+	.resume			= mmc_bus_resume,
+	.freeze			= mmc_bus_freeze,
+	.restore		= mmc_bus_resume,
+	.thaw			= mmc_bus_resume,
 };
 
-#define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
-
-#else /* !CONFIG_PM_RUNTIME */
-
-#define MMC_PM_OPS_PTR	NULL
-
-#endif /* !CONFIG_PM_RUNTIME */
-
 static struct bus_type mmc_bus_type = {
 	.name		= "mmc",
 	.dev_attrs	= mmc_dev_attrs,
@@ -186,9 +200,7 @@ static struct bus_type mmc_bus_type = {
 	.uevent		= mmc_bus_uevent,
 	.probe		= mmc_bus_probe,
 	.remove		= mmc_bus_remove,
-	.suspend	= mmc_bus_suspend,
-	.resume		= mmc_bus_resume,
-	.pm		= MMC_PM_OPS_PTR,
+	.pm		= &mmc_bus_pm_ops,
 };
 
 int mmc_register_bus(void)
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
