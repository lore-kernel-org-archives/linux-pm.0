From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] ACPI / ACPICA: Always use the same lock for
	GPE locking
Date: Fri, 2 Apr 2010 22:37:28 +0200
Message-ID: <201004022237.28871.rjw__37891.4384091788$1270240576$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, "Moore,
	Robert" <robert.moore@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The GPE locking is now inconsistent, because acpi_set_gpe(),
acpi_enable_gpe() and acpi_disable_gpe() use acpi_gbl_gpe_lock for
this purpose, while acpi_clear_gpe() and acpi_get_gpe_status() use
the ACPI_MTX_EVENTS mutex instead (the mutex is only acquired if
they are not executed in interrupt context).  Fix this by changing
acpi_clear_gpe() and acpi_get_gpe_status() so that they acquire
acpi_gbl_gpe_lock too.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Robert Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |   28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -476,19 +476,13 @@ ACPI_EXPORT_SYMBOL(acpi_clear_event)
  ******************************************************************************/
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags)
 {
+	acpi_cpu_flags cpu_flags;
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
 
 	ACPI_FUNCTION_TRACE(acpi_clear_gpe);
 
-	/* Use semaphore lock if not executing at interrupt level */
-
-	if (flags & ACPI_NOT_ISR) {
-		status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
+	cpu_flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
@@ -501,9 +495,7 @@ acpi_status acpi_clear_gpe(acpi_handle g
 	status = acpi_hw_clear_gpe(gpe_event_info);
 
       unlock_and_exit:
-	if (flags & ACPI_NOT_ISR) {
-		(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, cpu_flags);
 	return_ACPI_STATUS(status);
 }
 
@@ -584,19 +576,13 @@ acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number, u32 flags, acpi_event_status * event_status)
 {
+	acpi_cpu_flags cpu_flags;
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
 
 	ACPI_FUNCTION_TRACE(acpi_get_gpe_status);
 
-	/* Use semaphore lock if not executing at interrupt level */
-
-	if (flags & ACPI_NOT_ISR) {
-		status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
+	cpu_flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
@@ -614,9 +600,7 @@ acpi_get_gpe_status(acpi_handle gpe_devi
 		*event_status |= ACPI_EVENT_FLAG_HANDLE;
 
       unlock_and_exit:
-	if (flags & ACPI_NOT_ISR) {
-		(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, cpu_flags);
 	return_ACPI_STATUS(status);
 }
 
