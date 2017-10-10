From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 11/25] thermal/drivers/hisi: Convert long to int
Date: Tue, 10 Oct 2017 20:02:36 +0200
Message-ID: <1507658570-32675-11-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52099 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932572AbdJJSFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 14:05:06 -0400
Received: by mail-wm0-f50.google.com with SMTP id f4so7717381wme.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 11:05:05 -0700 (PDT)
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org

There is no point to specify the temperature as long variable, the int is
enough.

Replace all long variables to int, so making the code consistent.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 70dc373..dabe9a8 100644
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
