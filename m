From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 07/07] pm: remove platform device
	suspend_late()/resume_early()
Date: Fri, 05 Jun 2009 16:55:42 +0900
Message-ID: <20090605075542.14756.99380.sendpatchset__13621.7602332637$1244189717$gmane$org@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the legacy platform driver power management
callbacks ->suspend_late() and ->resume_early() since all in-tree
users have been migrated to dev_pm_ops.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 drivers/base/platform.c         |   36 ------------------------------------
 include/linux/platform_device.h |    2 --
 2 files changed, 38 deletions(-)

--- 0001/drivers/base/platform.c
+++ work/drivers/base/platform.c	2009-06-01 15:27:57.000000000 +0900
@@ -642,30 +642,6 @@ static int platform_legacy_suspend(struc
 	return ret;
 }
 
-static int platform_legacy_suspend_late(struct device *dev, pm_message_t mesg)
-{
-	struct platform_driver *pdrv = to_platform_driver(dev->driver);
-	struct platform_device *pdev = to_platform_device(dev);
-	int ret = 0;
-
-	if (dev->driver && pdrv->suspend_late)
-		ret = pdrv->suspend_late(pdev, mesg);
-
-	return ret;
-}
-
-static int platform_legacy_resume_early(struct device *dev)
-{
-	struct platform_driver *pdrv = to_platform_driver(dev->driver);
-	struct platform_device *pdev = to_platform_device(dev);
-	int ret = 0;
-
-	if (dev->driver && pdrv->resume_early)
-		ret = pdrv->resume_early(pdev);
-
-	return ret;
-}
-
 static int platform_legacy_resume(struct device *dev)
 {
 	int ret = 0;
@@ -726,8 +702,6 @@ static int platform_pm_suspend_noirq(str
 	if (drv->pm) {
 		if (drv->pm->suspend_noirq)
 			ret = drv->pm->suspend_noirq(dev);
-	} else {
-		ret = platform_legacy_suspend_late(dev, PMSG_SUSPEND);
 	}
 
 	return ret;
@@ -762,8 +736,6 @@ static int platform_pm_resume_noirq(stru
 	if (drv->pm) {
 		if (drv->pm->resume_noirq)
 			ret = drv->pm->resume_noirq(dev);
-	} else {
-		ret = platform_legacy_resume_early(dev);
 	}
 
 	return ret;
@@ -809,8 +781,6 @@ static int platform_pm_freeze_noirq(stru
 	if (drv->pm) {
 		if (drv->pm->freeze_noirq)
 			ret = drv->pm->freeze_noirq(dev);
-	} else {
-		ret = platform_legacy_suspend_late(dev, PMSG_FREEZE);
 	}
 
 	return ret;
@@ -845,8 +815,6 @@ static int platform_pm_thaw_noirq(struct
 	if (drv->pm) {
 		if (drv->pm->thaw_noirq)
 			ret = drv->pm->thaw_noirq(dev);
-	} else {
-		ret = platform_legacy_resume_early(dev);
 	}
 
 	return ret;
@@ -881,8 +849,6 @@ static int platform_pm_poweroff_noirq(st
 	if (drv->pm) {
 		if (drv->pm->poweroff_noirq)
 			ret = drv->pm->poweroff_noirq(dev);
-	} else {
-		ret = platform_legacy_suspend_late(dev, PMSG_HIBERNATE);
 	}
 
 	return ret;
@@ -917,8 +883,6 @@ static int platform_pm_restore_noirq(str
 	if (drv->pm) {
 		if (drv->pm->restore_noirq)
 			ret = drv->pm->restore_noirq(dev);
-	} else {
-		ret = platform_legacy_resume_early(dev);
 	}
 
 	return ret;
--- 0002/include/linux/platform_device.h
+++ work/include/linux/platform_device.h	2009-06-01 15:27:57.000000000 +0900
@@ -60,8 +60,6 @@ struct platform_driver {
 	int (*remove)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
-	int (*suspend_late)(struct platform_device *, pm_message_t state);
-	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 	struct platform_device_id *id_table;
