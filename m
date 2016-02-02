From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] thermal: devfreq_cooling: remove impossible condition
Date: Tue,  2 Feb 2016 13:02:06 +0530
Message-ID: <1454398326-5365-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-pm@vger.kernel.org

state is an unsigned long and can never be less than 0.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
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
1.9.1
