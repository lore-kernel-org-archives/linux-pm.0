From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/4] i2c: core: Allow getting ACPI info by index
Date: Sat, 25 Mar 2017 14:55:47 +0100
Message-ID: <20170325135550.22509-2-hdegoede@redhat.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170325135550.22509-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Modify struct i2c_acpi_lookup and i2c_acpi_fill_info() to allow
using them to get the info from a certain index in the ACPI-resource
list rather then taking the first I2cSerialBus resource.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No changes
Changes in v2:
-Increment number of found i2c busses for lookup-by-index after checking
 the acpi-resource is an i2c bus rather then before
---
 drivers/i2c/i2c-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d2402bb..f7faa99 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -112,6 +112,8 @@ struct i2c_acpi_lookup {
 	acpi_handle adapter_handle;
 	acpi_handle device_handle;
 	acpi_handle search_handle;
+	int n;
+	int index;
 	u32 speed;
 	u32 min_speed;
 };
@@ -130,6 +132,9 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
 		return 1;
 
+	if (lookup->index != -1 && lookup->n++ != lookup->index)
+		return 1;
+
 	status = acpi_get_handle(lookup->device_handle,
 				 sb->resource_source.string_ptr,
 				 &lookup->adapter_handle);
@@ -182,6 +187,7 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
+	lookup.index = -1;
 
 	ret = i2c_acpi_do_lookup(adev, &lookup);
 	if (ret)
@@ -328,6 +334,7 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 	lookup.search_handle = ACPI_HANDLE(dev);
 	lookup.min_speed = UINT_MAX;
 	lookup.info = &dummy;
+	lookup.index = -1;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     I2C_ACPI_MAX_SCAN_DEPTH,
-- 
2.9.3

