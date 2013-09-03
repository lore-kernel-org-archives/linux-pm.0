From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 15/27] fujitsu-laptop: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:03 +0800
Message-ID: <1378168335-22556-16-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/platform/x86/fujitsu-laptop.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/fujitsu-laptop.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 29738cb..765d8c1 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -579,11 +579,10 @@ static struct platform_driver fujitsupf_driver = {
 
 static void dmi_check_cb_common(const struct dmi_system_id *id)
 {
-	acpi_handle handle;
 	pr_info("Identified laptop model '%s'\n", id->ident);
 	if (use_alt_lcd_levels == -1) {
-		if (ACPI_SUCCESS(acpi_get_handle(NULL,
-				"\\_SB.PCI0.LPCB.FJEX.SBL2", &handle)))
+		if (acpi_has_method(NULL,
+				"\\_SB.PCI0.LPCB.FJEX.SBL2"))
 			use_alt_lcd_levels = 1;
 		else
 			use_alt_lcd_levels = 0;
@@ -646,7 +645,6 @@ static struct dmi_system_id fujitsu_dmi_table[] = {
 
 static int acpi_fujitsu_add(struct acpi_device *device)
 {
-	acpi_handle handle;
 	int result = 0;
 	int state = 0;
 	struct input_dev *input;
@@ -695,8 +693,7 @@ static int acpi_fujitsu_add(struct acpi_device *device)
 
 	fujitsu->dev = device;
 
-	if (ACPI_SUCCESS
-	    (acpi_get_handle(device->handle, METHOD_NAME__INI, &handle))) {
+	if (acpi_has_method(device->handle, METHOD_NAME__INI)) {
 		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
 		if (ACPI_FAILURE
 		    (acpi_evaluate_object
@@ -796,7 +793,6 @@ static void acpi_fujitsu_notify(struct acpi_device *device, u32 event)
 
 static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
 {
-	acpi_handle handle;
 	int result = 0;
 	int state = 0;
 	struct input_dev *input;
@@ -859,8 +855,7 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
 
 	fujitsu_hotkey->dev = device;
 
-	if (ACPI_SUCCESS
-	    (acpi_get_handle(device->handle, METHOD_NAME__INI, &handle))) {
+	if (acpi_has_method(device->handle, METHOD_NAME__INI)) {
 		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
 		if (ACPI_FAILURE
 		    (acpi_evaluate_object
-- 
1.8.1.2
