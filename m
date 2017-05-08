From: Colin King <colin.king@canonical.com>
Subject: [PATCH] thermal: core: make thermal_emergency_poweroff static
Date: Mon,  8 May 2017 11:36:43 +0100
Message-ID: <20170508103643.10748-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48820 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbdEHKgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 06:36:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Making thermal_emergency_poweroff static fixes sparse warning:

  drivers/thermal/thermal_core.c:6: warning: symbol
  'thermal_emergency_poweroff' was not declared. Should it be static?

Fixes: ef1d87e06ab4 ("thermal: core: Add a back up thermal shutdown mechanism")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b21b9cc2c8d6..5a51c740e372 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -359,7 +359,7 @@ static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
  * This may be called from any critical situation to trigger a system shutdown
  * after a known period of time. By default this is not scheduled.
  */
-void thermal_emergency_poweroff(void)
+static void thermal_emergency_poweroff(void)
 {
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
 	/*
-- 
2.11.0
