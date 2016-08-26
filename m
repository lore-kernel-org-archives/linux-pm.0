From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [RFC PATCH  4/4] devfreq_cooling: fix unnecessary check of unsigned long value
Date: Fri, 26 Aug 2016 14:18:05 +0100
Message-ID: <20160826131805.14820-5-lukasz.luba@arm.com>
References: <20160826131805.14820-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbcHZNTY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 09:19:24 -0400
In-Reply-To: <20160826131805.14820-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, lukasz.luba@arm.com, javi.merino@arm.com, orjan.eide@arm.com

This patch changes the unnecessary check 'state < 0', while the state is
unsigned long.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 39f83ce..2e26b49 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -367,7 +367,7 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 	u32 static_power;
 	unsigned long dyn_power;
 
-	if (state < 0 || state >= dfc->freq_table_size)
+	if (state >= dfc->freq_table_size)
 		return -EINVAL;
 
 	freq = dfc->freq_table[state];
-- 
2.9.2

