From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/6] ACPI / ACPICA: Use low-level GPE enable
	during GPE block initialization
Date: Fri, 25 Jun 2010 01:22:38 +0200
Message-ID: <201006250122.38904.rjw__23625.9091798731$1277424204$gmane$org@sisk.pl>
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

The GPE block initialization code in acpi_ev_initialize_gpe_block()
uses acpi_set_gpe() to make sure that the GPEs with nonzero
runtime counter will remain enabled, but since it already has
a struct acpi_gpe_event_info object for each GPE, it might use
the low-level GPE enabling function, acpi_clear_and_enable_gpe(),
for this purpose.

To make that happen, move acpi_clear_and_enable_gpe() to
drivers/acpi/acpica/evgpe.c and rename it to acpi_ev_enable_gpe(),
modify the two existing users of it accordingly and modify
acpi_ev_initialize_gpe_block() to use it instead of acpi_set_gpe()
and to check its return value.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/acevents.h |    2 +
 drivers/acpi/acpica/evgpe.c    |   37 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evgpeblk.c |    7 ++----
 drivers/acpi/acpica/evxfevnt.c |   42 +----------------------------------------
 4 files changed, 44 insertions(+), 44 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -80,6 +80,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 acpi_status
 acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 
+acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
 
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -94,6 +94,43 @@ acpi_ev_update_gpe_enable_mask(struct ac
 	return_ACPI_STATUS(AE_OK);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_enable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to enable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear the given GPE from stale events and enable it.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status;
+
+	/*
+	 * We will only allow a GPE to be enabled if it has either an
+	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
+	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
+	 * first time it fires.
+	 */
+	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
+		return_ACPI_STATUS(AE_NO_HANDLER);
+	}
+
+	/* Clear the GPE (of stale events) */
+	status = acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Enable the requested GPE */
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
+
+	return_ACPI_STATUS(status);
+}
 
 /*******************************************************************************
  *
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -271,44 +271,6 @@ ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_clear_and_enable_gpe
- *
- * PARAMETERS:  gpe_event_info  - GPE to enable
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Clear the given GPE from stale events and enable it.
- *
- ******************************************************************************/
-static acpi_status
-acpi_clear_and_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-	/*
-	 * We will only allow a GPE to be enabled if it has either an
-	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
-	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
-	 * first time it fires.
-	 */
-	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
-		return_ACPI_STATUS(AE_NO_HANDLER);
-	}
-
-	/* Clear the GPE (of stale events) */
-	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Enable the requested GPE */
-	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
-
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_set_gpe
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
@@ -348,7 +310,7 @@ acpi_status acpi_set_gpe(acpi_handle gpe
 
 	switch (action) {
 	case ACPI_GPE_ENABLE:
-		status = acpi_clear_and_enable_gpe(gpe_event_info);
+		status = acpi_ev_enable_gpe(gpe_event_info);
 		break;
 
 	case ACPI_GPE_DISABLE:
@@ -407,7 +369,7 @@ acpi_status acpi_enable_gpe(acpi_handle 
 	if (gpe_event_info->runtime_count == 1) {
 		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
 		if (ACPI_SUCCESS(status)) {
-			status = acpi_clear_and_enable_gpe(gpe_event_info);
+			status = acpi_ev_enable_gpe(gpe_event_info);
 		}
 
 		if (ACPI_FAILURE(status)) {
Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -508,10 +508,8 @@ acpi_ev_initialize_gpe_block(struct acpi
 			 * increment its reference counter.
 			 */
 			if (gpe_event_info->runtime_count) {
-				acpi_set_gpe(gpe_device, gpe_number,
-						ACPI_GPE_ENABLE);
-				gpe_enabled_count++;
-				continue;
+				status = acpi_ev_enable_gpe(gpe_event_info);
+				goto enabled;
 			}
 
 			if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE) {
@@ -530,6 +528,7 @@ acpi_ev_initialize_gpe_block(struct acpi
 			/* Enable this GPE */
 
 			status = acpi_enable_gpe(gpe_device, gpe_number);
+ enabled:
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",
