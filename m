From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH] timekeeping: Cap array access in timekeeping_debug to protect against invalid sleep times
Date: Wed, 17 Aug 2016 12:18:50 -0700
Message-ID: <1471461530-19575-1-git-send-email-john.stultz@linaro.org>
References: <1469892465-15853-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469892465-15853-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Janek Kozicki <cosurgi@gmail.com>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

It was reported that hibernation could fail on the 2nd attempt,
where the system hangs at hibernate() -> syscore_resume() ->
i8237A_resume() -> claim_dma_lock(), because the lock has
already been taken.

However there is actually no other process would like to grab
this lock on that problematic platform.

Further investigation showed that the problem is triggered by
setting /sys/power/pm_trace to 1 before the 1st hibernation.

Since once pm_trace is enabled, the rtc becomes unmeaningful
after suspend, and meanwhile some BIOSes would like to adjust
the 'invalid' tsc(e.g, smaller than 1970) to the release date
of that motherboard during POST stage, thus after resumed, it
may seem that the system had a significant long sleep time might
due to meaningless tsc or RTC delta.

Then in timekeeping_resume -> tk_debug_account_sleep_time, if
the bit31 of the sleep time happened to be set to 1, the fls
returns 32 and then we add 1 to sleep_time_bin[32], which
caused a memory overwritten.

As depicted by System.map:
ffffffff81c9d080 b sleep_time_bin
ffffffff81c9d100 B dma_spin_lock
the dma_spin_lock.val is set to 1, which caused this problem.

This patch adds a sanity check in tk_debug_account_sleep_time()
to ensure we don't index past the sleep_time_bin array.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Janek Kozicki <cosurgi@gmail.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Xunlei Pang <xpang@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Reported-by: Janek Kozicki <cosurgi@gmail.com>
Reported-by: Chen Yu <yu.c.chen@intel.com>
[jstultz: Problem diagnosed and original patch by Chen Yu, I've
 solved the issue slightly differently, but borrowed his excelent
 explanation of of the issue here.]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/time/timekeeping_debug.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index f6bd652..107310a6 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -23,7 +23,9 @@
 
 #include "timekeeping_internal.h"
 
-static unsigned int sleep_time_bin[32] = {0};
+#define NUM_BINS 32
+
+static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
 static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
 {
@@ -69,6 +71,9 @@ late_initcall(tk_debug_sleep_time_init);
 
 void tk_debug_account_sleep_time(struct timespec64 *t)
 {
-	sleep_time_bin[fls(t->tv_sec)]++;
+	/* Cap bin index so we don't overflow the array */
+	int bin = min(fls(t->tv_sec), NUM_BINS-1);
+
+	sleep_time_bin[bin]++;
 }
 
-- 
1.9.1
