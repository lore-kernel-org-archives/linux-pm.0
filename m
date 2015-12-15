From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [RFC] i2c: Prevent runtime suspend of parent during adapter registration
Date: Tue, 15 Dec 2015 14:12:56 +0200
Message-ID: <1450181576-878-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64820 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964921AbbLOMND (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 07:13:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

If runtime PM of parent device is enabled before it registers the I2C
adapter there can be unnecessary runtime suspend during adapter device
registration. This can happen when adapter is registered from parent's
probe and if parent device is initially active platform device.

In that case power.usage_count of parent device is zero and
pm_runtime_get()/pm_runtime_put() cycle during probe could put the
parent into runtime suspend. This happens when the i2c_register_adapter()
calls the device_register():

i2c_register_adapter
  device_register
    device_add
      bus_probe_device
        device_initial_probe
          __device_attach
            if (dev->parent) pm_runtime_get_sync(dev->parent)
            ...
            if (dev->parent) pm_runtime_put(dev->parent)

After that i2c_register_adapter() continues registering I2C slave
devices. In case slave device probe does I2C transfers the parent will
resume again and thus get a needless runtime suspend/resume cycle during
adapter registration.

Prevent this while retaining the runtime PM status of parent by only
incrementing/decrementing parent device power usage count during I2C
adapter registration. That makes sure there won't be spurious runtime PM
status changes for parent's probe and lets the driver core to idle the
device after probe finishes.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
I noticed this with i2c-designware-platdrv.c which started to do so
after commit 36d48fb5766a ("i2c: designware-platdrv: enable RuntimePM
before registering to the core"). I guess the same could happen also
with a few other I2C drivers that enable runtime PM similar way. For
instance i2c-at91.c, i2c-cadence.c, i2c-hix5hd2.c and i2c-qup.c.
That made me thinking if issue might be best to handle in i2c-core.c.

Device core drivers/base/dd.c: driver_probe_device() or
drivers/base/platform.c: platform_drv_probe() could be other
alternatives but that would cause a regression to a driver that
purposively tries to suspend the device in its probe().
---
 drivers/i2c/i2c-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ba8eb087f224..4f8b5c80cf1e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1556,6 +1556,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
+	if (adap->dev.parent)
+		pm_runtime_get_noresume(adap->dev.parent);
 	res = device_register(&adap->dev);
 	if (res)
 		goto out_list;
@@ -1617,6 +1619,8 @@ exit_recovery:
 	mutex_lock(&core_lock);
 	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_new_adapter);
 	mutex_unlock(&core_lock);
+	if (adap->dev.parent)
+		pm_runtime_put_noidle(adap->dev.parent);
 
 	return 0;
 
@@ -1624,6 +1628,8 @@ out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
 	mutex_unlock(&core_lock);
+	if (adap->dev.parent)
+		pm_runtime_put_noidle(adap->dev.parent);
 	return res;
 }
 
-- 
2.6.2

