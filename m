From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/4] Thermal: armada: Remove redundant use of of_match_ptr
Date: Thu, 16 May 2013 15:58:08 +0530
Message-ID: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:51515 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3EPKlk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 06:41:40 -0400
Received: by mail-da0-f42.google.com with SMTP id r6so304586dad.1
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2013 03:41:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, sachin.kamat@linaro.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

'armada_thermal_id_table' is always compiled in and the driver
is dependent on OF. Hence use of of_match_ptr is unnecessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 0d02d4e..9426bbd 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -220,7 +220,7 @@ static struct platform_driver armada_thermal_driver = {
 	.driver = {
 		.name = "armada_thermal",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(armada_thermal_id_table),
+		.of_match_table = armada_thermal_id_table,
 	},
 };
 
-- 
1.7.9.5

