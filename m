From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 11/18] thermal/drivers/hisi: Convert long to int
Date: Thu, 19 Oct 2017 19:05:53 +0200
Message-ID: <1508432760-17847-11-git-send-email-daniel.lezcano@linaro.org>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54571 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755073AbdJSRIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 13:08:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id i124so17715713wmf.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2017 10:08:45 -0700 (PDT)
In-Reply-To: <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org

There is no point to specify the temperature as long variable, the int is
enough.

Replace all long variables to int, so making the code consistent.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index baa3853..5382073 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -85,12 +85,12 @@ static inline int hisi_thermal_step_to_temp(int step)
 	return HISI_TEMP_BASE + (step * HISI_TEMP_STEP);
 }
 
-static inline long hisi_thermal_temp_to_step(long temp)
+static inline int hisi_thermal_temp_to_step(int temp)
 {
 	return (temp - HISI_TEMP_BASE) / HISI_TEMP_STEP;
 }
 
-static inline long hisi_thermal_round_temp(int temp)
+static inline int hisi_thermal_round_temp(int temp)
 {
 	return hisi_thermal_step_to_temp(
 		hisi_thermal_temp_to_step(temp));
-- 
2.7.4
