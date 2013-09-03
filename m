From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 13/27] acpi_pcihp: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:01 +0800
Message-ID: <1378168335-22556-14-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41183 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447Ab3ICAbc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:32 -0400
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
in drivers/pci/hotplug/acpi_pcihp.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpi_pcihp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 2a47e82..5440131 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -411,13 +411,10 @@ EXPORT_SYMBOL(acpi_get_hp_hw_control_from_firmware);
 static int pcihp_is_ejectable(acpi_handle handle)
 {
 	acpi_status status;
-	acpi_handle tmp;
 	unsigned long long removable;
-	status = acpi_get_handle(handle, "_ADR", &tmp);
-	if (ACPI_FAILURE(status))
+	if (!acpi_has_method(handle, "_ADR"))
 		return 0;
-	status = acpi_get_handle(handle, "_EJ0", &tmp);
-	if (ACPI_SUCCESS(status))
+	if (acpi_has_method(handle, "_EJ0"))
 		return 1;
 	status = acpi_evaluate_integer(handle, "_RMV", NULL, &removable);
 	if (ACPI_SUCCESS(status) && removable)
-- 
1.8.1.2

