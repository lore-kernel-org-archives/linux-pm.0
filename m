From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 5/6] PM / devfreq: Modify the indentation of trans_stat sysfs
 for readability
Date: Thu, 19 Nov 2015 17:17:49 +0900
Message-ID: <1447921070-6045-6-git-send-email-cw00.choi@samsung.com>
References: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch modifies the indentation of 'trans_stat' sysfs to improve readability.
The 1GHz is 1000,000,000. So it needs the least 10 position to show the GHz unit.

- Before apply this patch,
-sh-3.2# cat trans_stat
   From  :   To
         :50000000100000000133000000200000000400000000   time(ms)
*50000000:       0       0       0       0       7   1817635
 100000000:       4       0       0       0       4      1590
 133000000:       1       4       0       0       7       975
 200000000:       2       2       7       0       1      2655
 400000000:       0       2       5      12       0      1860
Total transition : 58

- After apply this patch,
-sh-3.2# cat trans_stat
     From  :   To
           :  50000000 100000000 133000000 200000000 400000000   time(ms)
*  50000000:         0         0         0         0         7     14405
  100000000:         4         0         0         0         3      2015
  133000000:         2         3         0         0         7      1020
  200000000:         1         2         7         0         0      2970
  400000000:         0         2         5        10         0      1575
Total transition : 53

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 761e46a95c4b..c292ceb7ff19 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1048,10 +1048,10 @@ static ssize_t trans_stat_show(struct device *dev,
 			devfreq_update_status(devfreq, devfreq->previous_freq))
 		return 0;
 
-	len = sprintf(buf, "   From  :   To\n");
-	len += sprintf(buf + len, "         :");
+	len = sprintf(buf, "     From  :   To\n");
+	len += sprintf(buf + len, "           :");
 	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%8ld",
+		len += sprintf(buf + len, "%10ld",
 				devfreq->profile->freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
@@ -1063,10 +1063,10 @@ static ssize_t trans_stat_show(struct device *dev,
 		} else {
 			len += sprintf(buf + len, " ");
 		}
-		len += sprintf(buf + len, "%8ld:",
+		len += sprintf(buf + len, "%10ld:",
 				devfreq->profile->freq_table[i]);
 		for (j = 0; j < max_state; j++)
-			len += sprintf(buf + len, "%8u",
+			len += sprintf(buf + len, "%10u",
 				devfreq->trans_table[(i * max_state) + j]);
 		len += sprintf(buf + len, "%10u\n",
 			jiffies_to_msecs(devfreq->time_in_state[i]));
-- 
1.9.1
