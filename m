From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] thermal/intel_powerclamp: add const to thermal_cooling_device_ops structure
Date: Wed, 21 Jun 2017 12:39:48 +0530
Message-ID: <1498028988-12916-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33743 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdFUHMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 03:12:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: julia.lawall@lip6.fr, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Declare thermal_cooling_device_ops structure as const as it is only passed
as an argument to the function thermal_cooling_device_register and this
argument is of type const. So, declare the structure as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/thermal/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index d718cd1..e4c68b7 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -659,7 +659,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 }
 
 /* bind to generic thermal layer as cooling device*/
-static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
+static const struct thermal_cooling_device_ops powerclamp_cooling_ops = {
 	.get_max_state = powerclamp_get_max_state,
 	.get_cur_state = powerclamp_get_cur_state,
 	.set_cur_state = powerclamp_set_cur_state,
-- 
2.7.4
