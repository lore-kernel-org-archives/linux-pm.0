From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 1/5] ACPI: utils: Add new acpi_dev_present helper
Date: Wed, 19 Apr 2017 14:02:08 +0200
Message-ID: <20170419120212.24949-2-hdegoede@redhat.com>
References: <20170419120212.24949-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170419120212.24949-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

acpi_dev_found just iterates over all ACPI-ids and sees if one matches.
This means that it will return true for devices which are in the DSDT
but disabled (their _STA method returns 0).

For some drivers it is useful to be able to check if a certain HID
is not only present in the namespace, but also actually present as in
acpi_device_is_present() will return true for the device. For example
because if a certain device is present then the driver will want to use
an extcon or IIO ADC channel provided by that device.

This commit adds a new acpi_dev_present helper which drivers can use
to this end.

Like acpi_dev_found, acpi_dev_present take a HID as argument, but
it also has 2 extra optional arguments to only check for an ACPI
device with a specific UID and/or HRV value. This makes it more
generic and allows it to replace custom code doing similar checks
in several places.

Arguably acpi_dev_present is what acpi_dev_found should have been, but
there are too many users to just change acpi_dev_found without the risk
of breaking something.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes in v2:
-Switch to using bus_find_device() to avoid "Traversing the namespace
 over and over"
-Add optional (may be NULL / -1) uid and hrv arguments, this will
 allow this new function to replace the custom code for this in
 drivers/firmware/efi/dev-path-parser.c as well as in
 sound/soc/intel/common/sst-match-acpi.c and will allow it to be
 used to implement blacklists to avoid loading the ACPI ac / battery
 driver on systems which have a PMIC / charger acpi device with a
 native driver which offers a better (often working vs not working)
 user experience
-Dropped Mika's reviewed-by as this is almost a total rewrite
Changes in v3:
-memset the entire acpi_dev_present_info struct, this fixes
 acpi_device_id.cls not getting cleared
Changes in v4:
-Use empty initializer to zero the acpi_dev_present_info struct
Changes in v5:
-Use s64 for hrv
-Fix grammar in comment
Changes in v6:
-Drop special handling of "0" uid argument, this was intended for
 compatiblity with the code in drivers/firmware/efi/dev-path-parser.c
 so that acpi_dev_present could replace that code, but it turns out that
 acpi_dev_present is not going to be suitable to replace this, so drop this
-Some minor style fixes to the code and commit msg
---
 drivers/acpi/utils.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 ++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 22c0995..27d0dcf 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -736,6 +736,72 @@ bool acpi_dev_found(const char *hid)
 }
 EXPORT_SYMBOL(acpi_dev_found);
 
+struct acpi_dev_present_info {
+	struct acpi_device_id hid[2];
+	const char *uid;
+	s64 hrv;
+};
+
+static int acpi_dev_present_cb(struct device *dev, void *data)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+	struct acpi_dev_present_info *match = data;
+	unsigned long long hrv;
+	acpi_status status;
+
+	if (acpi_match_device_ids(adev, match->hid))
+		return 0;
+
+	if (match->uid && (!adev->pnp.unique_id ||
+	    strcmp(adev->pnp.unique_id, match->uid)))
+		return 0;
+
+	if (match->hrv == -1)
+		return 1;
+
+	status = acpi_evaluate_integer(adev->handle, "_HRV", NULL, &hrv);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	return hrv == match->hrv;
+}
+
+/**
+ * acpi_dev_present - Detect that a given ACPI device is present
+ * @hid: Hardware ID of the device.
+ * @uid: Unique ID of the device, pass NULL to not check _UID
+ * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
+ *
+ * Return %true if a matching device was present at the moment of invocation.
+ * Note that if the device is pluggable, it may since have disappeared.
+ *
+ * Note that unlike acpi_dev_found() this function checks the status
+ * of the device. So for devices which are present in the dsdt, but
+ * which are disabled (their _STA callback returns 0) this function
+ * will return false.
+ *
+ * For this function to work, acpi_bus_scan() must have been executed
+ * which happens in the subsys_initcall() subsection. Hence, do not
+ * call from a subsys_initcall() or earlier (use acpi_get_devices()
+ * instead). Calling from module_init() is fine (which is synonymous
+ * with device_initcall()).
+ */
+bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
+{
+	struct acpi_dev_present_info match = {};
+	struct device *dev;
+
+	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
+	match.uid = uid;
+	match.hrv = hrv;
+
+	dev = bus_find_device(&acpi_bus_type, NULL, &match,
+			      acpi_dev_present_cb);
+
+	return !!dev;
+}
+EXPORT_SYMBOL(acpi_dev_present);
+
 /*
  * acpi_backlight= handling, this is done here rather then in video_detect.c
  * because __setup cannot be used in modules.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ef0ae8a..b53c058 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -88,6 +88,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, u64 rev, u64 func,
 	}
 
 bool acpi_dev_found(const char *hid);
+bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
 
 #ifdef CONFIG_ACPI
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9b05886..841a8dc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -611,6 +611,11 @@ static inline bool acpi_dev_found(const char *hid)
 	return false;
 }
 
+static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
+{
+	return false;
+}
+
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
 	return false;
-- 
2.9.3

