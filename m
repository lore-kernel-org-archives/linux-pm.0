From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/5] ACPICA: Introduce acpi_enable_all_wakeup_gpes()
Date: Tue, 30 Sep 2014 02:25:42 +0200
Message-ID: <4021848.ZWdxDcq97A@vostro.rjw.lan>
References: <1622293.rpSt5UtDk3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62866 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751742AbaI3AJN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 20:09:13 -0400
In-Reply-To: <1622293.rpSt5UtDk3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a routine for host OSes to enable all wakeup GPEs and disable
all of the non-wakeup ones at the same time.

It will be used for the handling of GPE wakeup from suspend-to-idle
in Linux.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Bob, please let me know if I can fast-track this one.

---
 drivers/acpi/acpica/evxfgpe.c |   32 ++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h         |    1 +
 2 files changed, 33 insertions(+)

Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -596,6 +596,38 @@ acpi_status acpi_enable_all_runtime_gpes
 
 ACPI_EXPORT_SYMBOL(acpi_enable_all_runtime_gpes)
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_enable_all_wakeup_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Enable all "wakeup" GPEs and disable all of the other GPEs, in
+ *              all GPE blocks.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_enable_all_wakeup_gpes(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_enable_all_wakeup_gpes);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_hw_enable_all_wakeup_gpes();
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_enable_all_wakeup_gpes)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_gpe_block
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -692,6 +692,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 						     *event_status))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_gpe_device(u32 gpe_index,

