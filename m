From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH] thermal: step_wise: set throttle target within thermal instance limits
Date: Mon,  8 Apr 2013 16:56:11 -0700
Message-ID: <1365465371-24652-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>
List-Id: linux-pm@vger.kernel.org

When selecting a target cooling state in get_target_state(), make sure
that the state is at least as high as the minimum when the temperature
is rising and at least as low as the maximum when the temperature is
falling.  Previously the cooling level would only be incremented or
decremented by one in these cases.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/thermal/step_wise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 0cd5e9f..49992a4 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -47,9 +47,13 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	if (trend == THERMAL_TREND_RAISING) {
 		cur_state = cur_state < instance->upper ?
 			    (cur_state + 1) : instance->upper;
+		if (cur_state < instance->lower)
+			cur_state = instance->lower;
 	} else if (trend == THERMAL_TREND_DROPPING) {
 		cur_state = cur_state > instance->lower ?
 			    (cur_state - 1) : instance->lower;
+		if (cur_state > instance->upper)
+			cur_state = instance->upper;
 	}
 
 	return cur_state;
-- 
1.8.1.3
