From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/4] Thermal: kirkwood: Remove redundant use of of_match_ptr
Date: Thu, 16 May 2013 15:58:10 +0530
Message-ID: <1368700091-6084-3-git-send-email-sachin.kamat@linaro.org>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33617 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3EPKlq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 06:41:46 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so509574pbc.16
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2013 03:41:45 -0700 (PDT)
In-Reply-To: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, sachin.kamat@linaro.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

'kirkwood_thermal_id_table' is always compiled in and the driver
is dependent on OF. Hence use of of_match_ptr is unnecessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/thermal/kirkwood_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index b57a45d..944ac49 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -120,7 +120,7 @@ static struct platform_driver kirkwood_thermal_driver = {
 	.driver = {
 		.name = "kirkwood_thermal",
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(kirkwood_thermal_id_table),
+		.of_match_table = kirkwood_thermal_id_table,
 	},
 };
 
-- 
1.7.9.5

