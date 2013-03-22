From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH linux-pm] cpufreq: governors: Fix calculation of wall time
 in get_cpu_idle_time
Date: Fri, 22 Mar 2013 09:16:37 +0200
Message-ID: <514C0555.1010806@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With commit 8755a8ae31ba213db196324011a0da2a85807f25 the wall in
get_cpu_idle_time is not calculated, when we use ondemand with
io_is_busy = 1, preventing the CPU to increase to max frequency.

Properly, calculate wall time when we use io_is_busy.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index b49d45d..41e5e56 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -53,7 +53,7 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
 {
-	u64 idle_time = get_cpu_idle_time_us(cpu, NULL);
+	u64 idle_time = get_cpu_idle_time_us(cpu, io_busy ? wall : NULL);
 
 	if (idle_time == -1ULL)
 		return get_cpu_idle_time_jiffy(cpu, wall);
-- 
1.8.1.4

