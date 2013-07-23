From: tianyu.lan@intel.com
Subject: [PATCH] ACPI/glue: evaluate "_STA" method directly to get device actual status instead of using acpi_bus_get_status_handle()
Date: Tue, 23 Jul 2013 10:47:13 +0800
Message-ID: <1374547633-4477-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49501 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753890Ab3GWCzt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Jul 2013 22:55:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Dagobertstaler@gmail.com, git@karolherbst.de

From: Lan Tianyu <tianyu.lan@intel.com>

commit 33f767d7(ACPI: Rework acpi_get_child() to be more efficient) changes
the logic of choosing child in the do_acpi_find_child() when there are
multi child devices with same _ADR. Original, it returned the last one but
it return the first one after commit 33f767d7. This causes regression on the
Notebook P15SM that there is no ACPI handle for video card. This because
there are two ACPI nodes with same _ADR for associated PCIE port. One
contains video card's ACPI node and the other one doesn't(So called wrong
ACPI node.). The wrong one is the first child device on this machine. So
after commit 33f767d7, bbswitch can't find ACPI handle for video card.
Further more, both these device nodes don't have _STA.

commit c7d9ca9(ACPI: add _STA evaluation at do_acpi_find_child()) also
changes the logic of choosing child. On some platforms, there are multiple
devices with the same "_ADR" and they are perceptively for WIN7, WIN8 and
Linux. If one of them is enabled, others will be disabled. The commit calls
acpi_bus_get_status_handle() to get device's status If a matching device object
exists, but is disabled, acpi_get_child() will continue to walk the namespace
in the hope of finding an enabled one. If one is found, its handle will be returned,
but otherwise the function will return the handle of the disabled object found.
For this case, Bios must provide _STA for these device nodes since this is designed
for OS to select which device node should be chosen.

After commit c7d9ca9, the first enabled device will be chosen or if
all device nodes were disabled or acpi_bus_get_status_handle() always returned
error, the last one would be returned. But for device nodes without _STA,
according acpi spec "If a device object (including the processor object) does not
have an _STA object, then OSPM assumes that the device is present, enabled, shown
in the UI, and functioning." and so acpi_bus_get_status_handle() return 0x0F as
status for these devices without _STA.

On the Notebook P15SM, both PCIE port device node with same _ADR don't have _STA
and are treated as ENABLED devices by do_acpi_find_child(). The first wrong device
node is returned. To workaround the issue, evaluate the _STA directly in the
do_acpi_find_child() and if all device nodes doesn't have _STA, the last one will
be chosen. This also will not affect the case for commit c7d9ca9. This have been
tested on Lenovo Y480 where commit 33f767d7 fixed one similar issue.

Reference:https://bugzilla.kernel.org/show_bug.cgi?id=60561
Reference:https://github.com/Bumblebee-Project/bbswitch/issues/65
reference:https://github.com/Bumblebee-Project/bbswitch/issues/2#issuecomment-21101083
Tested-by: Sergio Perez <Dagobertstaler@gmail.com>
Tested-by: Karol Herbst <git@karolherbst.de>
Cc: <stable@vger.kernel.org> #3.9+
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Hi Rafael:
	This patch is based on the commit c7d9ca9 merged in v3.11
and purposes to fix the regression introduced by 33f767d7 merged in v3.9.
So it's necessary to backport both commit c7d9ca9 and this patch to 3.9+ stable tree?

 drivers/acpi/glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index f680957..732c707 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -87,7 +87,7 @@ static acpi_status do_acpi_find_child(acpi_handle handle, u32 lvl_not_used,
 	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &addr);
 	if (ACPI_SUCCESS(status) && addr == *((u64 *)addr_p)) {
 		*ret_p = handle;
-		status = acpi_bus_get_status_handle(handle, &sta);
+		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 		if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_ENABLED))
 			return AE_CTRL_TERMINATE;
 	}
-- 
1.8.3.2

