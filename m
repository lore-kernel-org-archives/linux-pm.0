From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 2/9] thermal: update driver license
Date: Tue, 23 Apr 2013 17:48:13 -0400
Message-ID: <1366753700-1412-3-git-send-email-eduardo.valentin@ti.com>
References: <1366753700-1412-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39069 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab3DWVtm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 17:49:42 -0400
In-Reply-To: <1366753700-1412-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

As per the comment at the top of this file, this is a GPLv2 driver.
This patch updates the driver license accordingly.

Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bea3884..a999b22 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -40,7 +40,7 @@
 
 MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 static DEFINE_IDR(thermal_tz_idr);
 static DEFINE_IDR(thermal_cdev_idr);
-- 
1.8.2.1.342.gfa7285d

