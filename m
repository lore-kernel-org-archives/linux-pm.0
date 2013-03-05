From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 2/3 linux-next] cpufreq: conservative: Fix the logic in frequency
 decrease  checking
Date: Wed, 06 Mar 2013 00:06:40 +0200
Message-ID: <51366C70.3020406@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

When we evaluate the CPU load for frequency decrease we have to compare
the load against down_threshold. There is no need to subtract 10 points
from down_threshold.

Instead, we have to use the default down_threshold or user's selection
unmodified.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq_conservative.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 1e3be56..08be431 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -92,12 +92,8 @@ static void cs_check_cpu(int cpu, unsigned int load)
 		return;
 	dbs_info->down_skip = 0;
 
-	/*
-	 * The optimal frequency is the frequency that is the lowest that can
-	 * support the current CPU usage without triggering the up policy. To be
-	 * safe, we focus 10 points under the threshold.
-	 */
-	if (load < (cs_tuners.down_threshold - 10)) {
+	/* Check for frequency decrease */
+	if (load < cs_tuners.down_threshold) {
 		freq_target = (cs_tuners.freq_step * policy->max) / 100;
 
 		dbs_info->requested_freq -= freq_target;
-- 
1.8.1.4
