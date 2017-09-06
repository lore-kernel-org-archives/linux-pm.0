From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal/drivers/step_wise: Fix temperature regulation misbehavior
Date: Wed,  6 Sep 2017 08:58:46 +0200
Message-ID: <1504681126-30751-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, john.stultz@linaro.org, leo.yan@linaro.org
List-Id: linux-pm@vger.kernel.org

There is a particular situation when the cooling device is cpufreq and the heat
dissipation is not efficient enough where the temperature increases little by
little until reaching the critical threshold and leading to a SoC reset.

The behavior is reproducible on a hikey6220 with bad heat dissipation (eg.
stacked with other boards).

Running a simple C program doing while(1); for each CPU of the SoC makes the
temperature to reach the passive regulation trip point and ends up to the
maximum allowed temperature followed by a reset.

What is observed is a ping pong between two cpu frequencies, 1.2GHz and 900MHz
while the temperature continues to grow.

It appears the step wise governor calls get_target_state() the first time with
the throttle set to true and the trend to 'raising'. The code selects logically
the next state, so the cpu frequency decreases from 1.2GHz to 900MHz, so far so
good. The temperature decreases immediately but still stays greater than the
trip point, then get_target_state() is called again, this time with the
throttle set to true *and* the trend to 'dropping'. From there the algorithm
assumes we have to step down the state and the cpu frequency jumps back to
1.2GHz. But the temperature is still higher than the trip point, so
get_target_state() is called with throttle=1 and trend='raising' again, we jump
to 900MHz, then get_target_state() is called with throttle=1 and
trend='dropping', we jump to 1.2GHz, etc ... but the temperature does not
stabilizes and continues to increase.

Keeping the next_target untouched when 'throttle' is true at 'dropping' time
fixes the issue.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/step_wise.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index be95826..a01259a 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -94,9 +94,11 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			if (!throttle)
 				next_target = THERMAL_NO_TARGET;
 		} else {
-			next_target = cur_state - 1;
-			if (next_target > instance->upper)
-				next_target = instance->upper;
+			if (!throttle) {
+				next_target = cur_state - 1;
+				if (next_target > instance->upper)
+					next_target = instance->upper;
+			}
 		}
 		break;
 	case THERMAL_TREND_DROP_FULL:
-- 
2.7.4
