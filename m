From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH] thermal: step_wise: set throttle target within thermal instance limits
Date: Tue,  9 Apr 2013 14:59:47 -0700
Message-ID: <1365544787-22940-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f201.google.com ([209.85.210.201]:34093 "EHLO
	mail-ia0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761010Ab3DIV7u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Apr 2013 17:59:50 -0400
Received: by mail-ia0-f201.google.com with SMTP id k25so783277iah.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2013 14:59:50 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>

When selecting a target cooling state in get_target_state(), make sure
that the state is at least as high as the minimum when the temperature
is rising and at least as low as the maximum when the temperature is
falling.  This is necessary because, in the THREAML_TREND_RAISING and
THERMAL_TREND_DROPPING cases, the current state may only be incremented
or decremented by one even if it is outside the bounds of the thermal
instance.  This might occur, for example, if the CPU is heating up
and hits a thermal trip point for the first time when it's frequency
is much higher than the range specified by the thermal instance
corresponding to the trip point.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/thermal/step_wise.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 407cde3..ca4f79f 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -59,9 +59,12 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 
 	switch (trend) {
 	case THERMAL_TREND_RAISING:
-		if (throttle)
+		if (throttle) {
 			cur_state = cur_state < instance->upper ?
 				    (cur_state + 1) : instance->upper;
+			if (cur_state < instance->lower)
+				cur_state = instance->lower;
+		}
 		break;
 	case THERMAL_TREND_RAISE_FULL:
 		if (throttle)
@@ -71,8 +74,11 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 		if (cur_state == instance->lower) {
 			if (!throttle)
 				cur_state = -1;
-		} else
+		} else {
 			cur_state -= 1;
+			if (cur_state > instance->upper)
+				cur_state = instance->upper;
+		}
 		break;
 	case THERMAL_TREND_DROP_FULL:
 		if (cur_state == instance->lower) {
-- 
1.8.1.3

