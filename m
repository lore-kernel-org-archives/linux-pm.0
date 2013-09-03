From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 14/27] pci-acpi: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:02 +0800
Message-ID: <1378168335-22556-15-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14642 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759206Ab3ICAbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:33 -0400
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
in drivers/pci/pci-acpi.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7c29ee4..513404f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -181,7 +181,6 @@ static bool acpi_pci_power_manageable(struct pci_dev *dev)
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
-	acpi_handle tmp;
 	static const u8 state_conv[] = {
 		[PCI_D0] = ACPI_STATE_D0,
 		[PCI_D1] = ACPI_STATE_D1,
@@ -192,7 +191,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	int error = -EINVAL;
 
 	/* If the ACPI device has _EJ0, ignore the device */
-	if (!handle || ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
+	if (!handle || acpi_has_method(handle, "_EJ0"))
 		return -ENODEV;
 
 	switch (state) {
-- 
1.8.1.2

