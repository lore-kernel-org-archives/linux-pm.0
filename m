From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 1/6] Introduce acpi_match_device_id().
Date: Fri, 28 Sep 2012 15:38:30 +0800
Message-ID: <1348817910.10877.321.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>From 72df5d1f51fb27a4ba7f70a3b07df759d32b8288 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 27 Sep 2012 15:11:55 +0800
Subject: [RFC PATCH 1/6] Introduce acpi_match_device_id().

This API is used to check if a device id string is compatible
with an ACPI device,
either PNP id exported via _HID or compatible ids exported
via _CID control method.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c     |   22 ++++++++++++++++++++++
 include/acpi/acpi_bus.h |    6 ++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d1ecca2..936a7c9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -312,6 +312,28 @@ int acpi_match_device_ids(struct acpi_device *device,
 }
 EXPORT_SYMBOL(acpi_match_device_ids);
 
+int acpi_match_device_id(const struct device *dev, const char *id)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+	struct acpi_device *device;
+	struct acpi_hardware_id *hwid;
+	acpi_status status;
+
+	if (!handle || !id)
+		return -ENODEV;
+
+	status = acpi_bus_get_device(handle, &device);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	list_for_each_entry(hwid, &device->pnp.ids, list)
+		if (!strcmp(id, hwid->id))
+			return 0;
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(acpi_match_device_id);
+
 static void acpi_free_ids(struct acpi_device *device)
 {
 	struct acpi_hardware_id *id, *tmp;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bde976e..8b5b124 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -378,6 +378,7 @@ int acpi_bus_start(struct acpi_device *device);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
+int acpi_match_device_id(const struct device *, const char *);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
@@ -448,6 +449,11 @@ static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
+static inline int acpi_match_device_id(const struct device *device,
+					const char *name)
+{
+	return -ENODEV;
+}
 
 #endif				/* CONFIG_ACPI */
 
-- 
1.7.7.6
