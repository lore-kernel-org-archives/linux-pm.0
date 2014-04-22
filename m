From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [RESEND][PATCH] cpuidle: governor: menu: move repeated correction factor check to init
Date: Tue, 22 Apr 2014 18:08:04 +0530
Message-ID: <1398170284-7551-1-git-send-email-chander.kashyap@linaro.org>
References: <CANuQgHFdYhTc8YZ2MbQv0r_CsJGDLwHOqy9NuVDEfVUOTsbRpA@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:35301 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaDVMiR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 08:38:17 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so4881128pbc.7
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 05:38:17 -0700 (PDT)
In-Reply-To: <CANuQgHFdYhTc8YZ2MbQv0r_CsJGDLwHOqy9NuVDEfVUOTsbRpA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: tuukka.tikkanen@linaro.org, rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chander Kashyap <chander.kashyap@linaro.org>

In menu_select function we check for correction factor every time.
If it is zero we are initializing to unity. Hence move it to init function
and initialise by unity, hence avoid repeated comparisons.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Reviewed-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
---
 drivers/cpuidle/governors/menu.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 71b5232..9b7918c 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -311,13 +311,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	data->bucket = which_bucket(data->next_timer_us);
 
 	/*
-	 * if the correction factor is 0 (eg first time init or cpu hotplug
-	 * etc), we actually want to start out with a unity factor.
-	 */
-	if (data->correction_factor[data->bucket] == 0)
-		data->correction_factor[data->bucket] = RESOLUTION * DECAY;
-
-	/*
 	 * Force the result of multiplication to be 64 bits even if both
 	 * operands are 32 bits.
 	 * Make sure to round up for half microseconds.
@@ -466,9 +459,17 @@ static int menu_enable_device(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev)
 {
 	struct menu_device *data = &per_cpu(menu_devices, dev->cpu);
+	int i;
 
 	memset(data, 0, sizeof(struct menu_device));
 
+	/*
+	 * if the correction factor is 0 (eg first time init or cpu hotplug
+	 * etc), we actually want to start out with a unity factor.
+	 */
+	for(i = 0; i < BUCKETS; i++)
+		data->correction_factor[i] = RESOLUTION * DECAY;
+
 	return 0;
 }
 
-- 
1.7.9.5

