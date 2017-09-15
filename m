From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] thermal: of: Fix doc string phy mode -> trip type
Date: Fri, 15 Sep 2017 09:32:47 -0700
Message-ID: <20170915163247.12065-1-mdf@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:45376 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdIOQdF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2017 12:33:05 -0400
Received: by mail-pg0-f50.google.com with SMTP id 188so1809281pgb.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2017 09:33:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>

This function does not look for a phy mode, but a
trip type.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/thermal/of-thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d04ec3b9e5ff..4e23a09d8f63 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -730,7 +730,7 @@ static const char * const trip_types[] = {
 };
 
 /**
- * thermal_of_get_trip_type - Get phy mode for given device_node
+ * thermal_of_get_trip_type - Get trip type for given device_node
  * @np:	Pointer to the given device_node
  * @type: Pointer to resulting trip type
  *
-- 
2.14.1
