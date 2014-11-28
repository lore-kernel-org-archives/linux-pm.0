From: Wang Weidong <wangweidong1@huawei.com>
Subject: [PATCH 2/2] cpufreq: show the real avail freqs with the freq_table
Date: Fri, 28 Nov 2014 10:43:39 +0800
Message-ID: <1417142619-14548-3-git-send-email-wangweidong1@huawei.com>
References: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: wangweidong1@huawei.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com
List-Id: linux-pm@vger.kernel.org

Some time, the policy's max_freq and min_freq will change, so
the avail freqs is not from the cpuinfo_min to cpuinfo_max.
Just add the check for the freq_table.

Signed-off-by: Wang Weidong <wangweidong1@huawei.com>
---
 drivers/cpufreq/freq_table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index df14766..4f86010 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -237,7 +237,9 @@ static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
 		 * show_boost = false and driver_data != BOOST freq
 		 * display NON BOOST freqs
 		 */
-		if (show_boost ^ (pos->flags & CPUFREQ_BOOST_FREQ))
+		if (pos->frequency < policy->min ||
+		    pos->frequency > policy->max ||
+		    show_boost ^ (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;
 
 		count += sprintf(&buf[count], "%d ", pos->frequency);
-- 
1.7.12
