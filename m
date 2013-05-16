From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/4] Thermal: spear: Remove redundant use of of_match_ptr
Date: Thu, 16 May 2013 15:58:11 +0530
Message-ID: <1368700091-6084-4-git-send-email-sachin.kamat@linaro.org>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39690 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3EPKlt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 06:41:49 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so2195777pbc.21
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2013 03:41:49 -0700 (PDT)
In-Reply-To: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, sachin.kamat@linaro.org, Vincenzo Frascino <vincenzo.frascino@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

'spear_thermal_id_table' is always compiled in and the driver
is dependent on OF. Hence use of of_match_ptr is unnecessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/spear_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 1a14eaa..dcb5f6f 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -197,7 +197,7 @@ static struct platform_driver spear_thermal_driver = {
 		.name = "spear_thermal",
 		.owner = THIS_MODULE,
 		.pm = &spear_thermal_pm_ops,
-		.of_match_table = of_match_ptr(spear_thermal_id_table),
+		.of_match_table = spear_thermal_id_table,
 	},
 };
 
-- 
1.7.9.5

