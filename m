From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: ARM: sa1111: Drop suspend and resume bus type callbacks
Date: Tue, 26 Sep 2017 22:47:10 +0200
Message-ID: <2654085.Tx1JnNWXkX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59822 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030665AbdIZU4Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2017 16:56:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Linux PM <linux-pm@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

None of the sa1111 drivers in the tree implements the suspend and
resume callbacks from struct sa1111_driver, so drop them and drop
the corresponding callbacks from sa1111_bus_type.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/common/sa1111.c               |   24 ------------------------
 arch/arm/include/asm/hardware/sa1111.h |    2 --
 2 files changed, 26 deletions(-)

Index: linux-pm/arch/arm/include/asm/hardware/sa1111.h
===================================================================
--- linux-pm.orig/arch/arm/include/asm/hardware/sa1111.h
+++ linux-pm/arch/arm/include/asm/hardware/sa1111.h
@@ -430,8 +430,6 @@ struct sa1111_driver {
 	unsigned int		devid;
 	int (*probe)(struct sa1111_dev *);
 	int (*remove)(struct sa1111_dev *);
-	int (*suspend)(struct sa1111_dev *, pm_message_t);
-	int (*resume)(struct sa1111_dev *);
 	void (*shutdown)(struct sa1111_dev *);
 };
 
Index: linux-pm/arch/arm/common/sa1111.c
===================================================================
--- linux-pm.orig/arch/arm/common/sa1111.c
+++ linux-pm/arch/arm/common/sa1111.c
@@ -1379,28 +1379,6 @@ static int sa1111_match(struct device *_
 	return !!(dev->devid & drv->devid);
 }
 
-static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
-{
-	struct sa1111_dev *sadev = to_sa1111_device(dev);
-	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
-	int ret = 0;
-
-	if (drv && drv->suspend)
-		ret = drv->suspend(sadev, state);
-	return ret;
-}
-
-static int sa1111_bus_resume(struct device *dev)
-{
-	struct sa1111_dev *sadev = to_sa1111_device(dev);
-	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
-	int ret = 0;
-
-	if (drv && drv->resume)
-		ret = drv->resume(sadev);
-	return ret;
-}
-
 static void sa1111_bus_shutdown(struct device *dev)
 {
 	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
@@ -1436,8 +1414,6 @@ struct bus_type sa1111_bus_type = {
 	.match		= sa1111_match,
 	.probe		= sa1111_bus_probe,
 	.remove		= sa1111_bus_remove,
-	.suspend	= sa1111_bus_suspend,
-	.resume		= sa1111_bus_resume,
 	.shutdown	= sa1111_bus_shutdown,
 };
 EXPORT_SYMBOL(sa1111_bus_type);
