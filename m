From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 060/119] timekeeping: Cap array access in timekeeping_debug
Date: Thu, 29 Sep 2016 12:24:56 +0200
Message-ID: <4a47090ab9b6aef293efb11472112df2cf44323f.1475144721.git.jslaby@suse.cz>
References: <a528a0fa6d67ebe60bfc762c72b316d28ed21dea.1475144721.git.jslaby@suse.cz>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47349 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755209AbcI2K1E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 06:27:04 -0400
In-Reply-To: <a528a0fa6d67ebe60bfc762c72b316d28ed21dea.1475144721.git.jslaby@suse.cz>
In-Reply-To: <cover.1475144721.git.jslaby@suse.cz>
References: <cover.1475144721.git.jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Xunlei Pang <xpang@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>

From: John Stultz <john.stultz@linaro.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit a4f8f6667f099036c88f231dcad4cf233652c824 upstream.

It was reported that hibernation could fail on the 2nd attempt, where the
system hangs at hibernate() -> syscore_resume() -> i8237A_resume() ->
claim_dma_lock(), because the lock has already been taken.

However there is actually no other process would like to grab this lock on
that problematic platform.

Further investigation showed that the problem is triggered by setting
/sys/power/pm_trace to 1 before the 1st hibernation.

Since once pm_trace is enabled, the rtc becomes unmeaningful after suspend,
and meanwhile some BIOSes would like to adjust the 'invalid' RTC (e.g, smaller
than 1970) to the release date of that motherboard during POST stage, thus
after resumed, it may seem that the system had a significant long sleep time
which is a completely meaningless value.

Then in timekeeping_resume -> tk_debug_account_sleep_time, if the bit31 of the
sleep time happened to be set to 1, fls() returns 32 and we add 1 to
sleep_time_bin[32], which causes an out of bounds array access and therefor
memory being overwritten.

As depicted by System.map:
0xffffffff81c9d080 b sleep_time_bin
0xffffffff81c9d100 B dma_spin_lock
the dma_spin_lock.val is set to 1, which caused this problem.

This patch adds a sanity check in tk_debug_account_sleep_time()
to ensure we don't index past the sleep_time_bin array.

[jstultz: Problem diagnosed and original patch by Chen Yu, I've solved the
 issue slightly differently, but borrowed his excelent explanation of the
 issue here.]

Fixes: 5c83545f24ab "power: Add option to log time spent in suspend"
Reported-by: Janek Kozicki <cosurgi@gmail.com>
Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Xunlei Pang <xpang@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: http://lkml.kernel.org/r/1471993702-29148-3-git-send-email-john.stultz@linaro.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/time/timekeeping_debug.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index 802433a4f5eb..81f575a773ea 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -21,7 +21,9 @@
 #include <linux/seq_file.h>
 #include <linux/time.h>
 
-static unsigned int sleep_time_bin[32] = {0};
+#define NUM_BINS 32
+
+static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
 static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
 {
@@ -67,6 +69,9 @@ late_initcall(tk_debug_sleep_time_init);
 
 void tk_debug_account_sleep_time(struct timespec *t)
 {
-	sleep_time_bin[fls(t->tv_sec)]++;
+	/* Cap bin index so we don't overflow the array */
+	int bin = min(fls(t->tv_sec), NUM_BINS-1);
+
+	sleep_time_bin[bin]++;
 }
 
-- 
2.10.0

