From: Brian Bian <brian.bian@linux.intel.com>
Subject: [PATCH] thermal: int3400_thermal: Ignore Unknown Notification Codes
Date: Tue, 14 Nov 2017 09:36:36 -0800
Message-ID: <1510680996-25468-1-git-send-email-brian.bian@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:1675 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756054AbdKNRgl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Nov 2017 12:36:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Brian Bian <brian.bian@linux.intel.com>

Some BIOS implementations route ACPI codes other than 0x83 to INT3400
device. Ignore these ACPI notification codes because the INT3400 driver
does not handle them.

Signed-off-by: Brian Bian <brian.bian@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 8ee38f5..c9db1c6 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -211,7 +211,7 @@ static void int3400_notify(acpi_handle handle,
 				thermal_prop);
 		break;
 	default:
-		dev_err(&priv->adev->dev, "Unsupported event [0x%x]\n", event);
+		/* Ignore unknown notification codes sent to INT3400 device */
 		break;
 	}
 }
-- 
2.7.4
