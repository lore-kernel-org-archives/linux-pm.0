From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 10/20] cpufreq: powernow-k6: Use cpufreq_for_each_entry macro
 for iteration
Date: Tue, 15 Apr 2014 00:09:36 +0300
Message-ID: <534C4E90.7030406@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq core supports the cpufreq_for_each_entry macro helper
for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/powernow-k6.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index 49f120e..9b1d1f4 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -159,6 +159,7 @@ static int powernow_k6_target(struct cpufreq_policy *policy,
 
 static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 {
+	struct cpufreq_frequency_table *pos;
 	unsigned int i, f;
 	unsigned khz;
 
@@ -176,8 +177,8 @@ static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 		}
 	}
 	if (param_max_multiplier) {
-		for (i = 0; (clock_ratio[i].frequency != CPUFREQ_TABLE_END); i++) {
-			if (clock_ratio[i].driver_data == param_max_multiplier) {
+		cpufreq_for_each_entry(pos, clock_ratio) {
+			if (pos->driver_data == param_max_multiplier) {
 				max_multiplier = param_max_multiplier;
 				goto have_max_multiplier;
 			}
@@ -209,12 +210,12 @@ have_busfreq:
 	param_busfreq = busfreq * 10;
 
 	/* table init */
-	for (i = 0; (clock_ratio[i].frequency != CPUFREQ_TABLE_END); i++) {
-		f = clock_ratio[i].driver_data;
+	cpufreq_for_each_entry(pos, clock_ratio) {
+		f = pos->driver_data;
 		if (f > max_multiplier)
-			clock_ratio[i].frequency = CPUFREQ_ENTRY_INVALID;
+			pos->frequency = CPUFREQ_ENTRY_INVALID;
 		else
-			clock_ratio[i].frequency = busfreq * f;
+			pos->frequency = busfreq * f;
 	}
 
 	/* cpuinfo and default policy values */
-- 
1.9.0
