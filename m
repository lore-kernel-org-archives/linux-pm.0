From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 20/27] pnpacpi: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:08 +0800
Message-ID: <1378168335-22556-21-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42031 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759251Ab3ICAbi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:38 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/pnp/pnpacpi/core.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pnp/pnpacpi/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 34049b0..747826d 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -239,8 +239,6 @@ static char *__init pnpacpi_get_id(struct acpi_device *device)
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
-	acpi_handle temp = NULL;
-	acpi_status status;
 	struct pnp_dev *dev;
 	char *pnpid;
 	struct acpi_hardware_id *id;
@@ -253,8 +251,7 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	 * If a PnPacpi device is not present , the device
 	 * driver should not be loaded.
 	 */
-	status = acpi_get_handle(device->handle, "_CRS", &temp);
-	if (ACPI_FAILURE(status))
+	if (!acpi_has_method(device->handle, "_CRS"))
 		return 0;
 
 	pnpid = pnpacpi_get_id(device);
@@ -271,16 +268,14 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	dev->data = device;
 	/* .enabled means the device can decode the resources */
 	dev->active = device->status.enabled;
-	status = acpi_get_handle(device->handle, "_SRS", &temp);
-	if (ACPI_SUCCESS(status))
+	if (acpi_has_method(device->handle, "_SRS"))
 		dev->capabilities |= PNP_CONFIGURABLE;
 	dev->capabilities |= PNP_READ;
 	if (device->flags.dynamic_status && (dev->capabilities & PNP_CONFIGURABLE))
 		dev->capabilities |= PNP_WRITE;
 	if (device->flags.removable)
 		dev->capabilities |= PNP_REMOVABLE;
-	status = acpi_get_handle(device->handle, "_DIS", &temp);
-	if (ACPI_SUCCESS(status))
+	if (acpi_has_method(device->handle, "_DIS"))
 		dev->capabilities |= PNP_DISABLE;
 
 	if (strlen(acpi_device_name(device)))
-- 
1.8.1.2

