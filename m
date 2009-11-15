From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 5/10] ACPI: Add infrastructure for
	refcounting GPE consumers
Date: Mon, 16 Nov 2009 00:53:00 +0100
Message-ID: <200911160053.00214.rjw__29067.7228862934$1258329773$gmane$org@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911160047.46299.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Matthew Garrett <mjg@redhat.com>

ACPI GPEs may map to multiple devices. The current GPE interface only
provides a mechanism for enabling and disabling GPEs, making it difficult
to change the state of GPEs at runtime without extensive cooperation
between devices. Add an API to allow devices to indicate whether or not
they want their device's GPE to be enabled for both runtime and wakeup
events.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
drivers/acpi/acpica/aclocal.h  |    2 +
 drivers/acpi/acpica/aclocal.h  |    2 
 drivers/acpi/acpica/evxfevnt.c |  161 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |    8 ++
 3 files changed, 171 insertions(+)

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
@@ -201,6 +201,167 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ref_runtime_gpe
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device
+ *              gpe_number      - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Take a reference to a runtime GPE
+ *
+ ******************************************************************************/
+acpi_status acpi_ref_runtime_gpe(acpi_handle gpe_device, u32 gpe_number)
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
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	if (++gpe_event_info->runtime_count == 1)
+		status = acpi_ev_enable_gpe(gpe_event_info, TRUE);
+
+	if (ACPI_FAILURE(status))
+		gpe_event_info->runtime_count--;
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_ref_runtime_gpe)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_unref_runtime_gpe
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device
+ *              gpe_number      - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Release a reference to a runtime GPE
+ *
+ ******************************************************************************/
+acpi_status acpi_unref_runtime_gpe(acpi_handle gpe_device, u32 gpe_number)
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
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	if (--gpe_event_info->runtime_count == 0)
+		acpi_ev_disable_gpe(gpe_event_info);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_unref_runtime_gpe)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ref_wakeup_gpe
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device
+ *              gpe_number      - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Take a reference to a wakeup GPE
+ *
+ ******************************************************************************/
+acpi_status acpi_ref_wakeup_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	acpi_status status = AE_OK;
+	acpi_cpu_flags flags;
+	struct acpi_gpe_event_info *gpe_event_info;
+
+	ACPI_FUNCTION_TRACE(acpi_ref_wakeup_gpe);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	if (++gpe_event_info->wakeup_count == 1)
+		acpi_ev_update_gpe_enable_masks(gpe_event_info,
+						ACPI_GPE_ENABLE);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_ref_wakeup_gpe)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_unref_wakeup_gpe
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device
+ *              gpe_number      - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Release a reference to a wakeup GPE
+ *
+ ******************************************************************************/
+acpi_status acpi_unref_wakeup_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	acpi_status status = AE_OK;
+	acpi_cpu_flags flags;
+	struct acpi_gpe_event_info *gpe_event_info;
+
+	ACPI_FUNCTION_TRACE(acpi_unref_wakeup_gpe);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	if (--gpe_event_info->wakeup_count == 0)
+		acpi_ev_update_gpe_enable_masks(gpe_event_info,
+			ACPI_GPE_DISABLE);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_unref_wakeup_gpe)
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
@@ -282,6 +282,14 @@ acpi_status acpi_get_event_status(u32 ev
  */
 acpi_status acpi_set_gpe_type(acpi_handle gpe_device, u32 gpe_number, u8 type);
 
+acpi_status acpi_ref_runtime_gpe(acpi_handle gpe_device, u32 gpe_number);
+
+acpi_status acpi_unref_runtime_gpe(acpi_handle gpe_device, u32 gpe_number);
+
+acpi_status acpi_ref_wakeup_gpe(acpi_handle gpe_device, u32 gpe_number);
+
+acpi_status acpi_unref_wakeup_gpe(acpi_handle gpe_device, u32 gpe_number);
+
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
