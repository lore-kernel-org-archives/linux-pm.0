From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 1/5] driver core: Add a wrapper around __device_release_driver()
Date: Thu, 14 Jan 2016 02:53:28 +0100
Message-ID: <3655139.ja2psWCAU6@vostro.rjw.lan>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <2576341.476ZsjkPgF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2576341.476ZsjkPgF@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an internal wrapper around __device_release_driver() that will
acquire device locks and do the necessary checks before calling it.

The next patch will make use of it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/dd.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -776,6 +776,22 @@ static void __device_release_driver(stru
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
@@ -790,9 +806,7 @@ void device_release_driver(struct device
 	 * within their ->remove callback for the same device, they
 	 * will deadlock right here.
 	 */
-	device_lock(dev);
-	__device_release_driver(dev);
-	device_unlock(dev);
+	device_release_driver_internal(dev, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(device_release_driver);
 
@@ -817,15 +831,7 @@ void driver_detach(struct device_driver
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
