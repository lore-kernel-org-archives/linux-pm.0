From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Prevent runtime suspend during adapter registration
Date: Thu, 11 Feb 2016 16:36:03 +0200
Message-ID: <1455201363-3278-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

There can be unnecessary runtime suspend-resume cycle during
i2c-designware-platdrv probe when it registers the I2C adapter device. This
happens because i2c-designware-platdrv is set to initially active platform
device in its probe function and is a parent of I2C adapter.

In that case power.usage_count of i2c-designware device is zero and
pm_runtime_get()/pm_runtime_put() cycle during probe could put it into
runtime suspend. This happens when the i2c_register_adapter() calls the
device_register():

i2c_register_adapter
  device_register
    device_add
      bus_probe_device
        device_initial_probe
          __device_attach
            if (dev->parent) pm_runtime_get_sync(dev->parent)
            ...
            if (dev->parent) pm_runtime_put(dev->parent)

After that the i2c_register_adapter() continues registering I2C slave
devices. In case slave device probe does I2C transfers the parent will
resume again and thus get a needless runtime suspend/resume cycle during
adapter registration.

Prevent this while retaining the runtime PM status of i2c-designware by
only incrementing/decrementing device power usage count during I2C
adapter registration. That makes sure there won't be spurious runtime PM
status changes and lets the driver core to idle the device after probe
finishes.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
I sent earlier an RFC doing the same in i2c-core because it looked a few
other I2C bus drivers might benefit too. However, as Alan pointed, it's
bad form to do PM on your parent:
http://www.spinics.net/lists/linux-i2c/msg22587.html

After hacking a bit with PM in i2c-designware-pcidrv.c I can say this is
only for i2c-designware-platdrv case. Runtime PM settings are a little
different between platform and PCI devices. For instance runtime PM is
enabled by default for PCI devices but forbidded and there seems be no
reason to move runtime PM calls in i2c_dw_pci_probe().

Anyway, I decided to put PM usage count increment/decrement calls to
i2c-designware-core.c: i2c_dw_probe() because change lines are more
clear there, are more future proof and don't harm PCI case.
---
 drivers/i2c/busses/i2c-designware-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 10fbd6d841e0..dfe35087b40d 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -883,9 +883,17 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 		return r;
 	}
 
+	/*
+	 * Increment PM usage count during adapter registration in order to
+	 * avoid possible spurious runtime suspend when adapter device is
+	 * registered to the device core and immediate resume in case bus has
+	 * registered I2C slaves that do I2C transfers in their probe.
+	 */
+	pm_runtime_get_noresume(dev->dev);
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
 		dev_err(dev->dev, "failure adding adapter: %d\n", r);
+	pm_runtime_put_noidle(dev->dev);
 
 	return r;
 }
-- 
2.7.0
