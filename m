From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 15/19] Driver Core: Rework platform
	suspend/resume, print warning
Date: Thu, 11 Jun 2009 22:00:55 +0000 (UTC)
Message-ID: <S4AoGnG.A.D7H.mZXMKB__12247.8463025347$1244757655$gmane$org@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks the platform driver code for legacy
suspend and resume to avoid installing callbacks in
struct device_driver. A warning is also added telling
users to update the platform driver to use dev_pm_ops.

The functions platform_legacy_suspend()/resume() directly
call suspend and resume callbacks in struct platform_driver
instead of wrapping things in platform_drv_suspend()/resume().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/platform.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8b4708e..ead3f64 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -469,22 +469,6 @@ static void platform_drv_shutdown(struct device *_dev)
 	drv->shutdown(dev);
 }
 
-static int platform_drv_suspend(struct device *_dev, pm_message_t state)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-
-	return drv->suspend(dev, state);
-}
-
-static int platform_drv_resume(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-
-	return drv->resume(dev);
-}
-
 /**
  * platform_driver_register
  * @drv: platform driver structure
@@ -498,10 +482,10 @@ int platform_driver_register(struct platform_driver *drv)
 		drv->driver.remove = platform_drv_remove;
 	if (drv->shutdown)
 		drv->driver.shutdown = platform_drv_shutdown;
-	if (drv->suspend)
-		drv->driver.suspend = platform_drv_suspend;
-	if (drv->resume)
-		drv->driver.resume = platform_drv_resume;
+	if (drv->suspend || drv->resume)
+		pr_warning("Platform driver '%s' needs updating - please use "
+			"dev_pm_ops\n", drv->driver.name);
+
 	return driver_register(&drv->driver);
 }
 EXPORT_SYMBOL_GPL(platform_driver_register);
@@ -633,10 +617,12 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 
 static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
 {
+	struct platform_driver *pdrv = to_platform_driver(dev->driver);
+	struct platform_device *pdev = to_platform_device(dev);
 	int ret = 0;
 
-	if (dev->driver && dev->driver->suspend)
-		ret = dev->driver->suspend(dev, mesg);
+	if (dev->driver && pdrv->suspend)
+		ret = pdrv->suspend(pdev, mesg);
 
 	return ret;
 }
@@ -667,10 +653,12 @@ static int platform_legacy_resume_early(struct device *dev)
 
 static int platform_legacy_resume(struct device *dev)
 {
+	struct platform_driver *pdrv = to_platform_driver(dev->driver);
+	struct platform_device *pdev = to_platform_device(dev);
 	int ret = 0;
 
-	if (dev->driver && dev->driver->resume)
-		ret = dev->driver->resume(dev);
+	if (dev->driver && pdrv->resume)
+		ret = pdrv->resume(pdev);
 
 	return ret;
 }
-- 
1.5.2.4
