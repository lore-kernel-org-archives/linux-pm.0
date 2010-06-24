From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/6] ACPI / ACPICA: Drop acpi_set_gpe
Date: Fri, 25 Jun 2010 01:23:41 +0200
Message-ID: <201006250123.41796.rjw__10658.0071420924$1277424497$gmane$org@sisk.pl>
References: <201006250117.45148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006250117.45148.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: len.brown@intel.com, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The acpi_set_gpe() function is a little awkward, because it doesn't
really work as advertised in the "disable" case.  Namely, if a GPE
has been enabled with acpi_enable_gpe() and triggered a notification
to occur, and if acpi_set_gpe() is used to disable it before
acpi_ev_asynch_enable_gpe() runs, the GPE will be immediately enabled
by the latter as though the acpi_set_gpe() had no effect.

Thus, since it's been possible to make all of its callers use
alternative operations to disable or enable GPEs, acpi_set_gpe() can
be dropped.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evxfevnt.c |   60 -----------------------------------------
 include/acpi/acpixf.h          |    2 -
 include/acpi/actypes.h         |    2 -
 3 files changed, 1 insertion(+), 63 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -271,66 +271,6 @@ ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_set_gpe
- *
- * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
- *              gpe_number      - GPE level within the GPE block
- *              action          - ACPI_GPE_ENABLE or ACPI_GPE_DISABLE
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Enable or disable an individual GPE. This function bypasses
- *              the reference count mechanism used in the acpi_enable_gpe and
- *              acpi_disable_gpe interfaces -- and should be used with care.
- *
- * Note: Typically used to disable a runtime GPE for short period of time,
- * then re-enable it, without disturbing the existing reference counts. This
- * is useful, for example, in the Embedded Controller (EC) driver.
- *
- ******************************************************************************/
-acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
-{
-	struct acpi_gpe_event_info *gpe_event_info;
-	acpi_status status;
-	acpi_cpu_flags flags;
-
-	ACPI_FUNCTION_TRACE(acpi_set_gpe);
-
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
-
-	/* Ensure that we have a valid GPE number */
-
-	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	/* Perform the action */
-
-	switch (action) {
-	case ACPI_GPE_ENABLE:
-		status = acpi_ev_enable_gpe(gpe_event_info);
-		break;
-
-	case ACPI_GPE_DISABLE:
-		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
-		break;
-
-	default:
-		status = AE_BAD_PARAMETER;
-		break;
-	}
-
-      unlock_and_exit:
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-	return_ACPI_STATUS(status);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_set_gpe)
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_enable_gpe
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -283,8 +283,6 @@ acpi_status acpi_get_event_status(u32 ev
  */
 acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action);
 
-acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action);
-
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
Index: linux-2.6/include/acpi/actypes.h
===================================================================
--- linux-2.6.orig/include/acpi/actypes.h
+++ linux-2.6/include/acpi/actypes.h
@@ -663,7 +663,7 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
-/* Actions for acpi_set_gpe, acpi_hw_low_set_gpe and acpi_gpe_wakeup */
+/* Actions for acpi_hw_low_set_gpe and acpi_gpe_wakeup */
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1
