From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/52] ACPICA: Remove argument of
	acpi_os_wait_events_complete
Date: Tue, 24 Jul 2012 23:41:05 -0400
Message-ID: <bd6f10a5f984e48cb56a39f2698cd58e7a33d56b.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Lin Ming <ming.m.lin@intel.com>

Remove the unused argument of acpi_os_wait_events_complete.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evxface.c | 4 ++--
 drivers/acpi/osl.c            | 4 ++--
 drivers/acpi/sleep.c          | 2 +-
 include/acpi/acpiosxf.h       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 90ae6d1..6a8b537 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -251,7 +251,7 @@ acpi_remove_notify_handler(acpi_handle device,
 	}
 	/* Make sure all deferred tasks are completed */
 
-	acpi_os_wait_events_complete(NULL);
+	acpi_os_wait_events_complete();
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
@@ -699,7 +699,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 
 	/* Make sure all deferred tasks are completed */
 
-	acpi_os_wait_events_complete(NULL);
+	acpi_os_wait_events_complete();
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c3881b2..9eaf708 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -891,7 +891,7 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
 
 	if (dpc->wait)
-		acpi_os_wait_events_complete(NULL);
+		acpi_os_wait_events_complete();
 
 	dpc->function(dpc->context);
 	kfree(dpc);
@@ -987,7 +987,7 @@ acpi_status acpi_os_hotplug_execute(acpi_osd_exec_callback function,
 	return __acpi_os_execute(0, function, context, 1);
 }
 
-void acpi_os_wait_events_complete(void *context)
+void acpi_os_wait_events_complete(void)
 {
 	flush_workqueue(kacpid_wq);
 	flush_workqueue(kacpi_notify_wq);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index eb6fd23..9a14f90 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -144,7 +144,7 @@ void __init acpi_old_suspend_ordering(void)
 static int acpi_pm_freeze(void)
 {
 	acpi_disable_all_gpes();
-	acpi_os_wait_events_complete(NULL);
+	acpi_os_wait_events_complete();
 	acpi_ec_block_transactions();
 	return 0;
 }
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 21a5548..f3746f7 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -205,7 +205,7 @@ acpi_os_execute(acpi_execute_type type,
 acpi_status
 acpi_os_hotplug_execute(acpi_osd_exec_callback function, void *context);
 
-void acpi_os_wait_events_complete(void *context);
+void acpi_os_wait_events_complete(void);
 
 void acpi_os_sleep(u64 milliseconds);
 
-- 
1.7.12.rc0
