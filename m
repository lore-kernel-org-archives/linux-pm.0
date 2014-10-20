From: Yao Dongdong <yaodongdong@huawei.com>
Subject: [PATCH 1/2] Thermal:Fix memory leak if occur goto unregister
Date: Mon, 20 Oct 2014 16:27:36 +0800
Message-ID: <5444C778.8050008@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:44699 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbaJTI2H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 04:28:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, yaodongdong@huawei.com

Signed-off-by:yaodongdong@huawei.com

---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 71b0ec0..5b7d466 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1574,6 +1574,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 unregister:
    release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
    device_unregister(&tz->device);
+   kfree(tz);
    return ERR_PTR(result);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
--
1.8.0.1


