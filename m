From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 17/27] sony-laptop: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:05 +0800
Message-ID: <1378168335-22556-18-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/platform/x86/sony-laptop.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Mattia Dongili <malattia@linux.it>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/sony-laptop.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 069821b..ccacd13 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1509,7 +1509,6 @@ static void sony_nc_function_resume(void)
 static int sony_nc_resume(struct device *dev)
 {
 	struct sony_nc_value *item;
-	acpi_handle handle;
 
 	for (item = sony_nc_values; item->name; item++) {
 		int ret;
@@ -1524,15 +1523,13 @@ static int sony_nc_resume(struct device *dev)
 		}
 	}
 
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
-					 &handle))) {
+	if (acpi_has_method(sony_nc_acpi_handle, "ECON")) {
 		int arg = 1;
 		if (sony_nc_int_call(sony_nc_acpi_handle, "ECON", &arg, NULL))
 			dprintk("ECON Method failed\n");
 	}
 
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
-					 &handle)))
+	if (acpi_has_method(sony_nc_acpi_handle, "SN00"))
 		sony_nc_function_resume();
 
 	return 0;
@@ -2687,7 +2684,6 @@ static void sony_nc_backlight_ng_read_limits(int handle,
 
 static void sony_nc_backlight_setup(void)
 {
-	acpi_handle unused;
 	int max_brightness = 0;
 	const struct backlight_ops *ops = NULL;
 	struct backlight_properties props;
@@ -2722,8 +2718,7 @@ static void sony_nc_backlight_setup(void)
 		sony_nc_backlight_ng_read_limits(0x14c, &sony_bl_props);
 		max_brightness = sony_bl_props.maxlvl - sony_bl_props.offset;
 
-	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
-						&unused))) {
+	} else if (acpi_has_method(sony_nc_acpi_handle, "GBRT")) {
 		ops = &sony_backlight_ops;
 		max_brightness = SONY_MAX_BRIGHTNESS - 1;
 
@@ -2755,7 +2750,6 @@ static int sony_nc_add(struct acpi_device *device)
 {
 	acpi_status status;
 	int result = 0;
-	acpi_handle handle;
 	struct sony_nc_value *item;
 
 	pr_info("%s v%s\n", SONY_NC_DRIVER_NAME, SONY_LAPTOP_DRIVER_VERSION);
@@ -2795,15 +2789,13 @@ static int sony_nc_add(struct acpi_device *device)
 		goto outplatform;
 	}
 
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
-					 &handle))) {
+	if (acpi_has_method(sony_nc_acpi_handle, "ECON")) {
 		int arg = 1;
 		if (sony_nc_int_call(sony_nc_acpi_handle, "ECON", &arg, NULL))
 			dprintk("ECON Method failed\n");
 	}
 
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
-					 &handle))) {
+	if (acpi_has_method(sony_nc_acpi_handle, "SN00")) {
 		dprintk("Doing SNC setup\n");
 		/* retrieve the available handles */
 		result = sony_nc_handles_setup(sony_pf_device);
@@ -2826,9 +2818,8 @@ static int sony_nc_add(struct acpi_device *device)
 
 		/* find the available acpiget as described in the DSDT */
 		for (; item->acpiget && *item->acpiget; ++item->acpiget) {
-			if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle,
-							 *item->acpiget,
-							 &handle))) {
+			if (acpi_has_method(sony_nc_acpi_handle,
+							*item->acpiget)) {
 				dprintk("Found %s getter: %s\n",
 						item->name, *item->acpiget);
 				item->devattr.attr.mode |= S_IRUGO;
@@ -2838,9 +2829,8 @@ static int sony_nc_add(struct acpi_device *device)
 
 		/* find the available acpiset as described in the DSDT */
 		for (; item->acpiset && *item->acpiset; ++item->acpiset) {
-			if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle,
-							 *item->acpiset,
-							 &handle))) {
+			if (acpi_has_method(sony_nc_acpi_handle,
+							*item->acpiset)) {
 				dprintk("Found %s setter: %s\n",
 						item->name, *item->acpiset);
 				item->devattr.attr.mode |= S_IWUSR;
-- 
1.8.1.2
