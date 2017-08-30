From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 11/13] thermal/drivers/hisi: Convert long to int
Date: Wed, 30 Aug 2017 10:47:35 +0200
Message-ID: <1504082857-21702-11-git-send-email-daniel.lezcano@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There is no point to specify the temperature as long variable, the int is
enough.

Replace all long variables to int, so making the code consistent.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 68b625c..9eee82b 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -83,12 +83,12 @@ static inline int hisi_thermal_step_to_temp(int step)
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
