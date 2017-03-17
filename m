From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 11/15] i2c: core: Allow getting ACPI info by index
Date: Fri, 17 Mar 2017 10:55:23 +0100
Message-ID: <20170317095527.10487-12-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbdCQJ4t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Mar 2017 05:56:49 -0400
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Modify struct i2c_acpi_lookup and i2c_acpi_fill_info() to allow
using them to get the info from a certain index in the ACPI-resource
list rather then taking the first I2cSerialBus resource.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d2402bb..32b58fb 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -112,6 +112,8 @@ struct i2c_acpi_lookup {
 	acpi_handle adapter_handle;
 	acpi_handle device_handle;
 	acpi_handle search_handle;
+	int n;
+	int index;
 	u32 speed;
 	u32 min_speed;
 };
@@ -123,6 +125,9 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 	struct acpi_resource_i2c_serialbus *sb;
 	acpi_status status;
 
+	if (lookup->index != -1 && lookup->n++ != lookup->index)
+		return 1;
+
 	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
 		return 1;
 
@@ -182,6 +187,7 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
+	lookup.index = -1;
 
 	ret = i2c_acpi_do_lookup(adev, &lookup);
 	if (ret)
@@ -328,6 +334,7 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
 	lookup.search_handle = ACPI_HANDLE(dev);
 	lookup.min_speed = UINT_MAX;
 	lookup.info = &dummy;
+	lookup.index = -1;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     I2C_ACPI_MAX_SCAN_DEPTH,
-- 
2.9.3
