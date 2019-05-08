From: Nick Crews <ncrews@chromium.org>
Subject: [PATCH v9 2/2] platform/chrome: wilco_ec: Add charging config device
Date: Wed,  8 May 2019 14:38:26 -0600
Message-ID: <20190508203826.120741-2-ncrews@chromium.org>
References: <20190508203826.120741-1-ncrews@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508203826.120741-1-ncrews@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dlaurie@chromium.org, lamzin@google.com, bartfab@google.com, derat@google.com, dtor@google.com, sjg@chromium.org, jchwong@chromium.org, tbroch@chromium.org, Nick Crews <ncrews@chromium.org>
List-Id: linux-pm@vger.kernel.org

Add a device to control the charging algorithm used on Wilco devices,
which will be picked up by the drivers/power/supply/wilco-charger.c
driver. See Documentation/ABI/testing/sysfs-class-power-wilco for the
userspace interface and other info.

Signed-off-by: Nick Crews <ncrews@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v9 changes:
-Split up adding the driver and adding the device.
v8 changes:
-Several documentation and comment fixups.
v6 changes:
-Remove CHARGE_MODE_ILLEGAL from enum charge_mode. It's not a
 public type, and error checking could be performed in other ways.
-Split up the commit so properties are added in a first commit
-Move CONFIG_CHARGER_WILCO to the power/supply Kconfig
-Use PTR_ERR_OR_ZERO() macro in probe()
v5 changes:
-Remove OP_SYNC, it has no immediate use case.
-Merge properties.h into wilco-ec.h
-Remove enum get_set_sync_op from the public interface,
 since without OP_SYNC they are irrelevant.
-Fix Kconfigs and Makefiles so they actually work
 with the v4 changes
-Tweak some formatting, spacing, and comments
-Fix validation of charge_type so illegal values
 can't be set. Before negative error codes were
 accidentally getting casted to positive numbers
-Remove more unneeded parentheses.
v4 changes:
-Use put_unaligned_le32() to store PID in request.
-Move implementation from
 drivers/platform/chrome/wilco_ec/charge_config.c to
 drivers/power/supply/wilco_charger.c
-Move drivers/platform/chrome/wilco_ec/properties.h to
 include/linux/platform_data/wilco-ec-properties.h
-Remove parentheses in switch statement in psp_val_to_charge_mode()
-Check for any negatvie return code from psp_val_to_charge_mode()
 instead of just -EINVAL so its less brittle
-Tweak comments in wilco-ec-properties.h
v3 changes:
-Add this changelog
-Fix commit message tags
v2 changes:
-Update Documentation to say KernelVersion 5.2
-Update Documentation to explain Trickle mode better.
-rename things from using *PCC* to *CHARGE*
-Split up conversions between POWER_SUPPLY_PROP_CHARGE_TYPE values
and Wilco EC codes
-Use devm_ flavor of power_supply_register(), which simplifies things
-Add extra error checking on property messages received from the EC
-Fix bug in memcpy() calls in properties.c
-Refactor fill_property_id()
-Add valid input checks to charge_type
-Properly convert charge_type when get()ting

 drivers/platform/chrome/wilco_ec/core.c | 13 +++++++++++++
 include/linux/platform_data/wilco-ec.h  |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..a8e3ef59f4ea 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,20 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child device to be found by charger config driver. */
+	ec->charger_pdev = platform_device_register_data(dev, "wilco-charger",
+							 PLATFORM_DEVID_AUTO,
+							 NULL, 0);
+	if (IS_ERR(ec->charger_pdev)) {
+		dev_err(dev, "Failed to create charger platform device\n");
+		ret = PTR_ERR(ec->charger_pdev);
+		goto unregister_rtc;
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +114,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->charger_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 50a21bd5fd44..66d9f177bec2 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -32,6 +32,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @charger_pdev: Child platform_device used by the charger config sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -43,6 +44,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *charger_pdev;
 };
 
 /**
-- 
2.20.1
