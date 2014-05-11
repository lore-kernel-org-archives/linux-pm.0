From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] cpufreq: powernv: make local function static
Date: Sun, 11 May 2014 00:51:20 -0700
Message-ID: <1399794680-22210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

powernv_cpufreq_get() is only referenced in this file.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/powernv-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index af4968813e76..bb1d08dc8cc8 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -235,7 +235,7 @@ static void powernv_read_cpu_freq(void *arg)
  * firmware for CPU 'cpu'. This value is reported through the sysfs
  * file cpuinfo_cur_freq.
  */
-unsigned int powernv_cpufreq_get(unsigned int cpu)
+static unsigned int powernv_cpufreq_get(unsigned int cpu)
 {
 	struct powernv_smp_call_data freq_data;
 
-- 
1.9.1

