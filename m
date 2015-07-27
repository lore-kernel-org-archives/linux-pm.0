From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 2/8] ACPI / PM: Attach ACPI power domain only once
Date: Mon, 27 Jul 2015 18:03:57 +0300
Message-ID: <1438009443-55317-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32263 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881AbbG0PE3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jul 2015 11:04:29 -0400
In-Reply-To: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
index 717afcd..08dc3ec 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1123,6 +1123,14 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
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
index 4683a96..f6aefe9 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -97,6 +97,8 @@ void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
 bool acpi_device_is_present(struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
+bool acpi_device_is_first_physical_node(struct acpi_device *adev,
+					const struct device *dev);
 
 /* --------------------------------------------------------------------------
                                   Power Resource
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ec25635..89ff6d2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -226,6 +226,35 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
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
@@ -250,7 +279,6 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 static struct acpi_device *acpi_companion_match(const struct device *dev)
 {
 	struct acpi_device *adev;
-	struct mutex *physical_node_lock;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -259,21 +287,7 @@ static struct acpi_device *acpi_companion_match(const struct device *dev)
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
2.4.6

