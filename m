From: Alex Shi <alex.shi@linaro.org>
Subject: [RFC PATCH] cpuidle: reduce unnecessary loop in c-state selection
Date: Thu, 16 Jan 2014 20:45:16 +0800
Message-ID: <1389876316-27161-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52684 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaAPMph (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2014 07:45:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so2634761pab.33
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2014 04:45:36 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, Alex Shi <alex.shi@linaro.org>

All deeper c-state have the longer target_residency and exit_latency
So, if the one can not meet our prediction, neither any later.
So, just break out the for loop to save few checking instructions.

Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index cf7f2f0..48ed3fb 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -352,11 +352,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		if (s->disabled || su->disable)
 			continue;
 		if (s->target_residency > data->predicted_us)
-			continue;
+			break;
 		if (s->exit_latency > latency_req)
-			continue;
+			break;
 		if (s->exit_latency * multiplier > data->predicted_us)
-			continue;
+			break;
 
 		data->last_state_idx = i;
 		data->exit_us = s->exit_latency;
-- 
1.8.1.2

