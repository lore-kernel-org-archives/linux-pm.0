From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 22/27] ACPI: dock: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Tue,  3 Sep 2013 08:32:10 +0800
Message-ID: <1378168335-22556-23-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60434 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759159Ab3ICAbi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:38 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

acpi_evaluate_integer() is an ACPI API introduced to evaluate an
ACPI control method that is known to have an integer return value.
This API can simplify the code because the calling function does not need to
use the specified acpi_buffer structure required by acpi_evaluate_object();

Convert acpi_evaluate_object() to acpi_evaluate_integer()
in drivers/acpi/dock.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/dock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 05ea4be..ca86c1c 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -441,7 +441,7 @@ static void handle_dock(struct dock_station *ds, int dock)
 	acpi_status status;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	unsigned long long value;
 
 	acpi_handle_info(ds->handle, "%s\n", dock ? "docking" : "undocking");
 
@@ -450,12 +450,10 @@ static void handle_dock(struct dock_station *ds, int dock)
 	arg_list.pointer = &arg;
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = dock;
-	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
+	status = acpi_evaluate_integer(ds->handle, "_DCK", &arg_list, &value);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
 		acpi_handle_err(ds->handle, "Failed to execute _DCK (0x%x)\n",
 				status);
-
-	kfree(buffer.pointer);
 }
 
 static inline void dock(struct dock_station *ds)
-- 
1.8.1.2

