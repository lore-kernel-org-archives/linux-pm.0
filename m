From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend] thermal: int3400_thermal: Ignore charger events
Date: Wed, 14 Feb 2018 16:13:40 +0100
Message-ID: <20180214151340.1811-2-hdegoede@redhat.com>
References: <20180214151340.1811-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030887AbeBNPNn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Feb 2018 10:13:43 -0500
In-Reply-To: <20180214151340.1811-1-hdegoede@redhat.com>
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
index e26b01c05e82..3c37528f2319 100644
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
 		/* Ignore unknown notification codes sent to INT3400 device */
 		break;
-- 
2.14.3
