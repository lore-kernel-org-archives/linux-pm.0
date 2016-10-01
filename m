From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] power: bq27xxx_battery: don't update poll_interval param if same
Date: Fri, 30 Sep 2016 21:45:30 -0700
Message-ID: <1475297130-18080-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34359 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbcJAEpg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Oct 2016 00:45:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>

To avoid canceling the delayed workqueue needlessly, and scheduling an
immediate polling. Check if the new poll_interval value is different
than the previous setting.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index d18802ca3327..e01cea9a395a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -404,10 +404,11 @@ static LIST_HEAD(bq27xxx_battery_devices);
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
 	struct bq27xxx_device_info *di;
+	unsigned int prev_val = *(unsigned int *) kp->arg;
 	int ret;
 
 	ret = param_set_uint(val, kp);
-	if (ret < 0)
+	if (ret < 0 || prev_val == *(unsigned int *) kp->arg)
 		return ret;
 
 	mutex_lock(&bq27xxx_list_lock);
-- 
2.7.4

