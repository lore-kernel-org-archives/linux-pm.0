From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] cpufreq: s3c2416: fix forgotten driver_data conversions
Date: Sun, 23 Jun 2013 01:08:25 +0200
Message-ID: <201306230108.25639.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit 5070158804b5 (cpufreq: rename index as driver_data in
cpufreq_frequency_table) renamed the index field to driver_data.

But it seems some uses in the s3c2416 driver were forgotten.

So convert the last index users to read driver_data.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/cpufreq/s3c2416-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 6f41a77..ce5b9fc 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -312,7 +312,7 @@ static void __init s3c2416_cpufreq_cfg_regulator(struct s3c2416_data *s3c_freq)
 		if (freq->frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
 
-		dvfs = &s3c2416_dvfs_table[freq->index];
+		dvfs = &s3c2416_dvfs_table[freq->driver_data];
 		found = 0;
 
 		/* Check only the min-voltage, more is always ok on S3C2416 */
@@ -462,7 +462,7 @@ static int __init s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
 	freq = s3c_freq->freq_table;
 	while (freq->frequency != CPUFREQ_TABLE_END) {
 		/* special handling for dvs mode */
-		if (freq->index == 0) {
+		if (freq->driver_data == 0) {
 			if (!s3c_freq->hclk) {
 				pr_debug("cpufreq: %dkHz unsupported as it would need unavailable dvs mode\n",
 					 freq->frequency);
-- 
1.7.10.4

