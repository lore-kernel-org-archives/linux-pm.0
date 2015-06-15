From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/8] ACPI / PM: Attach ACPI power domain only once
Date: Mon, 15 Jun 2015 12:57:30 +0300
Message-ID: <1434362256-239992-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Some devices, like MFD subdevices, share a single ACPI companion device so
that they are able to access their resources and children. However,
currently all these subdevices are attached to the ACPI power domain and
this might cause that the power methods for the companion device get called
more than once.

In order to solve this we attach the ACPI power domain only to the first
physical device that is bound to the ACPI companion device. In case of MFD
devices, this is the parent MFD device itself.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/device_pm.c |  8 ++++++++
 drivers/acpi/internal.h  |  2 ++
 drivers/acpi/scan.c      | 46 ++++++++++++++++++++++++++++++----------------
 3 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 735db11..7d0c7e9 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1103,6 +1103,14 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	if (dev->pm_domain)
 		return -EEXIST;
 
+	/*
+	 * Only attach the power domain to the first device if the
+	 * companion is shared by multiple. This is to prevent doing power
+	 * management twice.
+	 */
+	if (!acpi_device_is_first_physical_node(adev, dev))
+		return -EBUSY;
+
 	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
 	dev->pm_domain = &acpi_general_pm_domain;
 	if (power_on) {
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ba4a61e..c26a951 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -96,6 +96,8 @@ void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
 bool acpi_device_is_present(struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
+bool acpi_device_is_first_physical_node(struct acpi_device *adev,
+					const struct device *dev);
 
 /* --------------------------------------------------------------------------
                                   Power Resource
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 03141aa..37f8f74 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -223,6 +223,35 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 	return len;
 }
 
+/**
+ * acpi_device_is_first_physical_node - Is given dev first physical node
+ * @adev: ACPI companion device
+ * @dev: Physical device to check
+ *
+ * Function checks if given @dev is the first physical devices attached to
+ * the ACPI companion device. This distinction is needed in some cases
+ * where the same companion device is shared between many physical devices.
+ *
+ * Note that the caller have to provide valid @adev pointer.
+ */
+bool acpi_device_is_first_physical_node(struct acpi_device *adev,
+					const struct device *dev)
+{
+	bool ret = false;
+
+	mutex_lock(&adev->physical_node_lock);
+	if (!list_empty(&adev->physical_node_list)) {
+		const struct acpi_device_physical_node *node;
+
+		node = list_first_entry(&adev->physical_node_list,
+					struct acpi_device_physical_node, node);
+		ret = node->dev == dev;
+	}
+	mutex_unlock(&adev->physical_node_lock);
+
+	return ret;
+}
+
 /*
  * acpi_companion_match() - Can we match via ACPI companion device
  * @dev: Device in question
@@ -247,7 +276,6 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 static struct acpi_device *acpi_companion_match(const struct device *dev)
 {
 	struct acpi_device *adev;
-	struct mutex *physical_node_lock;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -256,21 +284,7 @@ static struct acpi_device *acpi_companion_match(const struct device *dev)
 	if (list_empty(&adev->pnp.ids))
 		return NULL;
 
-	physical_node_lock = &adev->physical_node_lock;
-	mutex_lock(physical_node_lock);
-	if (list_empty(&adev->physical_node_list)) {
-		adev = NULL;
-	} else {
-		const struct acpi_device_physical_node *node;
-
-		node = list_first_entry(&adev->physical_node_list,
-					struct acpi_device_physical_node, node);
-		if (node->dev != dev)
-			adev = NULL;
-	}
-	mutex_unlock(physical_node_lock);
-
-	return adev;
+	return acpi_device_is_first_physical_node(adev, dev) ? adev : NULL;
 }
 
 static int __acpi_device_uevent_modalias(struct acpi_device *adev,
-- 
2.1.4

