From: Len Brown <lenb@kernel.org>
Subject: [PATCH 56/76] ACPI: Add CPU hotplug support for
 processor device objects
Date: Fri, 30 Mar 2012 06:13:59 -0400
Message-ID: <9f324bda970c599ca35f7be89d9d1bcb96d6053c.1333101989.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Toshi Kani <toshi.kani@hp.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Toshi Kani <toshi.kani@hp.com>

acpi_processor_install_hotplug_notify() registers processor objects to
receive ACPI CPU hotplug event notifications. This patch additionally
registers processor device objects (ACPI0007) to receive the notifications
as well.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_driver.c |   48 +++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 8ae05ce..50be277 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -68,6 +68,7 @@
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
+#define ACPI_PROCESSOR_DEVICE_HID	"ACPI0007"
 
 #define ACPI_PROCESSOR_LIMIT_USER	0
 #define ACPI_PROCESSOR_LIMIT_THERMAL	1
@@ -88,7 +89,7 @@ static int acpi_processor_start(struct acpi_processor *pr);
 
 static const struct acpi_device_id processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, 0},
-	{"ACPI0007", 0},
+	{ACPI_PROCESSOR_DEVICE_HID, 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, processor_device_ids);
@@ -741,20 +742,46 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
 	return;
 }
 
+static acpi_status is_processor_device(acpi_handle handle)
+{
+	struct acpi_device_info *info;
+	char *hid;
+	acpi_status status;
+
+	status = acpi_get_object_info(handle, &info);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	if (info->type == ACPI_TYPE_PROCESSOR) {
+		kfree(info);
+		return AE_OK;	/* found a processor object */
+	}
+
+	if (!(info->valid & ACPI_VALID_HID)) {
+		kfree(info);
+		return AE_ERROR;
+	}
+
+	hid = info->hardware_id.string;
+	if ((hid == NULL) || strcmp(hid, ACPI_PROCESSOR_DEVICE_HID)) {
+		kfree(info);
+		return AE_ERROR;
+	}
+
+	kfree(info);
+	return AE_OK;	/* found a processor device object */
+}
+
 static acpi_status
 processor_walk_namespace_cb(acpi_handle handle,
 			    u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
 	int *action = context;
-	acpi_object_type type = 0;
 
-	status = acpi_get_type(handle, &type);
+	status = is_processor_device(handle);
 	if (ACPI_FAILURE(status))
-		return (AE_OK);
-
-	if (type != ACPI_TYPE_PROCESSOR)
-		return (AE_OK);
+		return AE_OK;	/* not a processor; continue to walk */
 
 	switch (*action) {
 	case INSTALL_NOTIFY_HANDLER:
@@ -772,7 +799,8 @@ processor_walk_namespace_cb(acpi_handle handle,
 		break;
 	}
 
-	return (AE_OK);
+	/* found a processor; skip walking underneath */
+	return AE_CTRL_DEPTH;
 }
 
 static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
@@ -830,7 +858,7 @@ void acpi_processor_install_hotplug_notify(void)
 {
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 	int action = INSTALL_NOTIFY_HANDLER;
-	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
+	acpi_walk_namespace(ACPI_TYPE_ANY,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    processor_walk_namespace_cb, NULL, &action, NULL);
@@ -843,7 +871,7 @@ void acpi_processor_uninstall_hotplug_notify(void)
 {
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 	int action = UNINSTALL_NOTIFY_HANDLER;
-	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
+	acpi_walk_namespace(ACPI_TYPE_ANY,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    processor_walk_namespace_cb, NULL, &action, NULL);
-- 
1.7.10.rc2.19.gfae9d
