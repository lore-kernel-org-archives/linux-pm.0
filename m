From: Xiaoguang Chen <chenxg@marvell.com>
Subject: [PATCH 2/2] cpufreq: conservative: set requested_freq to policy max when it is over policy max
Date: Fri, 8 Nov 2013 13:23:52 +0800
Message-ID: <1383888232-27049-2-git-send-email-chenxg@marvell.com>
References: <1383888232-27049-1-git-send-email-chenxg@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383888232-27049-1-git-send-email-chenxg@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chenxg@marvell.com, chenxg.marvell@gmail.com
List-Id: linux-pm@vger.kernel.org

When requested_freq is over policy->max, set it to policy->max.
This can help to speed up decreasing frequency.

Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 218460f..25a70d0 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -68,6 +68,9 @@ static void cs_check_cpu(int cpu, unsigned int load)
 
 		dbs_info->requested_freq += get_freq_target(cs_tuners, policy);
 
+		if (dbs_info->requested_freq > policy->max)
+			dbs_info->requested_freq = policy->max;
+
 		__cpufreq_driver_target(policy, dbs_info->requested_freq,
 			CPUFREQ_RELATION_H);
 		return;
-- 
1.8.0
