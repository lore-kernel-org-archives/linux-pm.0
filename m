From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/76] ACPICA: ACPI 5: Update debug output for
	new notify values
Date: Fri, 30 Mar 2012 06:13:31 -0400
Message-ID: <ea143604c5c8426923bbed7cd389fdaed7d58a2e.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
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

From: Bob Moore <robert.moore@intel.com>

Add new notify values, add support for "hardware specific" notifies.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evmisc.c   |   23 +++++++++++++----------
 drivers/acpi/acpica/utdecode.c |   34 ++++++++++++++++++----------------
 include/acpi/actypes.h         |    6 ++++--
 3 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 0912f62..51ef9f5 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -108,27 +108,30 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 	ACPI_FUNCTION_NAME(ev_queue_notify_request);
 
 	/*
-	 * For value 3 (Ejection Request), some device method may need to be run.
-	 * For value 2 (Device Wake) if _PRW exists, the _PS0 method may need
-	 *   to be run.
+	 * For value 0x03 (Ejection Request), may need to run a device method.
+	 * For value 0x02 (Device Wake), if _PRW exists, may need to run
+	 *   the _PS0 method.
 	 * For value 0x80 (Status Change) on the power button or sleep button,
-	 *   initiate soft-off or sleep operation?
+	 *   initiate soft-off or sleep operation.
+	 *
+	 * For all cases, simply dispatch the notify to the handler.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Dispatching Notify on [%4.4s] Node %p Value 0x%2.2X (%s)\n",
-			  acpi_ut_get_node_name(node), node, notify_value,
-			  acpi_ut_get_notify_name(notify_value)));
+			  "Dispatching Notify on [%4.4s] (%s) Value 0x%2.2X (%s) Node %p\n",
+			  acpi_ut_get_node_name(node),
+			  acpi_ut_get_type_name(node->type), notify_value,
+			  acpi_ut_get_notify_name(notify_value), node));
 
 	/* Get the notify object attached to the NS Node */
 
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (obj_desc) {
 
-		/* We have the notify object, Get the right handler */
+		/* We have the notify object, Get the correct handler */
 
 		switch (node->type) {
 
-			/* Notify allowed only on these types */
+			/* Notify is allowed only on these types */
 
 		case ACPI_TYPE_DEVICE:
 		case ACPI_TYPE_THERMAL:
@@ -152,7 +155,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 	}
 
 	/*
-	 * If there is any handler to run, schedule the dispatcher.
+	 * If there is a handler to run, schedule the dispatcher.
 	 * Check for:
 	 * 1) Global system notify handler
 	 * 2) Global device notify handler
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index d42ede52..6848499 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -497,19 +497,20 @@ char *acpi_ut_get_mutex_name(u32 mutex_id)
 
 /* Names for Notify() values, used for debug output */
 
-static const char *acpi_gbl_notify_value_names[] = {
-	"Bus Check",
-	"Device Check",
-	"Device Wake",
-	"Eject Request",
-	"Device Check Light",
-	"Frequency Mismatch",
-	"Bus Mode Mismatch",
-	"Power Fault",
-	"Capabilities Check",
-	"Device PLD Check",
-	"Reserved",
-	"System Locality Update"
+static const char *acpi_gbl_notify_value_names[ACPI_NOTIFY_MAX + 1] = {
+	/* 00 */ "Bus Check",
+	/* 01 */ "Device Check",
+	/* 02 */ "Device Wake",
+	/* 03 */ "Eject Request",
+	/* 04 */ "Device Check Light",
+	/* 05 */ "Frequency Mismatch",
+	/* 06 */ "Bus Mode Mismatch",
+	/* 07 */ "Power Fault",
+	/* 08 */ "Capabilities Check",
+	/* 09 */ "Device PLD Check",
+	/* 10 */ "Reserved",
+	/* 11 */ "System Locality Update",
+	/* 12 */ "Shutdown Request"
 };
 
 const char *acpi_ut_get_notify_name(u32 notify_value)
@@ -519,9 +520,10 @@ const char *acpi_ut_get_notify_name(u32 notify_value)
 		return (acpi_gbl_notify_value_names[notify_value]);
 	} else if (notify_value <= ACPI_MAX_SYS_NOTIFY) {
 		return ("Reserved");
-	} else {		/* Greater or equal to 0x80 */
-
-		return ("**Device Specific**");
+	} else if (notify_value <= ACPI_MAX_DEVICE_SPECIFIC_NOTIFY) {
+		return ("Device Specific");
+	} else {
+		return ("Hardware Specific");
 	}
 }
 #endif
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d5dee7c..48c4d5f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -532,8 +532,9 @@ typedef u64 acpi_integer;
 #define ACPI_NOTIFY_DEVICE_PLD_CHECK    (u8) 0x09
 #define ACPI_NOTIFY_RESERVED            (u8) 0x0A
 #define ACPI_NOTIFY_LOCALITY_UPDATE     (u8) 0x0B
+#define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
 
-#define ACPI_NOTIFY_MAX                 0x0B
+#define ACPI_NOTIFY_MAX                 0x0C
 
 /*
  * Types associated with ACPI names and objects. The first group of
@@ -698,7 +699,8 @@ typedef u32 acpi_event_status;
 #define ACPI_ALL_NOTIFY                 (ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY)
 #define ACPI_MAX_NOTIFY_HANDLER_TYPE    0x3
 
-#define ACPI_MAX_SYS_NOTIFY             0x7f
+#define ACPI_MAX_SYS_NOTIFY             0x7F
+#define ACPI_MAX_DEVICE_SPECIFIC_NOTIFY 0xBF
 
 /* Address Space (Operation Region) Types */
 
-- 
1.7.10.rc2.19.gfae9d
