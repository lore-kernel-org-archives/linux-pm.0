From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin array
Date: Tue, 19 Jul 2016 12:51:01 +0800
Message-ID: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysock" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>, "Stable # 3 . 17+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

It is reported the hibernation fails at 2nd attempt, which
hangs at hibernate() -> syscore_resume() -> i8237A_resume()
-> claim_dma_lock(), because the lock has already been taken.
However there is actually no other process would like to grab
this lock on that problematic platform.

Further investigation shows that, the problem is caused by setting
/sys/power/pm_trace to 1 before the 1st hibernation, since once
pm_trace is enabled, the rtc becomes an unmeaningful value after resumed,
which might bring a significant long sleep time in timekeeping_resume,
thus in tk_debug_account_sleep_time, if the bit31 happened to be set to 1,
the fls might return 32 and then we add 1 to sleep_time_bin[32], which
caused a memory overwritten. As System.map shows:

ffffffff81c9d080 b sleep_time_bin
ffffffff81c9d100 B dma_spin_lock

Thus set the dma_spin_lock.val to 1, which caused this problem.

To fix this problem, we ignore those abnormal sleep time,
since no one would like to sleep that long.

Cc: Stable <stable@vger.kernel.org> # 3.17+
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-and-tested-by: Janek Kozicki <cosurgi@gmail.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/time/timekeeping_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index f6bd652..b164bb9 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -24,6 +24,7 @@
 #include "timekeeping_internal.h"
 
 static unsigned int sleep_time_bin[32] = {0};
+#define MAX_SLEEP_TIME 0x7fffffff
 
 static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
 {
@@ -69,6 +70,7 @@ late_initcall(tk_debug_sleep_time_init);
 
 void tk_debug_account_sleep_time(struct timespec64 *t)
 {
-	sleep_time_bin[fls(t->tv_sec)]++;
+	if ((t->tv_sec >= 0) && (t->tv_sec <= MAX_SLEEP_TIME))
+		sleep_time_bin[fls(t->tv_sec)]++;
 }
 
-- 
2.7.4
