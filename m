From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/4] Thermal: dove: Remove redundant use of of_match_ptr
Date: Thu, 16 May 2013 15:58:09 +0530
Message-ID: <1368700091-6084-2-git-send-email-sachin.kamat@linaro.org>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58371 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3EPKlo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 06:41:44 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so2386887pab.27
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2013 03:41:42 -0700 (PDT)
In-Reply-To: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, sachin.kamat@linaro.org, Andrew Lunn <andrew@lunn.ch>

'dove_thermal_id_table' is always compiled in and the driver
is dependent on OF. Hence use of of_match_ptr is unnecessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/thermal/dove_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 900479e..49f9a0a 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -194,7 +194,7 @@ static struct platform_driver dove_thermal_driver = {
 	.driver = {
 		.name = "dove_thermal",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(dove_thermal_id_table),
+		.of_match_table = dove_thermal_id_table,
 	},
 };
 
-- 
1.7.9.5

