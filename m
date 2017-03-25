From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/4] i2c: core: Add new i2c_acpi_new_device helper function
Date: Sat, 25 Mar 2017 14:55:48 +0100
Message-ID: <20170325135550.22509-3-hdegoede@redhat.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170325135550.22509-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

By default the i2c subsys creates an i2c-client for the first I2cSerialBus
resource of an acpi_device, but some acpi_devices have multiple
I2cSerialBus resources and the driver may need access to the others.

This commit adds a new i2c_acpi_new_device function which can be used by
drivers to create an i2c-client for any (other) I2cSerialBus resource of
an acpi_device.

Note that the other resources may even be on a different i2c bus, so just
retrieving the client address is not enough.

Here is an example DSDT excerpt from such a device:

Device (WIDR)
{
    Name (_HID, "INT33FE" /* XPOWER Battery Device */)
    Name (_CID, "INT33FE" /* XPOWER Battery Device */)
    Name (_DDN, "WC PMIC Battery Device")
<snip>
    Name (RBUF, ResourceTemplate ()
    {
        I2cSerialBusV2 (0x005E, ControllerInitiated, 0x000186A0,
            AddressingMode7Bit, "\\_SB.PCI0.I2C7",
            0x00, ResourceConsumer, , Exclusive,
            )
        I2cSerialBusV2 (0x0036, ControllerInitiated, 0x000186A0,
            AddressingMode7Bit, "\\_SB.PCI0.I2C1",
            0x00, ResourceConsumer, , Exclusive,
            )
        I2cSerialBusV2 (0x0022, ControllerInitiated, 0x00061A80,
            AddressingMode7Bit, "\\_SB.PCI0.I2C1",
            0x00, ResourceConsumer, , Exclusive,
            )
        I2cSerialBusV2 (0x0054, ControllerInitiated, 0x00061A80,
            AddressingMode7Bit, "\\_SB.PCI0.I2C1",
            0x00, ResourceConsumer, , Exclusive,
            )
        GpioInt (Level, ActiveLow, Exclusive, PullNone, 0x0000,
            "\\_SB.PCI0.I2C7.PMI5", 0x00, ResourceConsumer, ,
            )
            {   // Pin list
        0x0012
            }
        GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
            "\\_SB.GPO1", 0x00, ResourceConsumer, ,
            )
            {   // Pin list
        0x0005
            }
        GpioInt (Level, ActiveLow, Exclusive, PullNone, 0x0000,
            "\\_SB.PCI0.I2C7.PMI5", 0x00, ResourceConsumer, ,
            )
            {   // Pin list
        0x0013
            }
    })
    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
    {
        Return (RBUF) /* \_SB_.PCI0.I2C7.WIDR.RBUF */
    }
<snip>
}

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v2:
-No changes
Changes in v3:
Added example DSDT snippet to the commit msg
---
 drivers/i2c/i2c-core.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  5 +++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f7faa99..062b480 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -421,6 +421,53 @@ static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
 static struct notifier_block i2c_acpi_notifier = {
 	.notifier_call = i2c_acpi_notify,
 };
+
+/**
+ * i2c_acpi_new_device - Create i2c client for the Nth I2cSerialBus resource
+ * @dev:     Device owning the acpi resources to get the client from
+ * @index:   Index of acpi resource to get
+ *
+ * By default the i2c subsys creates an i2c-client for the first I2cSerialBus
+ * resource of an acpi_device, but some acpi_devices have multiple
+ * I2cSerialBus resources and the driver may need access to the others.
+ * This function can be used by drivers to create an i2c-client for other
+ * I2cSerialBus resources in the Current Resource Settings table.
+ *
+ * Returns a pointer to the new i2c-client, or NULL if the adapter is not found.
+ */
+struct i2c_client *i2c_acpi_new_device(struct device *dev, int index)
+{
+	struct i2c_acpi_lookup lookup;
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct acpi_device *adev;
+	LIST_HEAD(resource_list);
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return NULL;
+
+	memset(&info, 0, sizeof(info));
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.info = &info;
+	lookup.device_handle = acpi_device_handle(adev);
+	lookup.index = index;
+
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     i2c_acpi_fill_info, &lookup);
+	acpi_dev_free_resource_list(&resource_list);
+
+	if (ret < 0 || !info.addr)
+		return NULL;
+
+	adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
+	if (!adapter)
+		return NULL;
+
+	return i2c_new_device(adapter, &info);
+}
+EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
 #else /* CONFIG_ACPI */
 static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
 extern struct notifier_block i2c_acpi_notifier;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 6b18352..369ebfa 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -824,11 +824,16 @@ static inline const struct of_device_id
 
 #if IS_ENABLED(CONFIG_ACPI)
 u32 i2c_acpi_find_bus_speed(struct device *dev);
+struct i2c_client *i2c_acpi_new_device(struct device *dev, int index);
 #else
 static inline u32 i2c_acpi_find_bus_speed(struct device *dev)
 {
 	return 0;
 }
+static inline struct i2c_client *i2c_acpi_new_device(struct device *d, int i)
+{
+	return NULL;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* _LINUX_I2C_H */
-- 
2.9.3

