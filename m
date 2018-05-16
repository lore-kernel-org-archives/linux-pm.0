From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] ACPICA: Introduce acpi_dispatch_gpe()
Date: Wed, 16 May 2018 14:12:03 +0200
Message-ID: <1877957.ohNgiH8Sko@aspire.rjw.lan>
References: <2406722.gU2bUHd7bl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2406722.gU2bUHd7bl@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>, "Wang, Wendy" <wendy.wang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce acpi_dispatch_gpe() as a wrapper around acpi_ev_detect_gpe()
for checking if the given GPE (as represented by a GPE device handle
and a GPE number) is currently active and dispatching it (if that's
the case) outside of interrupt context.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evgpe.c   |    6 ++++++
 drivers/acpi/acpica/evxfgpe.c |   22 ++++++++++++++++++++++
 include/acpi/acpixf.h         |    1 +
 3 files changed, 29 insertions(+)

Index: linux-pm/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpe.c
+++ linux-pm/drivers/acpi/acpica/evgpe.c
@@ -634,6 +634,12 @@ acpi_ev_detect_gpe(struct acpi_namespace
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
+	if (!gpe_event_info) {
+		gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+		if (!gpe_event_info)
+			goto error_exit;
+	}
+
 	/* Get the info block for the entire GPE register */
 
 	gpe_register_info = gpe_event_info->register_info;
Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -639,6 +639,28 @@ ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_gispatch_gpe
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Detect and dispatch a General Purpose Event to either a function
+ *              (e.g. EC) or method (e.g. _Lxx/_Exx) handler.
+ *
+ ******************************************************************************/
+void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	ACPI_FUNCTION_TRACE(acpi_dispatch_gpe);
+
+	acpi_ev_detect_gpe(gpe_device, NULL, gpe_number);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_dispatch_gpe)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_finish_gpe
  *
  * PARAMETERS:  gpe_device          - Namespace node for the GPE Block
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -753,6 +753,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 						     u32 gpe_number,
 						     acpi_event_status
 						     *event_status))
+void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number);
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
