From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] thermal: core: Fix a memory leak in 'thermal_zone_device_register()' error handling path
Date: Sun, 16 Jul 2017 08:59:02 +0200
Message-ID: <dcc79547980dca6c42c16c60f76cf8b4cbd5a392.1500187753.git.christophe.jaillet@wanadoo.fr>
References: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:54076 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdGPG7L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 02:59:11 -0400
In-Reply-To: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'tz' is freed in some error handling paths but not in the main one.
So free it also here to avoid a memory leak.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5a51c740e372..9743f3e65eb0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1296,6 +1296,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 unregister:
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 	device_unregister(&tz->device);
+	kfree(tz);
 	return ERR_PTR(result);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
-- 
2.11.0
