From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update][RFC][PATCH 1/3] ACPI: Add infrastructure for
	refcounting GPE consumers
Date: Sun, 7 Feb 2010 12:58:14 +0100
Message-ID: <201002071258.14919.rjw__39003.109795931$1265544148$gmane$org@sisk.pl>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
	<201002070317.47029.rjw@sisk.pl> <201002071256.35998.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002071256.35998.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI GPEs may map to multiple devices.  The current GPE interface
only provides a mechanism for enabling and disabling GPEs, making
it difficult to change the state of GPEs at runtime without extensive
cooperation between devices.  Add an API to allow devices to indicate
whether or not they want their device's GPE to be enabled for both
runtime and wakeup events.

Based on a patch from Matthew Garrett <mjg@redhat.com>.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
drivers/acpi/acpica/aclocal.h  |    2 +
 drivers/acpi/acpica/aclocal.h  |    2 
 drivers/acpi/acpica/evxfevnt.c |  105 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |    4 +
 3 files changed, 111 insertions(+)

Index: linux-2.6/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
+++ linux-2.6/drivers/acpi/acpica/aclocal.h
@@ -426,6 +426,8 @@ struct acpi_gpe_event_info {
 	struct acpi_gpe_register_info *register_info;	/* Backpointer to register info */
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
+	u8 runtime_count;
+	u8 wakeup_count;
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -201,6 +201,111 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_get_gpe
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device
+ *              gpe_number      - GPE level within the GPE block
+ *              type            - Purpose the GPE will be used for
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Take a reference to a GPE and enable it if necessary
+ *
+ ******************************************************************************/
+acpi_status acpi_get_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type)
+{
+	acpi_status status = AE_OK;
+	acpi_cpu_flags flags;
+	struct acpi_gpe_event_info *gpe_event_info;
+
+	ACPI_FUNCTION_TRACE(acpi_ref_runtime_gpe);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	if (type & ACPI_GPE_TYPE_RUNTIME) {
+		if (++gpe_event_info->runtime_count == 1)
+			status = acpi_ev_enable_gpe(gpe_event_info, TRUE);
+
+		if (ACPI_FAILURE(status))
+			gpe_event_info->runtime_count--;
+	}
+
+	if (type & ACPI_GPE_TYPE_WAKE) {
+		/*
+		 * Wake-up GPEs are only enabled right prior to putting the
+		 * system into a sleep state.
+		 */
+		if (++gpe_event_info->wakeup_count == 1)
+			acpi_ev_update_gpe_enable_masks(gpe_event_info,
+							ACPI_GPE_ENABLE);
+	}
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_get_gpe)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_put_gpe
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device
+ *              gpe_number      - GPE level within the GPE block
+ *              type            - Purpose the GPE won't be used for any more
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Release a reference to a GPE and disable it if necessary
+ *
+ ******************************************************************************/
+acpi_status acpi_put_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type)
+{
+	acpi_status status = AE_OK;
+	acpi_cpu_flags flags;
+	struct acpi_gpe_event_info *gpe_event_info;
+
+	ACPI_FUNCTION_TRACE(acpi_unref_runtime_gpe);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	if ((type & ACPI_GPE_TYPE_WAKE) && gpe_event_info->runtime_count) {
+		if (--gpe_event_info->runtime_count == 0)
+			acpi_ev_disable_gpe(gpe_event_info);
+	}
+
+	if ((type & ACPI_GPE_TYPE_RUNTIME) && gpe_event_info->wakeup_count) {
+		/*
+		 * Wake-up GPEs are not enabled after leaving system sleep
+		 * states, so we don't need to disable them here.
+		 */
+		if (--gpe_event_info->wakeup_count == 0)
+			acpi_ev_update_gpe_enable_masks(gpe_event_info,
+							ACPI_GPE_DISABLE);
+	}
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_put_gpe)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_set_gpe_type
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -283,6 +283,10 @@ acpi_status acpi_get_event_status(u32 ev
  */
 acpi_status acpi_set_gpe_type(acpi_handle gpe_device, u32 gpe_number, u8 type);
 
+acpi_status acpi_get_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type);
+
+acpi_status acpi_put_gpe(acpi_handle gpe_device, u32 gpe_number, u8 type);
+
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
