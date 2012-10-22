From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] cpufreq: fix jiffies/cputime mixup in conservative/ondemand
 governors
Date: Mon, 22 Oct 2012 15:35:29 +0200
Message-ID: <m21ugq1vfi.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The function get_cpu_idle_time_jiffy in both the conservative and
ondemand governors use jiffies_to_usecs to convert a cputime value to
usecs which gives the wrong value on architectures where cputime and
jiffies use different units.  Only matters if NO_HZ is disabled, since
otherwise get_cpu_idle_time_us should already return a valid value, and
get_cpu_idle_time_jiffy isn't actually called.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 4 ++--
 drivers/cpufreq/cpufreq_ondemand.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index a152af7..96af7d5 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -112,9 +112,9 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 
 	idle_time = cur_wall_time - busy_time;
 	if (wall)
-		*wall = jiffies_to_usecs(cur_wall_time);
+		*wall = cputime_to_usecs(cur_wall_time);
 
-	return jiffies_to_usecs(idle_time);
+	return cputime_to_usecs(idle_time);
 }
 
 static inline cputime64_t get_cpu_idle_time(unsigned int cpu, cputime64_t *wall)
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 396322f..6c19a66 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -136,9 +136,9 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 
 	idle_time = cur_wall_time - busy_time;
 	if (wall)
-		*wall = jiffies_to_usecs(cur_wall_time);
+		*wall = cputime_to_usecs(cur_wall_time);
 
-	return jiffies_to_usecs(idle_time);
+	return cputime_to_usecs(idle_time);
 }
 
 static inline cputime64_t get_cpu_idle_time(unsigned int cpu, cputime64_t *wall)
-- 
1.8.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
