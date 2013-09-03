From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 23/27] i2c-hid: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Tue,  3 Sep 2013 08:32:11 +0800
Message-ID: <1378168335-22556-24-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41893 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759257Ab3ICAbh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:37 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

acpi_evaluate_integer() is an ACPI API introduced to evaluate an
ACPI control method that is known to have an integer return value.
This API can simplify the code because the calling function does not need to
use the specified acpi_buffer structure required by acpi_evaluate_object();

Convert acpi_evaluate_object() to acpi_evaluate_integer()
in drivers/hid/i2c-hid/i2c-hid.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/i2c-hid/i2c-hid.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 05d4f96..dbca084 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -854,10 +854,10 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 		0xF7, 0xF6, 0xDF, 0x3C, 0x67, 0x42, 0x55, 0x45,
 		0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE,
 	};
-	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object params[4], *obj;
+	union acpi_object params[4];
 	struct acpi_object_list input;
 	struct acpi_device *adev;
+	unsigned long long value;
 	acpi_handle handle;
 
 	handle = ACPI_HANDLE(&client->dev);
@@ -877,22 +877,14 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	params[3].type = ACPI_TYPE_INTEGER;
 	params[3].integer.value = 0;
 
-	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_DSM", &input, &buf))) {
+	if (ACPI_FAILURE(acpi_evaluate_integer(handle, "_DSM", &input,
+								&value))) {
 		dev_err(&client->dev, "device _DSM execution failed\n");
 		return -ENODEV;
 	}
 
-	obj = (union acpi_object *)buf.pointer;
-	if (obj->type != ACPI_TYPE_INTEGER) {
-		dev_err(&client->dev, "device _DSM returned invalid type: %d\n",
-			obj->type);
-		kfree(buf.pointer);
-		return -EINVAL;
-	}
-
-	pdata->hid_descriptor_address = obj->integer.value;
+	pdata->hid_descriptor_address = value;
 
-	kfree(buf.pointer);
 	return 0;
 }
 
-- 
1.8.1.2

