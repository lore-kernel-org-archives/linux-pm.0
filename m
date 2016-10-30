From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Resend][PATCH v6 1/5] driver core: Add a wrapper around __device_release_driver()
Date: Sun, 30 Oct 2016 17:29:35 +0100
Message-ID: <2685245.AVXM0tKKn5@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <11468990.WB1J8sxXpS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54865 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1757041AbcJ3QZ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Oct 2016 12:25:56 -0400
In-Reply-To: <11468990.WB1J8sxXpS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an internal wrapper around __device_release_driver() that will
acquire device locks and do the necessary checks before calling it.

The next patch will make use of it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/dd.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -811,6 +811,22 @@ static void __device_release_driver(stru
 	}
 }
 
+static void device_release_driver_internal(struct device *dev,
+					   struct device_driver *drv,
+					   struct device *parent)
+{
+	if (parent)
+		device_lock(parent);
+
+	device_lock(dev);
+	if (!drv || drv == dev->driver)
+		__device_release_driver(dev);
+
+	device_unlock(dev);
+	if (parent)
+		device_unlock(parent);
+}
+
 /**
  * device_release_driver - manually detach device from driver.
  * @dev: device.
@@ -825,9 +841,7 @@ void device_release_driver(struct device
 	 * within their ->remove callback for the same device, they
 	 * will deadlock right here.
 	 */
-	device_lock(dev);
-	__device_release_driver(dev);
-	device_unlock(dev);
+	device_release_driver_internal(dev, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(device_release_driver);
 
@@ -852,15 +866,7 @@ void driver_detach(struct device_driver
 		dev = dev_prv->device;
 		get_device(dev);
 		spin_unlock(&drv->p->klist_devices.k_lock);
-
-		if (dev->parent)	/* Needed for USB */
-			device_lock(dev->parent);
-		device_lock(dev);
-		if (dev->driver == drv)
-			__device_release_driver(dev);
-		device_unlock(dev);
-		if (dev->parent)
-			device_unlock(dev->parent);
+		device_release_driver_internal(dev, drv, dev->parent);
 		put_device(dev);
 	}
 }
