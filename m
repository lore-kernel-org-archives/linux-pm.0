From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] devfreq_cooling: no need to check state with negative number
Date: Mon, 22 Aug 2016 16:08:06 +0800
Message-ID: <1471853286-10432-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:45785 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbcHVINA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 04:13:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We could see that state is defined as unsigned type, so it
should never be less than zero. Let' remove this check.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 01f0015..81631b1 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -312,7 +312,7 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 	unsigned long freq;
 	u32 static_power;
 
-	if (state < 0 || state >= dfc->freq_table_size)
+	if (state >= dfc->freq_table_size)
 		return -EINVAL;
 
 	freq = dfc->freq_table[state];
-- 
2.3.7


