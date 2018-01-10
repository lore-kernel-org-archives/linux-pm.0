From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] thermal: int3400_thermal: Ignore charger events
Date: Wed, 10 Jan 2018 20:59:49 +0100
Message-ID: <20180110195949.27535-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbeAJT7w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jan 2018 14:59:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Ignore events of type 0x86 which are fired of when plugging in / out the
charger, judging from both observed behavior and the AML code on an Asus
T100HA.

This silences these kernel errors on the T100HA:
[   86.599918] acpi INT3400:00: Unsupported event [0x86]
[  120.133024] acpi INT3400:00: Unsupported event [0x86]

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 8ee38f55c7f3..e92e7a2b401a 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -17,6 +17,7 @@
 #include "acpi_thermal_rel.h"
 
 #define INT3400_THERMAL_TABLE_CHANGED 0x83
+#define INT3400_CHARGER_EVENT         0x86
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
@@ -210,6 +211,8 @@ static void int3400_notify(acpi_handle handle,
 		kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE,
 				thermal_prop);
 		break;
+	case INT3400_CHARGER_EVENT:
+		break;
 	default:
 		dev_err(&priv->adev->dev, "Unsupported event [0x%x]\n", event);
 		break;
-- 
2.14.3
