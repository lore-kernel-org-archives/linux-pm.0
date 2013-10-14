From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] cpufreq: s3c64xx: Rename index to driver_data
Date: Mon, 14 Oct 2013 19:36:47 +0100
Message-ID: <1381775807-20144-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

The index field of cpufreq_frequency_table has been renamed to driver
data in this commit:

commit 5070158804b5339c71809f5e673cea1cfacd804d
cpufreq: rename index as driver_data in cpufreq_frequency_table

This patch updates the s3c64xx driver to match.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/cpufreq/s3c64xx-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 8a72b0c..15631f9 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -166,7 +166,7 @@ static void __init s3c64xx_cpufreq_config_regulator(void)
 		if (freq->frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
 
-		dvfs = &s3c64xx_dvfs_table[freq->index];
+		dvfs = &s3c64xx_dvfs_table[freq->driver_data];
 		found = 0;
 
 		for (i = 0; i < count; i++) {
-- 
1.7.2.5
